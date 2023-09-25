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

final class LoginStore: ObservableObject {
    
    @Published var isShowingSignUp = false
    @Published var isShowingMainView = false
    
    @Published var email: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    
    @Published var signUpUser: SignUpUser = SignUpUser(id: "", name: "", phoneNumber: "", loginType: .kakao, address: Address(fullAddress: ""), applyTicket: [ApplyTicket(userId: "", date: Date(), ticketGetAndUse: "회원가입", count: 5)], password: "")
    
    func kakaoAuthSignIn(completion: @escaping (Bool) -> Void) {
        if AuthApi.hasToken() { // 발급된 토큰이 있는지
            UserApi.shared.accessTokenInfo { _, error in // 해당 토큰이 유효한지
                if error != nil { // 에러가 발생했으면 토큰이 유효하지 않다.
                    self.openKakaoService(completion: { result in
                        print("컴플리션 값: \(result)")
                        if result {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    })
                } else { // 유효한 토큰
                    self.loadingInfoDidKakaoAuth(completion: { result in
                        print("컴플리션 값: \(result)")
                        if result {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    })
                }
            }
        } else { // 만료된 토큰
            self.openKakaoService(completion: { result in
                print("컴플리션 값: \(result)")
                if result {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
    }
    
    func openKakaoService(completion: @escaping (Bool) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() { // 카카오톡 앱 이용 가능한지
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in // 카카오톡 앱으로 로그인
                if error != nil { // 로그인 실패 -> 종료
                    print("Kakao Sign In Error: 카카오앱 실행에 실패했습니다.")
                    return
                }
                
                _ = oauthToken // 로그인 성공
                self.loadingInfoDidKakaoAuth(completion: { result in
                    print("컴플리션 값: \(result)")
                    if result {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }) // 사용자 정보 불러와서 Firebase Auth 로그인하기
            }
        } else { // 카카오톡 앱 이용 불가능한 사람
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in // 카카오 웹으로 로그인
                if error != nil { // 로그인 실패 -> 종료
                    print("Kakao Sign In Error: 카카오 계정 로그인에 실패했습니다.")
                    return
                }
                _ = oauthToken // 로그인 성공
                self.loadingInfoDidKakaoAuth(completion: { result in
                    print("컴플리션 값: \(result)")
                    if result {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }) // 사용자 정보 불러와서 Firebase Auth 로그인하기
            }
        }
    }
    
    func loadingInfoDidKakaoAuth(completion: @escaping (Bool) -> Void) {  // 사용자 정보 불러오기
        UserApi.shared.me { kakaoUser, error in
            if error != nil {
                print("카카오톡 사용자 정보 불러오는데 실패했습니다.")
                return
            }
            guard let email = kakaoUser?.kakaoAccount?.email else { return }
            self.email = email
            guard let password = kakaoUser?.id else { return }
            self.password = String(password)
            guard let userName = kakaoUser?.kakaoAccount?.profile?.nickname else { return }
            self.userName = userName
            // 로그인이 되는지 안되는지 확인하는 함수 -> 에러? 로그인이안된다 -> 회원가입이 안되어있다 -> 회원가입뷰로
            // 로그인이 된다 -> 메인뷰로
            self.emailAuthSignIn(email: email, password: String(password), completion: { result in
                print("컴플리션 값: \(result)")
                if result {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
    }
    
    func emailAuthSignIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print("error: 로그인에 실패했습니다.")
                completion(false)
                return // 실패하면 회원가입 화면
            }
            
            if result != nil {
                print("로그인 성공! 사용자 이메일: \(String(describing: result?.user.email))")
                // 성공하면 메인화면
                completion(true)
            }
        }
    }
    
    func emailAuthSignUp(email: String, password: String, completion: (() -> Void)?) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("error: 이미 등록되어있는 사용자입니다.")
            }
            if result != nil {
                print("사용자 이메일: \(String(describing: result?.user.email))")
            }
            
            completion?()
        }
    }
    
    func signUpToFirebase(completion: @escaping (Bool) -> Void) {
        self.emailAuthSignUp(email: self.email, password: "\(self.password)") {
            self.emailAuthSignIn(email: self.email, password: "\(self.password)", completion: { result in
                if result {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
    }
}
