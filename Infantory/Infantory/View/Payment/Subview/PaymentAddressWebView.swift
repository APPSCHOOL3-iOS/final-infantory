//
//  PaymentAddressWebView.swift
//  Infantory
//
//  Created by 이희찬 on 2023/09/26.
//

import SwiftUI
import WebKit

struct PaymentAddressWebView: View {
    @Binding var paymentInfo: PaymentInfo
    
    var body: some View {
        WebView(
            paymentInfo: $paymentInfo,
            url: URL(string: "https://ozdevelop.github.io/KakaoAddressAPI.github.io/")!
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct PaymentAddressWebView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentAddressWebView(paymentInfo: .constant(PaymentInfo(userId: "",
                                                                 address: Address.init(address: "",
                                                                                       zonecode: "",
                                                                                       addressDetail: ""),
                                                                 deliveryRequest: .door,
                                                                 deliveryCost: 3000,
                                                                 paymentMethod: .accountTransfer))
        )
    }
}

struct WebView: UIViewRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var paymentInfo: PaymentInfo
    
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
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if let data = message.body as? [String: Any] {
                parent.paymentInfo.address = Address(address: data["address"] as! String,
                                                               zonecode: data["zonecode"] as! String,
                                                               addressDetail: "")
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
