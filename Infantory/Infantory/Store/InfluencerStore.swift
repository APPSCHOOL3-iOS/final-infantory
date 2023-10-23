//
//  InfluencerStore.swift
//  Infantory
//
//  Created by 민근의 mac on 10/16/23.
//

import SwiftUI
import FirebaseFirestore

final class InfluencerStore: ObservableObject {
    @Published var influencer: User = User()
    @Published var selectedCategory: InfluencerCategory = .auction
    @Published var influencerApplyProduct: [ApplyProduct] = []
    @Published var influencerAuctionProduct: [AuctionProduct] = []
    @Published var isFollow: Bool = false
    @Published var followCount: Int = 0
    
    func fetchInfluencer(influencerID: String) async throws {
        let query = try await Firestore.firestore().collection("Users").document(influencerID).getDocument()
        DispatchQueue.main.async {
            do {
                self.influencer = User()
                self.influencer = try query.data(as: User.self)
            } catch {
                print("error: 인플루언서를 불러오지 못했습니다.")
            }
        }
    }
    
    func fetchInfluencerApplyProduct(influencerID: String) async throws {
        DispatchQueue.main.async {
            self.influencerApplyProduct = []
        }
        let query = Firestore.firestore().collection("ApplyProducts").whereField("influencerID", isEqualTo: influencerID)
        let snapshot = try await query.getDocuments()
        let documents = snapshot.documents
        for document in documents {
            do {
                var influencerProduct = try document.data(as: ApplyProduct.self)
                influencerProduct.influencerProfile = influencer.profileImageURLString
                var nowInfluencerProduct = self.influencerApplyProduct
                nowInfluencerProduct.append(influencerProduct)
                let sortedArray = nowInfluencerProduct.sorted {
                    $0.registerDate > $1.registerDate
                }
                DispatchQueue.main.async {
                    self.influencerApplyProduct = sortedArray
                }
            } catch {
                print("error: 해당 인플루언서의 응모 상품을 불러오지 못했습니다.")
            }
        }
    }
    
    func fetchInfluencerAuctionProduct(influencerID: String) async throws {
        DispatchQueue.main.async {
            self.influencerAuctionProduct = []
        }
        let query = Firestore.firestore().collection("AuctionProducts").whereField("influencerID", isEqualTo: influencerID)
        let snapshot = try await query.getDocuments()
        let documents = snapshot.documents
        for document in documents {
            do {
                var influencerProduct = try document.data(as: AuctionProduct.self)
                influencerProduct.influencerProfile = influencer.profileImageURLString
                var nowInfluencerProduct = self.influencerAuctionProduct
                nowInfluencerProduct.append(influencerProduct)
                let sortedArray = nowInfluencerProduct.sorted {
                    $0.registerDate > $1.registerDate
                }
                DispatchQueue.main.async {
                    self.influencerAuctionProduct = sortedArray
                }
            } catch {
                print("error: 해당 인플루언서의 경매 상품을 불러오지 못했습니다.")
            }
        }
    }
    
    // 팔로우 추가함수
    func followInfluencer(influencerID: String, userID: String) {
        let documentReference = Firestore.firestore().collection("Users").document(userID)
        documentReference.getDocument { (document, error) in
            if let document = document, document.exists {
                // 문서가 존재하는 경우, 현재 배열 필드 값을 가져옵니다.
                var currentArray = document.data()?["follow"] as? [String]? ?? []
                currentArray?.append(influencerID)
                
                var followers: [String] = []
                if currentArray == nil {
                    followers.append(influencerID)
                }
                
                // 업데이트된 배열을 Firestore에 다시 업데이트합니다.
                documentReference.updateData(["follow": currentArray == nil ? followers : currentArray ?? []]) { (error) in
                    if error != nil {
                    } else {
                        self.followerInfluencer(influencerID: influencerID, userID: userID)
                    }
                }
            }
        }
    }
    
    func followerInfluencer(influencerID: String, userID: String) {
        let documentReference = Firestore.firestore().collection("Users").document(influencerID)
        documentReference.getDocument { (document, error) in
            if let document = document, document.exists {
                // 문서가 존재하는 경우, 현재 배열 필드 값을 가져옵니다.
                var currentArray = document.data()?["follower"] as? [String]? ?? []
                currentArray?.append(userID)
                
                var followers: [String] = []
                if currentArray == nil {
                    followers.append(userID)
                }
                
                // 업데이트된 배열을 Firestore에 다시 업데이트합니다.
                documentReference.updateData(["follower": currentArray == nil ? followers : currentArray ?? []]) { (error) in
                    if error != nil {
                    } else {
                        Task {
                            try await self.fetchFollower(influencerID: influencerID, userID: userID)
                        }
                    }
                }
            }
        }
    }
    
    func fetchFollower(influencerID: String, userID: String) async throws {
        let documentReference = Firestore.firestore().collection("Users").document(influencerID)
        let snapshot = try await documentReference.getDocument()
        
        let currentArray = snapshot.data()?["follower"] as? [String]? ?? []
        if let followArray = currentArray {
            if followArray.contains(userID) {
                DispatchQueue.main.async {
                    self.isFollow = true
                    self.followCount = currentArray?.count ?? 0
                }
            } else {
                DispatchQueue.main.async {
                    self.isFollow = false
                    self.followCount = currentArray?.count ?? 0
                }
            }
        }
    }
    
    func fetchFollow(influencerID: String, userID: String) async throws {
        let documentReference = Firestore.firestore().collection("Users").document(userID)
        let snapshot = try await documentReference.getDocument()
        
        let currentArray = snapshot.data()?["follow"] as? [String]? ?? []
        
    }
    
    func unfollowInfluencer(influencerID: String, userID: String) {
        let documentReference = Firestore.firestore().collection("Users").document(userID)
        documentReference.getDocument { (document, error) in
            if let document = document, document.exists {
                // 문서가 존재하는 경우, 현재 배열 필드 값을 가져옵니다.
                var currentArray = document.data()?["follow"] as? [String]? ?? []
                if let index = currentArray?.firstIndex(of: influencerID) {
                    currentArray?.remove(at: index)
                }
                
                // 업데이트된 배열을 Firestore에 다시 업데이트합니다.
                documentReference.updateData(["follow": currentArray ?? []]) { (error) in
                    if error != nil {
                    } else {
                        self.unfollowerInfluencer(influencerID: influencerID, userID: userID)
                    }
                }
            }
        }
    }
    
    func unfollowerInfluencer(influencerID: String, userID: String) {
        let documentReference = Firestore.firestore().collection("Users").document(influencerID)
        documentReference.getDocument { (document, error) in
            if let document = document, document.exists {
                // 문서가 존재하는 경우, 현재 배열 필드 값을 가져옵니다.
                var currentArray = document.data()?["follower"] as? [String]? ?? []
                if let index = currentArray?.firstIndex(of: userID) {
                    currentArray?.remove(at: index)
                }
                
                // 업데이트된 배열을 Firestore에 다시 업데이트합니다.
                documentReference.updateData(["follower": currentArray ?? []]) { (error) in
                    if error != nil {
                    } else {
                        Task {
                            try await self.fetchFollower(influencerID: influencerID, userID: userID)
                        }
                    }
                }
            }
        }
    }
}

enum InfluencerCategory: String, CaseIterable {
    case auction = "경매"
    case apply = "응모"
}
