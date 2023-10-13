//
//  ProfileImagePicker.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/13.
//

import SwiftUI

struct ProfileImagePicker: UIViewControllerRepresentable {
    @Binding var selectedUIImageString: String?
    @Binding var selectedUIImage: UIImage?
    @Environment(\.presentationMode) var mode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

extension ProfileImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ProfileImagePicker
        
        init(_ parent: ProfileImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.parent.selectedUIImage = image
            self.parent.selectedUIImageString = UUID().uuidString
            parent.mode.wrappedValue.dismiss()
        }
    }
}
