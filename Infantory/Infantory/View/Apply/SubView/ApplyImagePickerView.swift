import SwiftUI
import PhotosUI
import UIKit

struct ApplyImagePickerView: View {
    @Binding var selectedImages: [UIImage]
    @Binding var selectedImageNames: [String]
    @State private var isImagePickerPresented = false
    @State private var isGalleryPermissionGranted = false
    var configuration = PHPickerConfiguration()
    
    @State private var selectedAssets: [PHAsset] = []
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if selectedImages.count < 5 {
                    Button {
                        requestGalleryPermission()
                        if isGalleryPermissionGranted {
                            isImagePickerPresented.toggle()
                        }
                        
                    } label: {
                        ZStack {
                            
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.infanGray, lineWidth: 2)
                                .frame(width: 100, height: 100)
                        }
                    }
                }
                
                ForEach(selectedImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 100, height: 100)
                        .padding(.leading, 5)
                        .aspectRatio(contentMode: .fill)
                        .overlay(alignment: .topTrailing) {
                            Button {
                                guard let index = selectedImages.firstIndex(where: {
                                    $0 == image
                                }) else {
                                    return
                                }
                                selectedImages.remove(at: index)
                            } label: {
                                Image(systemName: "xmark.square.fill")
                                    .foregroundColor(.black)
                            }
                        }
                }
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePickerView(selectedAssets: $selectedAssets, selectedImages: $selectedImages, selectedImageNames: $selectedImageNames)
        }
    }
    
    func requestGalleryPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                if status == .authorized {
                    isGalleryPermissionGranted = true
                } else {
                    isGalleryPermissionGranted = false
                }
            }
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedAssets: [PHAsset]
    @Binding var selectedImages: [UIImage]
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 5 - selectedImages.count // 선택 가능한 이미지 수를 제한합니다.
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePickerView
        
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for result in results {
                result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.selectedImages.append(image)
                            self.parent.selectedImageNames.append(result.itemProvider.suggestedName ?? "Unknown")
                        }
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func pickerDidCancel(_ picker: PHPickerViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

//struct MultiPhotoPickerView: UIViewControllerRepresentable {
//    @Binding var selectedImages: [UIImage]
//    @Binding var selectedImageNames: [String]
//    @Environment(\.presentationMode)
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<MultiPhotoPickerView>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.allowsEditing = false
//        picker.sourceType = .photoLibrary
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<MultiPhotoPickerView>) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: MultiPhotoPickerView
//
//        init(_ parent: MultiPhotoPickerView) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let imageURL = info[.imageURL] as? URL {
//                let selectedImageNames = imageURL.lastPathComponent
//                parent.selectedImageNames.append(selectedImageNames)
//            }
//            if let selectedImage = info[.originalImage] as? UIImage {
//                parent.selectedImages.append(selectedImage)
//                //                print(parent.selectedImages)
//            }
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//}

struct ApplyImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyImagePickerView(selectedImages: .constant([]), selectedImageNames: .constant([""]))
    }
}
