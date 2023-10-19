//
//  MyActivityStore.swift
//  Infantory
//
//  Created by 이희찬 on 10/19/23.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore

class MyActivityStore: ObservableObject {
    @Published var myBiddingPrice: Int = 0
    @Published var winningPrice: Int = 0
    
    @Published var myApplyCount: Int = 0
    @Published var totalApplyCount: Int = 0
    
    private var dbRef: DatabaseReference!
    private let firestore = Firestore.firestore()
    
    init() {
        self.dbRef = Database.database().reference()
    }
    
    func fetchMyLastBiddingPrice(userID: String, productID: String) {
        dbRef.child("biddingInfos/\(productID)")
            .queryOrdered(byChild: "userID")
            .queryEqual(toValue: userID)
            .observeSingleEvent(of: .value) { (snapshot) in
                if let infos = snapshot.children.allObjects as? [DataSnapshot] {
                    if let biddingInfo = infos.last?.value as? [String: AnyObject] {
                        self.myBiddingPrice = biddingInfo["biddingPrice"] as? Int ?? 0
                    }
                }
            }
    }
    
    func fetchWinningPrice(productID: String) {
        dbRef.child("biddingInfos/\(productID)")
            .queryOrdered(byChild: "timeStamp")
            .observe(.value) { (snapshot) in
                if let infos = snapshot.children.allObjects as? [DataSnapshot] {
                    if let biddingInfo = infos.last?.value as? [String: AnyObject] {
                        self.winningPrice = biddingInfo["biddingPrice"] as? Int ?? 0
                    }
                }
            }
    }
    
    func fetchApplyCount(userEmail: String, productID: String) {
        firestore.collection("ApplyProducts").document(productID).getDocument { document, _ in
            guard let product = try? document?.data(as: ApplyProduct.self) else {
                print("DEBUG: Failed to decode User not exist")
                return
            }
            self.totalApplyCount = product.applyUserIDs.count
            self.myApplyCount = product.applyUserIDs.filter({ applyUserEmail in
                return applyUserEmail == userEmail
            }).count
        }
    }

}
