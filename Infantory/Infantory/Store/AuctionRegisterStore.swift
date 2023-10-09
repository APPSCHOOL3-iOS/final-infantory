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
class AuctionRegisterStore: ObservableObject {
    
    private let dbRef = Firestore.firestore().collection("AuctionProducts")
    private let storage = Storage.storage().reference()
    
    init() {
        
    }
    
    func addAuctionProduct(auctionProduct: AuctionProduct,
                           images: [UIImage],
                           completion: @escaping (Bool) -> Void) async throws {
        var auctionProduct = auctionProduct
        await uploadImages(images, auctionProduct: auctionProduct) { urls in
            auctionProduct.productImageURLStrings = urls
            do {
                try self.dbRef.addDocument(from: auctionProduct)
            } catch {
                completion(false)
            }
            completion(true)
        }
    }
    
    func uploadImages(_ images: [UIImage],
                      auctionProduct: AuctionProduct,
                      completion: @escaping ([String]) -> Void) async {
        
        var urlStringList: [String] = []
        for (index, image) in images.enumerated() {
            guard let imageData = image.jpegData(compressionQuality: 0.1) else {
                continue
            }
            let imageRef = storage.child("auctionProduct/\(auctionProduct.id)/\(auctionProduct.productImageURLStrings[index])") //경로
            
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

    func makeAuctionModel(title: String,
                          apply: String,
                          itemDescription: String,
                          startingPrice: String,
                          imageStrings: [String],
                          user: User
    ) -> AuctionProduct {
        let product: AuctionProduct = AuctionProduct(id: UUID().uuidString,
                                                     productName: title,
                                                     productImageURLStrings: imageStrings,
                                                     description: itemDescription,
                                                     influencerID: user.id ?? UUID().uuidString,
                                                     influencerNickname: user.name,
                                                     startDate: Date(),
                                                     endDate: Date(),
                                                     minPrice: Int(startingPrice) ?? 0,
                                                     winningPrice: Int(startingPrice))
        
        return product
    }
}
