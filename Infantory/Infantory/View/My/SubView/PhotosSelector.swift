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
    @StateObject var photoStore = PhotosSelectorStore.shared // 프로필사진 싱글톤 메서드
    @State private var cameraSheetShowing = false
    @State var showActionSheet: Bool = false
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack {
            CachedImage(url: photoStore.profileImage ?? "") { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .clipped()
                case .failure:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
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
                        selection: $photoStore.selectedItem,
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
                .padding()
            }
            .sheet(isPresented: $cameraSheetShowing) {
                UseCameraView()
            }
            .onAppear {
                photoStore.getProfileImageDownloadURL()
            }
        }
    }
    // actionSheet 함수
    func getActionSheet() -> ActionSheet {
        
        let button1: ActionSheet.Button = .default(Text("앨범에서 선택")) {
            isSheetPresented = true
        }
        let button2: ActionSheet.Button = .default(Text("사진 찍기")) {
            cameraSheetShowing = true
        }
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
