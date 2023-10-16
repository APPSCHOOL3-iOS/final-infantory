//
//  SearchStore.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/11.
//

import SwiftUI
import FirebaseFirestore

@MainActor
final class SearchStore: ObservableObject {
    
    @Published var searchArray: Set<String> = []
    @Published var selectedCategory: SearchResultCategory = .total
    @Published var influencer: [User] = []

    init() {
        fetchSearchHistory()
    }
    
    func addSearchHistory(keyword: String) {
        searchArray.update(with: keyword)
        saveSearchHistory()
        fetchSearchHistory()
    }
    
    func removeSelectedSearchHistory(keyword: String) {
        searchArray.remove(keyword)
        saveSearchHistory()
        fetchSearchHistory()
    }
    
    func removeAllSearchHistory() {
        searchArray.removeAll()
        saveSearchHistory()
        fetchSearchHistory()
    }
    
    func fetchSearchHistory() {
        do {
            if let data = UserDefaults.standard.object(forKey: "searchArray") as? Data {
                let decoder: JSONDecoder = JSONDecoder()
                self.searchArray = try decoder.decode(Set<String>.self, from: data)
            }
        } catch {
            print("UserDefaults로 부터 데이터 가져오기 실패")
        }
    }
    
    func saveSearchHistory() {
        do {
            let endcoder: JSONEncoder = JSONEncoder()
            let data: Data = try endcoder.encode(searchArray)
            UserDefaults.standard.set(data, forKey: "searchArray")
        } catch {
            print("JSON 생성 후 UserDefaults 실패")
        }
    }
    
    func findSearchKeyword(keyword: String) {
        Task {
            try await fetchInfluencer(keyword: keyword)
            influencer = influencer.filter { influencer in
                influencer.nickName.localizedCaseInsensitiveContains(keyword)
            }
        }
    }
    
    func fetchInfluencer(keyword: String) async throws {
        influencer = []
        let query = Firestore.firestore().collection("Users").whereField("isInfluencer", isEqualTo: "influencer")
        let snapshot = try await query.getDocuments()
        let documents = snapshot.documents
        for document in documents {
            do {
                let influencerUser = try document.data(as: User.self)
                influencer.append(influencerUser)
            } catch {
                print("error: 인플루언서를 불러오지 못했습니다.")
            }
        }
        print("fetchInfluencer - 1번이어야함")
    }
}

enum SearchResultCategory: String, CaseIterable {
    case total = "통합검색"
    case influencer = "인플루언서"
    case auction = "경매"
    case apply = "응모"
}

enum SearchResultCount {
    case underLimit
    case overLimit
}
