//
//  AddContentView.swift
//  Soulmate
//
//  Created by dasha on 19.02.2022.
//

import SwiftUI

struct SelectContentView: View {
    @State var title: String?
    @State var completion: ((ContentType) -> ())
    
    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            if title != nil {
                Text(title!)
                    .mediumFont(20)
            }
            
            VStack(alignment: .leading, spacing: 18) {
                ContentRow(contentType: .photo, completion: completion)
                ContentRow(contentType: .video, completion: completion)
                ContentRow(contentType: .music, completion: completion)
                ContentRow(contentType: .text, completion: completion)
            }
        }
        .padding(.horizontal, Constants.horizontalInset)
    }
}


//MARK: - ContentRow

struct ContentRow: View {
    @State var contentType: ContentType
    @State var completion: ((ContentType) -> ())
    
    var body: some View {
        Button {
            completion(contentType)
        } label: {
            HStack(spacing: 13) {
                Image(contentType.rawValue)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.blackText)
                
                Text(contentType.rawValue)
                    .mediumFont(16)
                    .foregroundColor(.blackText)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.blackText)
            }
            .padding(16)
            .background(Color.whiteToDark)
            .cornerRadius(15)
        }
    }
}


//MARK: - Previews

struct SelectContentView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
