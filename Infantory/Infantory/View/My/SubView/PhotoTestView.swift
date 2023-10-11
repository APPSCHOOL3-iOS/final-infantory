//
//  PhotoTestView.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import SwiftUI
import PhotosUI
import Photos
import Kingfisher

struct PhotoTestView: View {
    @StateObject var photoStore = PhotosSelectorStore.shared
    @State private var cameraSheetShowing = false
    @State private var photoPickerShowing = false
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
            
            if photoPickerShowing {
                PhotosPicker(
                    selection: $photoStore.selectedItem,
                    matching: .any(of: [.images]),
                    photoLibrary: .shared()) {
                        
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
        .sheet(isPresented: $cameraSheetShowing) {
            UseCameraView()
        }
    }
    
    // actionSheet 함수
    func getActionSheet() -> ActionSheet {
        let title = Text("원하는 옵션을 선택하세요")
        let button1: ActionSheet.Button = .default(Text("앨범에서 선택")) {
            photoPickerShowing = true
        }
        
        let button2: ActionSheet.Button = .default(Text("사진 찍기")) {
            cameraSheetShowing = true
        }
        let button3: ActionSheet.Button = .destructive(Text("프로필 사진 삭제"))
        let button4: ActionSheet.Button = .cancel(Text("닫기"))
        
        return ActionSheet(title: title,
                           message: nil,
                           buttons: [button1, button2, button3, button4])
    }
}

struct PhotoTestView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoTestView(photoStore: PhotosSelectorStore())
    }
}

#Preview {
    PhotoTestView()
}
