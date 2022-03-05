//
//  PhotoPickerView.swift
//  Soulmate
//
//  Created by dasha on 25.02.2022.
//

import SwiftUI

struct PhotoPickerView: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    
    //MARK: - Coordinator
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let photoPicker: PhotoPickerView
        
        init(photoPicker: PhotoPickerView) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                //let data = image.jpegData(compressionQuality: 0.1), compressedImage = UIImage(data: data)
                photoPicker.image = image
            }
            picker.dismiss(animated: true)
        }
    }
}


