//
//  AuctionRegisterStore.swift
//  Infantory
//
//  Created by 윤경환 on 10/4/23.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore

@MainActor
class ApplyRegisterStore: ObservableObject {
    
    private let dbRef = Firestore.firestore().collection("ApplyProducts")
    private let storage = Storage.storage().reference()
    
    init() {
        
    }
    
    func addApplyProduct(applyProduct: ApplyProduct,
                         images: [UIImage],
                         completion: @escaping (Bool) -> Void) async throws {
        var applyProduct = applyProduct
        await uploadImages(images, applyProduct: applyProduct) { urls in
            applyProduct.productImageURLStrings = urls
            do {
                try self.dbRef.addDocument(from: applyProduct)
            } catch {
                completion(false)
            }
            completion(true)
        }
    }
    
    func uploadImages(_ images: [UIImage],
                      applyProduct: ApplyProduct,
                      completion: @escaping ([String]) -> Void) async {
        
        var urlStringList: [String] = []
        for (index, image) in images.enumerated() {
            guard let imageData = image.jpegData(compressionQuality: 0.1) else {
                continue
            }
            let imageRef = storage.child("auctionProduct/\(applyProduct.id)/\(applyProduct.productImageURLStrings[index])") //경로
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
                            urlStringList.append(url?.absoluteString ?? "")
                            if urlStringList.count == images.count {
                                completion(urlStringList)
                            }
                        }
#if DEBUG
                        print("Image \(index) uploaded successfully")
#endif
                    }
                }
            }
        }
    }
    
    func makeApplyModel(title: String,
                        apply: String,
                        itemDescription: String,
                        imageStrings: [String],
                        user: User
    ) -> ApplyProduct {
        let product: ApplyProduct = ApplyProduct(productName: title,
                                                 productImageURLStrings: imageStrings,
                                                 description: itemDescription,
                                                 influencerID: user.id ?? UUID().uuidString,
                                                 influencerNickname: user.name,
                                                 startDate: Date(),
                                                 endDate: Date(),
                                                 applyUserIDs: [])
        
        return product
    }
}
