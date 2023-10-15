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
    @State private var cameraSheetShowing = false
    
    @State var showImagePicker = false
    @Binding var selectedUIImage: UIImage?
    @Binding var selectedUIImageString: String?
    
    @State var selectedImage: Image?
    @State var image: Image?
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
        print("이미지 넘어옴")
    }
    
    var body: some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 80, height: 80)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 80, height: 80)
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
                                .font(.infanBody)
                                .foregroundColor(.infanDarkGray)
                        }
                    }
                    
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
                            showImagePicker.toggle()
                        } label: {
                            Text("앨범에서 선택")
                                .font(.infanBody)
                                .foregroundColor(.infanDarkGray)
                        }
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $showImagePicker, onDismiss: {
            loadImage()
        }) {
            ProfileImagePicker(selectedUIImageString: $selectedUIImageString, selectedUIImage: $selectedUIImage)
        }
        .sheet(isPresented: $cameraSheetShowing) {
            UseCameraView()
        }
    }
}
//
//struct PhotosSelector_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotosSelector(selectedUIImageString: .constant(nil), selectedImage: .constant(nil))
//    }
//}
