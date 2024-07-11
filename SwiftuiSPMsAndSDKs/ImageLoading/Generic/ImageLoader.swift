//
//  ImageLoader.swift
//  SwiftuiSPMsAndSDKs
//
//  Created by Kritchanat on 10/7/2567 BE.
//

import SwiftUI

struct ImageLoader: View {
    
    let url: String
    var contentMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
//                SDWebImageLoader(url: url, contentMode: contentMode)
                KingfisherImageLoader(url: url, contentMode: contentMode)
                //.allowsHitTesting(false)
            )
            .clipped()
    }
}

#Preview {
    ImageLoader(
        url: "https://picsum.photos/id/237/200/300",
        contentMode: .fill
    )
}
