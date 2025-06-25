//
//  MetalView.swift
//  task3
//
//  Created by georg on 22.05.25.
//


import MetalKit
import simd

class MetalView: MTKView {
    var commandQueue: MTLCommandQueue!
    var pipelineState: MTLRenderPipelineState!
    
    var vertexBuffer: MTLBuffer!
    var model: GameModel!
    
    var rotationX: Float = 0.0
    var rotationY: Float = 0.0
    var scale: Float = 1.0
    
    struct Uniforms {
        var modelViewProjectionMatrix: matrix_float4x4
    }
    
    var time: Float = 0.0
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initializeMetal()
    }
    
    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device)
        initializeMetal()
    }
    
    func initializeMetal() {
        self.device = MTLCreateSystemDefaultDevice()
        self.commandQueue = device?.makeCommandQueue()
        
        self.colorPixelFormat = .bgra8Unorm
        self.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        let defaultLibrary = device?.makeDefaultLibrary()
        let vertexFunction = defaultLibrary?.makeFunction(name: "vertex_main")
        let fragmentFunction = defaultLibrary?.makeFunction(name: "fragment_main")
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = colorPixelFormat
        
        do {
            pipelineState = try device?.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch let error {
            print("Ошибка создания render pipeline state: \(error)")
        }
        
        model = GameModel()
        vertexBuffer = device?.makeBuffer(bytes: model.vertices,
                                          length: MemoryLayout<Vertex>.stride * model.vertices.count,
                                          options: [])
        
        self.delegate = self
    }
}

extension MetalView: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
    func draw(in view: MTKView) {
        guard let drawable = currentDrawable,
              let renderPassDescriptor = currentRenderPassDescriptor else { return }
        
        time += 1 / Float(preferredFramesPerSecond)
        
        let aspect = Float(drawableSize.width / drawableSize.height)
        let projectionMatrix = matrix_float4x4.perspective(fovyRadians: radians(fromDegrees: 65),
                                                           aspect: aspect,
                                                           nearZ: 0.1,
                                                           farZ: 100)
        let viewMatrix = matrix_float4x4.translation(SIMD3<Float>(0, 0, -6))
        let modelMatrix = matrix_float4x4.rotation(radians: rotationX, axis: SIMD3<Float>(1, 0, 0)) *
                          matrix_float4x4.rotation(radians: rotationY, axis: SIMD3<Float>(0, 1, 0)) *
                          matrix_float4x4.scaling(SIMD3<Float>(repeating: scale))
        
        let mvpMatrix = projectionMatrix * viewMatrix * modelMatrix
        
        var uniforms = Uniforms(modelViewProjectionMatrix: mvpMatrix)
        let uniformBuffer = device?.makeBuffer(bytes: &uniforms,
                                               length: MemoryLayout<Uniforms>.stride,
                                               options: [])
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderEncoder?.setRenderPipelineState(pipelineState)
        renderEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder?.setVertexBuffer(uniformBuffer, offset: 0, index: 1)
        
        renderEncoder?.drawPrimitives(type: .triangle,
                                      vertexStart: 0,
                                      vertexCount: model.vertices.count)
        
        renderEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}

func radians(fromDegrees degrees: Float) -> Float {
    return (degrees / 180) * Float.pi
}


extension matrix_float4x4 {
    static func translation(_ t: SIMD3<Float>) -> matrix_float4x4 {
        var matrix = matrix_identity_float4x4
        matrix.columns.3 = SIMD4<Float>(t.x, t.y, t.z, 1)
        return matrix
    }
    
    static func scaling(_ s: SIMD3<Float>) -> matrix_float4x4 {
        var matrix = matrix_identity_float4x4
        matrix.columns.0.x = s.x
        matrix.columns.1.y = s.y
        matrix.columns.2.z = s.z
        return matrix
    }
    
    static func rotation(radians: Float, axis: SIMD3<Float>) -> matrix_float4x4 {
        let a = normalize(axis)
        let cos = cosf(radians)
        let sin = sinf(radians)
        var result = matrix_float4x4()
        
        result.columns.0 = SIMD4<Float>(cos + a.x * a.x * (1 - cos),
                                         a.x * a.y * (1 - cos) - a.z * sin,
                                         a.x * a.z * (1 - cos) + a.y * sin,
                                         0)
        
        result.columns.1 = SIMD4<Float>(a.y * a.x * (1 - cos) + a.z * sin,
                                         cos + a.y * a.y * (1 - cos),
                                         a.y * a.z * (1 - cos) - a.x * sin,
                                         0)
        
        result.columns.2 = SIMD4<Float>(a.z * a.x * (1 - cos) - a.y * sin,
                                         a.z * a.y * (1 - cos) + a.x * sin,
                                         cos + a.z * a.z * (1 - cos),
                                         0)
        
        result.columns.3 = SIMD4<Float>(0, 0, 0, 1)
        
        return result
    }
    
    static func perspective(fovyRadians: Float, aspect: Float, nearZ: Float, farZ: Float) -> matrix_float4x4 {
        let yScale = 1 / tan(fovyRadians * 0.5)
        let xScale = yScale / aspect
        let zRange = farZ - nearZ
        let zScale = -(farZ + nearZ) / zRange
        let wzScale = -2 * farZ * nearZ / zRange
        
        var result = matrix_float4x4()
        result.columns = (
            SIMD4<Float>(xScale, 0, 0, 0),
            SIMD4<Float>(0, yScale, 0, 0),
            SIMD4<Float>(0, 0, zScale, -1),
            SIMD4<Float>(0, 0, wzScale, 0)
        )
        return result
    }
}
