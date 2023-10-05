//
//  AuctionImagePickerView.swift
//  Infantory
//
//  Created by 윤경환 on 10/4/23.
//

//import SwiftUI
//import Photos
//import UIKit
//
//struct AuctionImagePickerView: View {
//    @Binding var selectedImages: [UIImage]
//    @Binding var selectedImageNames: [String]
//    @State private var isImagePickerPresented = false
//    @State private var isGalleryPermissionGranted = false
//    
//    var body: some View {
//        VStack {
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    if selectedImages.count < 5 {
//                        Button {
//                            requestGalleryPermission()
//                            if isGalleryPermissionGranted {
//                                isImagePickerPresented.toggle()
//                            }
//                            
//                        } label: {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.gray, lineWidth: 1)
//                                    .frame(width: 100, height: 150)
//                                VStack {
//                                    Image(systemName: "plus")
//                                        .resizable()
//                                        .frame(width: 30, height: 30)
//                                        .foregroundColor(.black)
//                                        .padding()
//                                }
//                            }
//                        }
//                    }
//                    ForEach(selectedImages, id: \.self) { image in
//                        Image(uiImage: image)
//                            .resizable()
//                            .cornerRadius(10)
//                            .frame(width: 100, height: 150)
//                            .padding(.leading, 5)
//                            .aspectRatio(contentMode: .fill)
//                            .overlay(alignment: .topTrailing) {
//                                Button {
//                                    guard let index = selectedImages.firstIndex(where: {
//                                        $0 == image
//                                    }) else {
//                                        return
//                                    }
//                                    selectedImages.remove(at: index)
//                                    selectedImageNames.remove(at: index)
//                                } label: {
//                                    Image(systemName: "xmark.square.fill")
//                                        .foregroundColor(.black)
//                                }
//                            }
//                    }
//                }
//            }
//            .sheet(isPresented: $isImagePickerPresented) {
//                MultiPhotoPickerView(selectedImages: $selectedImages, selectedImageNames: $selectedImageNames)
//            }
//        }
//        .padding()
//    }
//    
//    func requestGalleryPermission() {
//        PHPhotoLibrary.requestAuthorization { status in
//            DispatchQueue.main.async {
//                if status == .authorized {
//                    isGalleryPermissionGranted = true
//                } else {
//                    isGalleryPermissionGranted = false
//                }
//            }
//        }
//    }
//}
//
//struct MultiPhotoPickerView: UIViewControllerRepresentable {
//    @Binding var selectedImages: [UIImage]
//    @Binding var selectedImageNames: [String]
//    @Environment(\.presentationMode) private var presentationMode
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
//            if let imageURL = info[.imageURL] as? URL
//            {
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
//
//struct AuctionImagePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ApplyImagePickerView(selectedImages: .constant([]), selectedImageNames: .constant([""]))
//    }
//}
