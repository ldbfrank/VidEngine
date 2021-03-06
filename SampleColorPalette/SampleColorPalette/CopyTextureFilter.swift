//
//  CopyTextureFilter.swift
//  SampleColorPalette
//
//  Created by David Gavilan on 2018/03/03.
//  Copyright © 2018 David Gavilan. All rights reserved.
//

import VidFramework

class CopyTextureFilter: TextureFilter {
    init?(device: MTLDevice, library: MTLLibrary, input: Texture, output: Texture) {
        guard let vfn = library.makeFunction(name: "passThrough2DVertex"),
            let ffn = library.makeFunction(name: "passThroughFragment")
            else {
                NSLog("Failed to create shaders")
                return nil
        }
        guard let inputTexture = input.mtlTexture else {
            return nil
        }
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vfn
        pipelineDescriptor.fragmentFunction = ffn
        pipelineDescriptor.colorAttachments[0].pixelFormat = inputTexture.pixelFormat
        pipelineDescriptor.sampleCount = inputTexture.sampleCount
        super.init(id: "CopyTextureFilter", device: device, descriptor: pipelineDescriptor)
        inputs = [input]
        self.output = output
    }
}
