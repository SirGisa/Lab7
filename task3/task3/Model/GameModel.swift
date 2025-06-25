//
//  GameModel.swift
//  task3
//
//  Created by georg on 22.05.25.
//


import Foundation
import simd

class GameModel {
    var vertices: [Vertex] = [
        // Front face
        Vertex(position: SIMD3(-1, -1,  1), color: SIMD4(1, 0, 0, 1)),
        Vertex(position: SIMD3( 1, -1,  1), color: SIMD4(0, 1, 0, 1)),
        Vertex(position: SIMD3(-1,  1,  1), color: SIMD4(0, 0, 1, 1)),
        
        Vertex(position: SIMD3( 1, -1,  1), color: SIMD4(0, 1, 0, 1)),
        Vertex(position: SIMD3( 1,  1,  1), color: SIMD4(1, 1, 0, 1)),
        Vertex(position: SIMD3(-1,  1,  1), color: SIMD4(0, 0, 1, 1)),
        
        // Back face
        Vertex(position: SIMD3( 1, -1, -1), color: SIMD4(1, 0, 1, 1)),
        Vertex(position: SIMD3(-1, -1, -1), color: SIMD4(0, 1, 1, 1)),
        Vertex(position: SIMD3( 1,  1, -1), color: SIMD4(1, 1, 1, 1)),
        
        Vertex(position: SIMD3(-1, -1, -1), color: SIMD4(0, 1, 1, 1)),
        Vertex(position: SIMD3(-1,  1, -1), color: SIMD4(1, 1, 1, 1)),
        Vertex(position: SIMD3( 1,  1, -1), color: SIMD4(1, 1, 1, 1)),
        
        // Left face
        Vertex(position: SIMD3(-1, -1, -1), color: SIMD4(1, 0, 0, 1)),
        Vertex(position: SIMD3(-1, -1,  1), color: SIMD4(0, 1, 0, 1)),
        Vertex(position: SIMD3(-1,  1, -1), color: SIMD4(0, 0, 1, 1)),
        
        Vertex(position: SIMD3(-1, -1,  1), color: SIMD4(0, 1, 0, 1)),
        Vertex(position: SIMD3(-1,  1,  1), color: SIMD4(1, 1, 0, 1)),
        Vertex(position: SIMD3(-1,  1, -1), color: SIMD4(0, 0, 1, 1)),
        
        // Right face
        Vertex(position: SIMD3( 1, -1,  1), color: SIMD4(1, 0, 1, 1)),
        Vertex(position: SIMD3( 1, -1, -1), color: SIMD4(0, 1, 1, 1)),
        Vertex(position: SIMD3( 1,  1,  1), color: SIMD4(1, 1, 1, 1)),
        
        Vertex(position: SIMD3( 1, -1, -1), color: SIMD4(0, 1, 1, 1)),
        Vertex(position: SIMD3( 1,  1, -1), color: SIMD4(1, 1, 1, 1)),
        Vertex(position: SIMD3( 1,  1,  1), color: SIMD4(1, 1, 1, 1)),
        
        // Top face
        Vertex(position: SIMD3(-1,  1,  1), color: SIMD4(0, 0, 1, 1)),
        Vertex(position: SIMD3( 1,  1,  1), color: SIMD4(1, 1, 0, 1)),
        Vertex(position: SIMD3(-1,  1, -1), color: SIMD4(1, 0, 1, 1)),
        
        Vertex(position: SIMD3( 1,  1,  1), color: SIMD4(1, 1, 0, 1)),
        Vertex(position: SIMD3( 1,  1, -1), color: SIMD4(0, 1, 1, 1)),
        Vertex(position: SIMD3(-1,  1, -1), color: SIMD4(1, 0, 1, 1)),
        
        // Bottom face
        Vertex(position: SIMD3(-1, -1, -1), color: SIMD4(0, 1, 1, 1)),
        Vertex(position: SIMD3( 1, -1, -1), color: SIMD4(1, 0, 1, 1)),
        Vertex(position: SIMD3(-1, -1,  1), color: SIMD4(1, 0, 0, 1)),
        
        Vertex(position: SIMD3( 1, -1, -1), color: SIMD4(1, 0, 1, 1)),
        Vertex(position: SIMD3( 1, -1,  1), color: SIMD4(0, 1, 0, 1)),
        Vertex(position: SIMD3(-1, -1,  1), color: SIMD4(1, 0, 0, 1)),
    ]
}
