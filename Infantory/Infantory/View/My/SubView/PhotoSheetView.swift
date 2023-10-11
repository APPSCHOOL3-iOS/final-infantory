//
//  PhotoSheetView.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import SwiftUI
import PhotosUI
import Photos
import Kingfisher

struct PhotoSheetView: View {
    @StateObject var photoStore = PhotosSelectorStore.shared // 프로필 사진 싱글톤 메서드
    @State private var isImagePickerPresented = true // 갤러리 화면을 보이게 하려면 true로 설정
    
    var body: some View {
        PhotosPicker(
            selection: $photoStore.selectedItem,
            matching: .any(of: [.images]),
            photoLibrary: .shared()) {
                // 여기에 아무 내용도 표시하지 않음
            }
            .onChange(of: photoStore.selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        photoStore.selectedImageData = data
                        photoStore.uploadImageToFirebase(imageData: data)
                    }
                    photoStore.showAlert.toggle()
                }
            }
    }
}

struct PhotoSheetView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSheetView()
    }
}
