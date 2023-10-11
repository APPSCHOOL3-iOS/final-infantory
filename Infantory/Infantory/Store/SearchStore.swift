//
//  SearchStore.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/11.
//

import SwiftUI

class SearchStore: ObservableObject {
    
    @Published var searchArray: Set<String> = []
    
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
}
