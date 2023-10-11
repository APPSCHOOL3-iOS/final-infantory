//
//  UseCameraView.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import SwiftUI

struct UseCameraView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var photoStore = PhotosSelectorStore.shared
    @State var cameraAlertShowing: Bool = true
    @State var isShowingImagePicker: Bool = false
    @State var selectedImage: UIImage?
    var body: some View {
        VStack {
        }
        .onAppear {
            cameraAlertShowing = true
        }
        .alert(isPresented: $cameraAlertShowing) {
            Alert(title: Text("주의"),
                  message: Text("카메라 기능은 실물 아이폰에서만 작동됩니다."),
                  primaryButton: .cancel(Text("실행"), action: {
                isShowingImagePicker = true
            }),
                  secondaryButton: .destructive(Text("취소"), action: {
                presentationMode.wrappedValue.dismiss()
            }))
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
    func loadImage() {
        let image = selectedImage
        if let data = image?.jpegData(compressionQuality: 0.9) {
                    photoStore.selectedImageData = data
                    photoStore.uploadImageToFirebase(imageData: data)
            }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var selectedImage: UIImage?
        
        init(selectedImage: Binding<UIImage?>) {
            _selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                self.selectedImage = selectedImage
            }
            
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImage: $selectedImage)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}

struct UseCameraView_Previews: PreviewProvider {
    static var previews: some View {
        UseCameraView()
    }
}
