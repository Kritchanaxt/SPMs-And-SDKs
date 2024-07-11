//
//  SDWebImages.swift
//  SwiftuiSPMsAndSDKs
//
//  Created by Kritchanat on 10/7/2567 BE.
//

import SwiftUI
import SDWebImageSwiftUI

struct SDWebImageLoader: View {
    
    let url: String
    var contentMode: ContentMode = .fill
    
    var body: some View {
        WebImage(url: URL(string: url))
            .onSuccess(perform: { image, data, cacheType in
                // ทำอะไรบางอย่างเมื่อโหลดภาพสำเร็จ (ถ้าต้องการ)
            })
            .onFailure(perform: { error in
                // ทำอะไรบางอย่างเมื่อโหลดภาพล้มเหลว (ถ้าต้องการ)
            })
//            .placeholder(content: {
//                Color.gray.opacity(0.3) // แสดง placeholder เป็นสีเทาขณะกำลังโหลดภาพ
//            })
            .resizable()
            .indicator(.activity) // แสดง placeholder เป็นสีเทาขณะกำลังโหลดภาพ
            .aspectRatio(contentMode: contentMode)
    }
}


struct SDWebImages: View {
    
    var body: some View {
        ImageLoader(
            url: "https://picsum.photos/id/237/200/300",
            contentMode: .fill
        )
        .frame(width: 200, height: 200)
        .onAppear {
//            ImagePrefetcher.instance.startPrefetching(urls: urls)
        }
    }
}

#Preview {
    SDWebImages()
}
