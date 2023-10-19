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
    
    private var dbRef: DatabaseReference!
    
    init() {
        self.dbRef = Database.database().reference()
    }
    
    func fetchMyLastBiddingPrice(userID: String, productID: String) {
        print(productID)
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

}
