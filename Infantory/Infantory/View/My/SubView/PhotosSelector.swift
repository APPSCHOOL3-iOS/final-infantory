//
//  PhotosSelector.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import SwiftUI
import PhotosUI
import Photos
import Kingfisher

struct PhotosSelector: View {
    @StateObject var photoStore = PhotosSelectorStore.shared // 프로필사진 싱글톤 메서드
    @State private var cameraSheetShowing = false
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.gray)
                .frame(width: 260, height: 260)
                .opacity(0.5)
                .shadow(radius: 10)
            if let image = photoStore.profileImage {
                KFImage(URL(string: image))
                    .onFailure({ error in
                        print("Error : \(error)")
                    })
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .clipped()
                
            }
            VStack {
                Spacer()
                HStack {
                    Button {
                        cameraSheetShowing = true
                    } label: {
                        Image(systemName: "camera.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    PhotosPicker(
                        selection: $photoStore.selectedItem,
                        matching: .any(of: [.images]),
                        photoLibrary: .shared()) {
                            Image(systemName: "photo.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
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
        }
        .frame(width: 250,height: 250)
        .sheet(isPresented: $cameraSheetShowing) {
            UseCameraView()
        }
    }
}




struct PhotosSelector_Previews: PreviewProvider {
    static var previews: some View {
        PhotosSelector(photoStore: PhotosSelectorStore())
    }
}

