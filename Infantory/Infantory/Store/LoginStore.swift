//
//  LoginStore.swift
//  Infantory
//
//  Created by 안지영 on 2023/09/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import KakaoSDKAuth
import KakaoSDKUser
import SwiftUI

enum LoginStatus {
    case signIn
    case signOut
}

final class LoginStore: ObservableObject {
    
    @AppStorage("userId") var userUid: String = ""
    
    @Published var isShowingSignUp = false
    @Published var isShowingMainView = false
    @Published var email: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var loginType: LoginType = .kakao
    @Published var currentUser: User = User()
    @Published var signUpUser: SignUpUser = SignUpUser()
    
    init() {
        print("=====================userUid\(userUid)===========")
        if !userUid.isEmpty {
            Task {
                try await fetchUser(userUID: userUid)
            }
        }
    }
    
    func kakaoAuthSignIn(completion: @escaping (Bool) -> Void) {
        if AuthApi.hasToken() { // 발급된 토큰이 있는지
            validateKakaoToken { isValid in // 토큰 유효성확인
                self.handleSignInCompletion(isValid, completion: completion)
            }
        } else { // 만료된 토큰
            self.actionKakaoLogin { isSuccessful in // 카카오 로그인
                self.handleSignInCompletion(isSuccessful, completion: completion)
            }
        }
    }
    
    private func validateKakaoToken(completion: @escaping (Bool) -> Void) {
        UserApi.shared.accessTokenInfo { _, error in
            if error != nil {
               
            } else {
                self.loadingInfoDidKakaoAuth(completion: completion)
            }
        }
    }
    
    private func actionKakaoLogin(completion: @escaping (Bool) -> Void) {
        // 로그인 방법 선택 [ 앱, 계정 ]
        let loginMethod: (@escaping (Bool) -> Void) -> Void = UserApi.isKakaoTalkLoginAvailable() ? loginWithKakaoTalk : loginWithKakaoAccount
        
        loginMethod { isSuccessful in
            self.handleSignInCompletion(isSuccessful, completion: completion)
        }
    }
    
    private func loginWithKakaoTalk(completion: @escaping (Bool) -> Void) {
        UserApi.shared.loginWithKakaoTalk { _, error in
            if error != nil {
                print("Kakao SignIn Error: 카카오앱 실행에 실패했습니다.")
                return
            }
            self.loadingInfoDidKakaoAuth(completion: completion)
        }
    }
    
    private func loginWithKakaoAccount(completion: @escaping (Bool) -> Void) {
        UserApi.shared.loginWithKakaoAccount { _, error in
            if error != nil {
                print("Kakao SignIn Error: 카카오 계정 로그인에 실패했습니다.")
                return
            }
            self.loadingInfoDidKakaoAuth(completion: completion)
        }
    }
    
    func loadingInfoDidKakaoAuth(completion: @escaping (Bool) -> Void) {
        UserApi.shared.me { [weak self] kakaoUser, error in
            guard let self = self else { return }
            if let error = error {
                print("카카오톡 사용자 정보 불러오는데 실패했습니다: \(error.localizedDescription)")
                return
            }
            guard let email = kakaoUser?.kakaoAccount?.email,
                  let password = kakaoUser?.id else {
                print("Error: email과 kakaoUser Id가 잘못되었습니다.")
                return
            }
            self.email = email
            self.password = String(password)
            self.userName = kakaoUser?.kakaoAccount?.profile?.nickname ?? ""
            
            self.emailAuthSignIn(email: email, password: String(password), completion: completion)
        }
    }
    
