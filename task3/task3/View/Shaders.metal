//
//  Shaders.metal
//  task3
//
//  Created by georg on 22.05.25.
//

#include <metal_stdlib>
using namespace metal;

struct Vertex {
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};

struct VertexOut {
    float4 position [[ position ]];
    float4 color;
};

struct Uniforms {
    float4x4 modelViewProjectionMatrix;
};

vertex VertexOut vertex_main(const device Vertex *vertices [[ buffer(0) ]],
                             constant Uniforms &uniforms [[ buffer(1) ]],
                             uint vertexId [[ vertex_id ]])
{
    VertexOut out;
    float4 pos = float4(vertices[vertexId].position, 1.0);
    out.position = uniforms.modelViewProjectionMatrix * pos;
    out.color = vertices[vertexId].color;
    return out;
}

fragment float4 fragment_main(VertexOut in [[ stage_in ]])
{
    return in.color;
}


