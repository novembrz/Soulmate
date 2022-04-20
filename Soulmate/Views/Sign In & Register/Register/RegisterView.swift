//
//  RegisterView.swift
//  Soulmate
//
//  Created by dasha on 20.02.2022.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var viewModel: RegisterViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 34) {
                VStack(spacing: 0) {
                    backButton
                    photoButton
                }
                textFields
                professions
                registerButton
            }
        }
        .padding(.horizontal, Constants.horizontalInset)
        .padding(.top, Constants.topInset)
        .background(Color.defaultBackground)
        //.onChange(of: viewModel.isSuccessReg) { _ in dismiss() }
        .showBanner(isShowing: $viewModel.isErrorAuth, message: viewModel.errorText ?? "", notificationType: .error)
        .showBanner(isShowing: $viewModel.isSuccessReg, message: viewModel.successRegMessage, notificationType: .message)
        .showLoading(isShowing: $viewModel.isLoading)
    }
    
    
    //MARK: - Photo Button
    
    var photoButton: some View {
        Button {
            viewModel.isPhotoPickerOpened = true
        } label: {
            ZStack(alignment: .topTrailing) {
                if viewModel.avatarImage == nil {
                    ZStack {
                        Circle()
                            .fill(LinearGradient.diagonalGradient)
                            .frame(width: 143, height: 143)
                        
                        Image("plus")
                            .resizable()
                            .frame(width: 62, height: 62)
                            .foregroundColor(.white)
                    }
                } else {
                    Image(uiImage: viewModel.avatarImage!)
                        .resizable()
                        .frame(width: 143, height: 143)
                        .cornerRadius(100)
                }
                questionButton
            }
        }
        .sheet(isPresented: $viewModel.isPhotoPickerOpened) {
            PhotoPickerView(image: $viewModel.avatarImage)
        }
    }
    
    
    //MARK: - Question Button
    
    var questionButton: some View {
        Button {} label: {
            ZStack {
                Circle()
                    .fill(Color.whiteToDark)
                    .frame(width: 30, height: 30)
                   .buttonShadow()
                
                Image("question")
                    .resizable()
                    .frame(width: 14.5, height: 14.5)
                    .foregroundColor(.mintGreen)
            }
        }
    }
    
    
    //MARK: - textFields
    
    var textFields: some View {
        VStack(spacing: 34) {
            VStack(spacing: 12) {
                CustomTextField(field: $viewModel.name, icon: "userLight", placeholder: "Имя")
                CustomTextField(field: $viewModel.lastName, icon: "userLight", placeholder: "Фамилия")
            }
            
            HStack(spacing: 7) {
                birthPicker
                CustomTextField(field: $viewModel.city, icon: "homeLight", placeholder: "Город")
            }
        }
    }
    
    var birthPicker: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.whiteToDark)
                .cornerRadius(15)
                .frame(height: 47)
            
            HStack(spacing: 0) {
                Image("gift")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 11)
                    .foregroundColor(.placeholder)
                
                DatePicker("", selection: $viewModel.birthDate, in: ...Date(), displayedComponents: .date)
                    .accentColor(.mintGreen)
                    .opacity(0.5)
                    .labelsHidden()
                    .padding(.horizontal, 6)
            }
            .padding(.leading, 12)
        }
    }
    
    
    //MARK: - Professions
    
    var professions: some View {
        VStack(alignment: .leading, spacing: 25) {
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("Экспертные области")
                        .mediumFont(18)
                        .foregroundColor(.blackText)
                    
                    Button {
                        withAnimation {
                            viewModel.usersMockProf[viewModel.usersMockProf.count - 1].append(Profession(id: viewModel.usersMockProf.count, name: "Олень", main: false))
                        }
                    } label: {
                        Image("plusBold")
                            .resizable()
                            .foregroundColor(.blackText)
                            .frame(width: 20, height: 20)
                    }
                }
                
                Text("Галочкой отметьте основную профессию")
                    .mediumFont(12)
                    .foregroundColor(.mintGreen)
            }
            
            if viewModel.usersMockProf != [] {
                chips
            }
        }
    }
    
    
    //MARK: - Chips
    //Удаление профессии(зажатием и свайпом), кто главный, меню профессий, проверка на 4 (сложить каунты всех массивов в массиве)
    
    var chips: some View {
        LazyVStack(alignment: .leading) {
            ForEach(viewModel.usersMockProf.indices, id: \.self) { index in
                HStack {
                    ForEach(viewModel.usersMockProf[index].indices, id: \.self) { cellIndex in
                        var profession = viewModel.usersMockProf[index][cellIndex]
                        
                        SphereCell(title: profession.name,
                                   isChoose: profession.main,
                                   sphereType: .checkmarkCell)
                            .overlay(
                                GeometryReader { reader -> Color in
                                    let maxX = reader.frame(in: .global).maxX
                                    if maxX > UIScreen.width - 32 && !profession.isExceeded {
                                        DispatchQueue.global().async {
                                            profession.isExceeded = true
                                            viewModel.usersMockProf.append([profession])
                                            viewModel.usersMockProf[index].remove(at: cellIndex)
                                        }
                                    }
                                    return .clear
                                }
                                , alignment: .leading
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
        }
    }
    
    
    //MARK: - Register Button
    
    var registerButton: some View {
        Button {
            viewModel.registerUser()
        } label: {
            LongButton(title: "Зарегестрироваться", isGradient: true)
        }
    }
    
    
    //MARK: - Back Button
    
    var backButton: some View {
        HStack {
            BackButton()
            Spacer()
        }
    }
    
}


//MARK: - Previews

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel())
            .preferredColorScheme(.dark)
    }
}
