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
    @State var showActionSheet: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    showActionSheet.toggle()
                } label: {
                    Image("ProfileEdit")
                        .frame(width: 100, height: 100)
                        .opacity(0.5)
                }
                .actionSheet(isPresented: $showActionSheet, content: getActionSheet)
            }
        
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
    
    // actionSheet 함수
    func getActionSheet() -> ActionSheet {
        
        let button1: ActionSheet.Button = .default(Text("앨범에서 선택"))
        let button2: ActionSheet.Button = .default(Text("사진 찍기"))
        let button3: ActionSheet.Button = .destructive(Text("프로필 사진 삭제"))
        let button4: ActionSheet.Button = .cancel(Text("닫기"))
        let title = Text("원하는 옵션을 선택하세요")
        
        return ActionSheet(title: title,
                           message: nil,
                           buttons: [button1, button2, button3, button4])
    }
}





struct PhotosSelector_Previews: PreviewProvider {
    static var previews: some View {
        PhotosSelector(photoStore: PhotosSelectorStore())
    }
}

