//
//  Kingfisher.swift
//  SwiftuiSPMsAndSDKs
//
//  Created by Kritchanat on 10/7/2567 BE.
//

import SwiftUI
import Kingfisher

struct KingfisherImageLoader: View {
    
    let url: String
    var contentMode: SwiftUI.ContentMode = .fill
    
    var body: some View {
        KFImage(URL(string: url))
            .placeholder {
                Color.red
            }
            .resizable()
            .onProgress({ receivedSize, totalSize in
                
            })
            .onSuccess({ error in
                
            })
            .aspectRatio(contentMode: contentMode)
        
//        KFImage.url(url)
//            .placeholder(placeholderImage)
//            .setProcessor(processor)
//            .loadDiskFileSynchronously()
//            .cacheMemoryOnly()
//            .fade(duration: 0.25)
//            .lowDataModeSource(.network(lowResolutionURL))
//            .onProgress { receivedSize, totalSize in }
//            .onSuccess { result in }
//            .onFailure { error in }
        
    }
}

#Preview {
    KingfisherImageLoader(
        url: "https://picsum.photos/id/237/200/300",
        contentMode: .fill
    )
    .frame(width: 200, height: 200)
}
