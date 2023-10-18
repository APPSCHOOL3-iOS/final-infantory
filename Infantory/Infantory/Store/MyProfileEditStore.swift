//
//  MyStore.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/13.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class MyProfileEditStore: ObservableObject {
    private let dbRef = Firestore.firestore().collection("Users")
    private let storage = Storage.storage().reference()
    
    var urlFullPath: String = "aha"
    
    func updateUser(image: UIImage? = nil,
                    imageURL: String? = nil,
                    nickName: String,
                    phoneNumber: String,
                    address: String,
                    zonecode: String,
                    addressDetail: String,
                    userId: String) async throws {
        
        // 프사가 있다면
        if let image {
            // 스토리지에 업로드 후, URL을 유저에 저장한다
            uploadImage(image: image, userId: userId) { url in
                self.dbRef.document(userId).updateData([
                    "profileImageURLString": url,
                    "nickName": nickName,
                    "phoneNumber": phoneNumber,
                    "address": ["address": address,
                                "addressDetail": addressDetail,
                                "zonecode": zonecode]
                ])
            }
            
        } else {
            // 프사가 없으면 파이어스토어 - User 만 업데이트 한 후, 스토리지에 있는지 검사 후 삭제 해준다.
            try await self.dbRef.document(userId).updateData([
                "nickName": nickName,
                "phoneNumber": phoneNumber,
                "address": ["address": address,
                            "addressDetail": addressDetail,
                            "zonecode": zonecode]
            ])
            try await self.deleteProfileImage(userId: userId)
            
        }
    }
    
    func uploadImage(image: UIImage,
                     userId: String,
                     completion: @escaping ((String) -> Void)) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }
        let imageRef = storage.child("user/\(userId)/profileImage.jpeg") //경로
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        _ = imageRef.putData(imageData, metadata: metadata) { (_, error) in
            if let error = error {
#if DEBUG
                print("Error uploading image \(String(describing: index)): \(error.localizedDescription)")
#endif
            } else {
                imageRef.downloadURL { [weak self] url, error in
                    if let error = error {
#if DEBUG
                        print(error.localizedDescription)
#endif
                    } else {
                        print("======URL=====\n\(url)")
                        let url = url?.absoluteString ?? ""
                        completion(url)
                    }
#if DEBUG
                    print("Image \(String(describing: index)) uploaded successfully")
#endif
                }
            }
        }
    }
    
    private func deleteProfileImage(userId: String) async throws {
        do {
            try await storage.child("user/\(userId)/profileImage.jpeg")
                .delete()
        } catch {
#if DEBUG
            print("error. profileImageDelete")
#endif
        }
    }
}
