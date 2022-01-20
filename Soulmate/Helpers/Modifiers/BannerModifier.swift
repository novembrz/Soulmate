//
//  BannerModifier.swift
//  Soulmate
//
//  Created by dasha on 20.01.2022.
//

import SwiftUI


struct BannerModifier: ViewModifier {
    
    enum NotificationType {
        case message, content, error
    }
    
    
    @Binding var isShowing: Bool
    let duration: TimeInterval
    
    var message: String
    var imageName: String?
    var notificationType: NotificationType = .message
    
    @State var isMove = false
    let bannerHeight: CGFloat = 53
    var bannerShowOffset: CGFloat { -(UIScreen.height / 2) + 30 }
    var bannerHideOffset: CGFloat { -(UIScreen.height / 2) - 30  }
    
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isShowing {
                banner
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            withAnimation {
                                isMove = true
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation {
                                isShowing = false
                                isMove = false
                            }
                    }
                }
            }
        }
    }
    
    //MARK: - Banner
    
    private var banner: some View {
        ZStack {
            VStack {
                HStack(spacing: 11) {
                    if notificationType == .content, imageName != nil {
                        Image(imageName!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .cornerRadius(9)
                    }
                    
                    Text(message)
                        .boldFont(14)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.vertical, 8)
                .padding(.horizontal, notificationType == .content ? 8 : 20)
                .frame(minHeight: bannerHeight)
                .frame(maxWidth: .infinity)
                .background(notificationType == .error ? Color.error : Color.mintGreen)
                .cornerRadius(15)
                .elementShadow()
            }
            .offset(y: isMove ? bannerShowOffset : bannerHideOffset )
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.8), value: isMove)
        }
    }
}


//MARK: - View Extension

extension View {
    func showBanner(isShowing: Binding<Bool>, duration: TimeInterval = 3, message: String, imageName: String? = "", notificationType: BannerModifier.NotificationType = .message) -> some View {
        
        modifier(BannerModifier(isShowing: isShowing,
                             duration: duration,
                             message: message,
                             imageName: imageName,
                             notificationType: notificationType))
    }
}


//MARK: - Previews

struct TestView: View {
    @State private var isShowing: Bool = false
    
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                isShowing = true
            }
            .showBanner(isShowing: $isShowing, message: "Ваша жалоба отправлена!", imageName: "Petrov", notificationType: .content)
    }
}

struct WTFView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
