//
//  PhotoStore.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import Foundation
import SwiftUI
import PhotosUI
import FirebaseStorage
import Combine

class PhotosSelectorStore: ObservableObject {
    static let shared = PhotosSelectorStore()
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedImageData: Data? = nil
    @Published var profileImage: String?
    @Published var showAlert: Bool = false
    var loginUserID: String = UserService.shared.currentUser?.id ?? "-------------UserID ERROR-------------"
    let basicImageUrl = "https://bigxdata.io/common/img/default_profile.png"
    private var loginUserIDCancellable: AnyCancellable?
    
    init() {
        loginUserIDCancellable = UserService.shared.$currentUser
            .compactMap { user in
                user?.id
            }
            .sink { [weak self] id in
                self?.loginUserID = id
            }
    }
    
    @MainActor
    func uploadImageToFirebase(imageData: Data) {
        let imageSizeInMB = Double(imageData.count) / (1024 * 1024)
        if imageSizeInMB > 3 {
            print("이미지크기가 3MB를 초과합니다.")
            return
        }
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("Users/Profiles/\(loginUserID).jpeg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imagesRef.putData(imageData, metadata: metadata) {metadata, error in
            if let error = error {
                print("이미지 업로드 에러 : \(error)")
            } else {
                print("프로필 이미지 업로드 성공")
                
                // 저장된 이미지의 다운로드 URL 가져오기
                imagesRef.downloadURL {url, error in
                    if let downloadURL = url {
                        print("이미지 다운로드 URL: \(downloadURL)")
                        self.profileImage = "\(downloadURL)"
                    }
                }
            }
        }
    }
    
    @MainActor
    func getProfileImageDownloadURL() {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("Users/Profiles/\(loginUserID).jpeg")
        imagesRef.downloadURL { url, error in
            if let downloadURL = url {
                print("프로필 이미지를 가져왔습니다.")
                self.profileImage = "\(downloadURL)"
            } else {
                print("프로필 이미지가 없습니다. 기본이미지 로드")
                self.profileImage = self.basicImageUrl
            }
        }
    }
}
