//
//  LoginAddressWebView.swift
//  Infantory
//
//  Created by 안지영 on 2023/10/03.
//

import SwiftUI
import WebKit

struct LoginAddressWebView: View {
    
    @Binding var zipCode: String
    @Binding var address: String
    
    var body: some View {
        LoginWebView(zipCode: $zipCode, address: $address, url: URL(string: "https://ozdevelop.github.io/KakaoAddressAPI.github.io/")!)
    }
}

struct LoginAddressWebView_Previews: PreviewProvider {
    static var previews: some View {
        LoginAddressWebView(zipCode: .constant(""), address: .constant(""))
            .environmentObject(LoginStore())
    }
}

struct LoginWebView: UIViewRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var zipCode: String
    @Binding var address: String
    
    let url: URL
    let contentController = WKUserContentController()

    // SwiftUI 뷰를 생성할 때 호출됩니다.
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        // JavaScript 메시지 핸들러
        webView.configuration.userContentController = contentController
        webView.configuration.userContentController.add(context.coordinator, name: "callBackHandler")
        // 네비게이션 델리게이트를 설정합니다.
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: LoginWebView

        init(_ parent: LoginWebView) {
            self.parent = parent
        }

        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if let data = message.body as? [String: Any] {
                parent.zipCode = data["zonecode"] as! String
                parent.address = data["address"] as! String
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
