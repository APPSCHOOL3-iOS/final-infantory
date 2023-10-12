//
//  DressedUpImageView.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/12.
//

import SwiftUI
import PhotosUI
import UIKit

struct DressedUpImageView: View {
    @Binding var selectedImages: [UIImage]
    @Binding var selectedImageNames: [String]
    @State private var isImagePickerPresented = false
    @State private var isGalleryPermissionGranted = false
    
    @State private var selectedAssets: [PHAsset] = []
    
    var body: some View {
        VStack {
            HStack {
                Text("착장 사진")
                    .font(.system(size: 17))
                    .bold()
                Spacer()
                if selectedImages.count < 5 {
                    Button {
                        requestGalleryPermission()
                        if isGalleryPermissionGranted {
                            isImagePickerPresented.toggle()
                        }
                        
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                }
            }
            if selectedImages.count == 0 {
                Text("사진을 추가해주세요")
                    .font(.infanHeadline)
                    .padding()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
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
                                    selectedImageNames.remove(at: index)
                                } label: {
                                    Image(systemName: "xmark.square.fill")
                                        .foregroundColor(.black)
                                }
                            }
                    }
                }
                Spacer()
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

struct DressedUpImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedAssets: [PHAsset]
    @Binding var selectedImages: [UIImage]
    @Binding var selectedImageNames: [String]
    @Environment(\.presentationMode) private var presentationMode
    
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
        let parent: DressedUpImagePickerView
        
        init(parent: DressedUpImagePickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for result in results {
                result.itemProvider.loadObject(ofClass: UIImage.self) { (object, _) in
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

struct DressedUpImageView_Previews: PreviewProvider {
    static var previews: some View {
        DressedUpImageView(selectedImages: .constant([]), selectedImageNames: .constant([""]))
    }
}