    private func handleSignInCompletion(_ isSuccessful: Bool, completion: @escaping (Bool) -> Void) {
        if isSuccessful {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func kakaoLogout() {
        UserApi.shared.logout {[weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("Kakao Logout Error: \(error.localizedDescription)")
            } else {
                self.userUid = ""
                self.currentUser = User()
            }
        }
    }
    
    func emailAuthSignIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                print("Error: 로그인에 실패했습니다. \(error.localizedDescription)")
                completion(false)
            }
            
            if let userUid = result?.user.uid {
                print("로그인 성공! 사용자 이메일: \(String(describing: result?.user.email))")
                self.userUid = userUid
                completion(true)
            } else {
                print("Error: UID를 가져오는데 실패했습니다.")
            }
        }
    }
    
    func emailAuthSignUp(email: String, password: String, completion: (() -> Void)?) {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error: 이미 등록되어있는 사용자입니다. \(error.localizedDescription)")
                    completion?()
                    return
                }
                self.userUid = result?.user.uid ?? "uid 없음"
                completion?()
            }
        }
    
    func signUpToFireStore(name: String,
                           nickName: String,
                           phoneNumber: String,
                           zipCode: String,
                           streetAddress: String,
                           detailAddress: String,
                           completion: (() -> Void)?) {
        do {
            let signUpUser = SignUpUser(name: name,
                                        nickName: nickName,
                                        phoneNumber: phoneNumber,
                                        email: self.email,
                                        loginType: self.loginType.rawValue,
                                        address: Address(address: zipCode,
                                                         zonecode: streetAddress,
                                                         addressDetail: detailAddress))
            let applyTicket = ApplyTicket(date: Date(), ticketGetAndUse: "회원가입", count: 5)
            try Firestore.firestore().collection("Users").document(userUid).setData(from: signUpUser)
            try Firestore.firestore().collection("Users").document(userUid).collection("ApplyTickets").addDocument(from: applyTicket)
            completion?()
        } catch {
            print("Error: Failed to Create User. \(error.localizedDescription)")
        }
    }
    
    func signUpToFirebase(name: String,
                          nickName: String,
                          phoneNumber: String,
                          zipCode: String,
                          streetAddress: String,
                          detailAddress: String,
                          completion: @escaping (Bool) -> Void) {
        self.emailAuthSignUp(email: self.email, password: "\(self.password)") { [weak self] in
            guard let self = self else { return }
            self.signUpToFireStore(name: name,
                                   nickName: nickName,
                                   phoneNumber: phoneNumber,
                                   zipCode: zipCode,
                                   streetAddress: streetAddress,
                                   detailAddress: detailAddress) { [weak self] in
                guard let self = self else { return }
                self.emailAuthSignIn(email: self.email, password: "\(self.password)", completion: completion)
            }
        }
    }
    
    func duplicateNickName(nickName: String, completion: @escaping (Bool) -> Void) {
        let query = Firestore.firestore().collection("Users").whereField("nickName", isEqualTo: nickName)
        query.getDocuments { data, error in
            if let error = error {
                print("Error: Failed to fetch documents. \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(data?.documents.isEmpty ?? false)
        }
    }
    
    func fetchUser(userUID: String) async throws {
        let userDocument = try await Firestore.firestore().collection("Users").document(userUID).getDocument()
        let user = try userDocument.data(as: User.self)
        
        print("user fetch되")
        try await fetchApplyTicket(getUser: user, userUID: userUID)
    }
    
    @MainActor
    func fetchApplyTicket(getUser: User, userUID: String) async throws {
        
        var user = getUser
        var ticketList: [ApplyTicket] = []
        
        let ticketDocument = try await Firestore.firestore()
            .collection("Users").document(userUID).collection("ApplyTickets").getDocuments()
        let documents = ticketDocument.documents
        for document in documents {
            let applyTicket = try document.data(as: ApplyTicket.self)
            ticketList.append(applyTicket)
        }
        
        user.applyTicket = ticketList
        
        self.currentUser = user
    }
    
    var totalApplyTicketCount: Int {
        return currentUser.applyTicket?.reduce(0) { (result, applyTicket) in
            return result + applyTicket.count
        } ?? 0
    }
}
