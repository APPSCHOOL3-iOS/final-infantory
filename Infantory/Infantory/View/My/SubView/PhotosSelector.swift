//
//  PhotosSelector.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import SwiftUI
import PhotosUI
import Photos

struct PhotosSelector: View {
    @StateObject var photosSelectorStore = PhotosSelectorStore.shared // 프로필사진 싱글톤 메서드
    @State private var cameraSheetShowing = false
    @State var showActionSheet: Bool = false
    @State private var isSheetPresented = false
    @State var profileImage: String = ""
    @State var selectedItem: PhotosPickerItem? = nil
    @State var selectedImageData: Data? = nil
    
    
    var body: some View {
        VStack {
            CachedImage(url: photosSelectorStore.profileImage ?? "") { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 65, height: 65)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 65, height: 65)
                        .clipShape(Circle())
                        .clipped()
                case .failure:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 65, height: 65)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack {
                HStack(alignment: .top) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 160, height: 30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.infanDarkGray, lineWidth: 1)
                            )
                            .foregroundColor(.white)
                            .padding(2)
                        Button {
                            cameraSheetShowing = true
                        } label: {
                            Text("사진촬영")
                                .font(.infanHeadlineBold)
                                .foregroundColor(.infanDarkGray)
                        }
                    }
                    
                    PhotosPicker(
                        selection: $photosSelectorStore.selectedItem,
                        matching: .any(of: [.images]),
                        photoLibrary: .shared()) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 160, height: 30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.infanDarkGray, lineWidth: 1)
                                    )
                                    .foregroundColor(.white)
                                    .padding(2)
                                Text("앨범에서 선택")
                                    .font(.infanHeadlineBold)
                                    .foregroundColor(.infanDarkGray)
                            }
                        }
                        .onChange(of: photosSelectorStore.selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    photosSelectorStore.selectedImageData = data
                                    photosSelectorStore.uploadImageToFirebase(imageData: data)
                                }
                                photosSelectorStore.showAlert.toggle()
                            }
                        }
                }
                .padding()
            }
            .sheet(isPresented: $cameraSheetShowing) {
                UseCameraView()
            }
        }
    }
}

struct PhotosSelector_Previews: PreviewProvider {
    static var previews: some View {
        PhotosSelector(photosSelectorStore: PhotosSelectorStore())
    }
}
