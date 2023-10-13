//
//  MyStore.swift
//  Infantory
//
//  Created by 봉주헌 on 2023/10/13.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class MyStore: ObservableObject {
    
    private let dbRef = Firestore.firestore().collection("Users")
    private let storage = Storage.storage().reference()
    
    func updateUser(userId: String,
                    image: UIImage?,
                    imagename: String?,
                    nickName: String,
                    phoneNumber: String,
                    completion: @escaping (Bool) -> Void)
    async throws {
        if let image, let imagename {
            await uploadImage(image, userId: userId, imagename: imagename) { url in
                do {
                    try self.dbRef.document(userId).updateData([
                        "profileImageURLString": url,
                        "nickName": nickName,
                        "phoneNumber": phoneNumber
                    ]) { error in
                        print("update User Error")
                    }
                } catch {
                    completion(false)
                }
                completion(true)
            }
        } else {
            try self.dbRef.document(userId).updateData([
                "nickName": nickName,
                "phoneNumber": phoneNumber
            ]) { error in
                print("update User Error2")
            }
        }
    }
    
    func uploadImage(_ image: UIImage,
                     userId: String,
                     imagename: String,
                     completion: @escaping (String) -> Void) async {
        
        var urlString: String = ""
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }
        let imageRef = storage.child("user/\(userId)/\(imagename)") //경로
        _ = imageRef.putData(imageData, metadata: nil) { (_, error) in
            if let error = error {
#if DEBUG
                print("Error uploading image \(index): \(error.localizedDescription)")
#endif
            } else {
                imageRef.downloadURL { url, error in
                    if let error = error {
#if DEBUG
                        print(error.localizedDescription)
#endif
                    } else {
                        urlString = url?.absoluteString ?? ""
                        completion(urlString)
                    }
#if DEBUG
                    print("Image \(index) uploaded successfully")
#endif
                }
            }
        }
    }
}
