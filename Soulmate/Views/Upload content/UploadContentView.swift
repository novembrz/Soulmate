//
//  UploadContentView.swift
//  Soulmate
//
//  Created by dasha on 19.02.2022.
//

import SwiftUI

struct UploadContentView: View {
    
    @Binding var contentType: ContentType
    
    var body: some View {
        Text("Upload Content View \(contentType.rawValue)")
    }
}

//struct UploadContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadContentView(contentType: .text)
//    }
//}
