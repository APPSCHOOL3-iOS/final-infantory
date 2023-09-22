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

final class LoginStore: ObservableObject {
    @Published var signUpUser: SignUpUser = SignUpUser(id: "", name: "", phoneNumber: "", birthDate: "", loginType: .kakao, address: Address(fullAddress: ""), applyTicket: [ApplyTicket(userId: "", date: Date(), ticketGetAndUse: "회원가입", count: 5)], password: "")
    
    func kakaoAuthSignIn() {
            if AuthApi.hasToken() { // 발급된 토큰이 있는지
                UserApi.shared.accessTokenInfo { _, error in // 해당 토큰이 유효한지
                    if let error = error { // 에러가 발생했으면 토큰이 유효하지 않다.
                        self.openKakaoService()
                    } else { // 유효한 토큰
                        self.loadingInfoDidKakaoAuth()
                    }
                }
            } else { // 만료된 토큰
                self.openKakaoService()
            }
        }
    
    func openKakaoService() {
            if UserApi.isKakaoTalkLoginAvailable() { // 카카오톡 앱 이용 가능한지
                UserApi.shared.loginWithKakaoTalk { oauthToken, error in // 카카오톡 앱으로 로그인
                    if let error = error { // 로그인 실패 -> 종료
                        print("Kakao Sign In Error: ", error.localizedDescription)
                        return
                    }
                    
                    _ = oauthToken // 로그인 성공
                    self.loadingInfoDidKakaoAuth() // 사용자 정보 불러와서 Firebase Auth 로그인하기
                }
            } else { // 카카오톡 앱 이용 불가능한 사람
                UserApi.shared.loginWithKakaoAccount { oauthToken, error in // 카카오 웹으로 로그인
                    if let error = error { // 로그인 실패 -> 종료
                        print("Kakao Sign In Error: ", error.localizedDescription)
                        return
                    }
                    _ = oauthToken // 로그인 성공
                    self.loadingInfoDidKakaoAuth() // 사용자 정보 불러와서 Firebase Auth 로그인하기
                }
            }
        }
        
        func loadingInfoDidKakaoAuth() {  // 사용자 정보 불러오기
            UserApi.shared.me { kakaoUser, error in
                if let error = error {
                    print("카카오톡 사용자 정보 불러오는데 실패했습니다.")
                    
                    return
                }
                guard let email = kakaoUser?.kakaoAccount?.email else { return }
                guard let password = kakaoUser?.id else { return }
                guard let userName = kakaoUser?.kakaoAccount?.profile?.nickname else { return }
                guard let birthyear = kakaoUser?.kakaoAccount?.birthyear else { return }
                guard let birthdate = kakaoUser?.kakaoAccount?.birthday else { return }
                let birthDate = "\(birthyear) \(birthdate)"
               
                print(userName)
//                self.emailAuthSignUp(email: email, userName: userName, password: "\(password)") {
//                    self.emailAuthSignIn(email: email, password: "\(password)")
//                }
            }
        }
}
