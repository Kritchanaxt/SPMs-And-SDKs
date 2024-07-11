//
//  SDWebImages.swift
//  SwiftuiSPMsAndSDKs
//
//  Created by Kritchanat on 10/7/2567 BE.
//

/*
 
MARK: SDWebImageSwiftUI
 - เป็นไลบรารีที่ใช้ในการโหลดและแสดงภาพจากอินเทอร์เน็ตในแอปพลิเคชัน SwiftUI อย่างมีประสิทธิภาพ มีฟีเจอร์หลายอย่าง
 - เช่น การแสดง placeholder ขณะที่ภาพกำลังโหลด, การแสดง indicator ขณะที่กำลังโหลดภาพ, และการ prefetch รูปภาพเพื่อทำให้การแสดงผลภาพเร็วขึ้นเมื่อจำเป็นต้องใช้งาน
 
*/

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoader: View {
    
    let url: String
    var contentMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                SDWebImageLoader(url: url, contentMode: contentMode)
            )
            .clipped()
    }
}

fileprivate struct SDWebImageLoader: View {
    
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
//            .placeholder {
//                Color.gray.opacity(0.3) // แสดง placeholder เป็นสีเทาขณะกำลังโหลดภาพ
//            }
            .resizable()
            .indicator(.activity) // แสดง placeholder เป็นสีเทาขณะกำลังโหลดภาพ
            .aspectRatio(contentMode: contentMode)
    }
}

final class ImagePrefetcher {
    
    static let instance = ImagePrefetcher()
    private let prefetcher = SDWebImagePrefetcher()
    
    private init() {}
    
    func startPrefetching(urls: [URL]) {
        prefetcher.prefetchURLs(urls)
    }
    
    func stopPrefetching() {
        prefetcher.cancelPrefetching()
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
            let urls = [
                URL(string: "https://picsum.photos/id/237/200/300"),
                URL(string: "https://picsum.photos/id/238/200/300"),
                URL(string: "https://picsum.photos/id/239/200/300")
            ].compactMap { $0 }
            ImagePrefetcher.instance.startPrefetching(urls: urls)
        }
    }
}

#Preview {
    SDWebImages()
}
