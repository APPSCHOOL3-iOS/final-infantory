//
//  PaymentChoiceView.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/23.
//

import SwiftUI

struct PaymentChoiceView: View {
    @State var isSelectedCashReceipts = true
    @State var isSelectedCashReceiptsNotApplied = false
    
    var body: some View {
            VStack {
                VStack {
                    accountChoiceView
                    Divider()
                    cashReceiptView
                }
                .padding()
                 
                Spacer()
                
                Divider()
                saveAccountView
                    .padding(.trailing)
            }
            .infanNavigationBar(title: "계좌선택")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct DotCircleToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                configuration.label
                Image(systemName: configuration.isOn ? "smallcircle.filled.circle.fill" : "circle")
                    .font(.title)
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(configuration.isOn ? .black : .gray)
            }
            .font(.infanHeadline)
        })
    }
}

extension PaymentChoiceView {
    var accountChoiceView: some View {
        TabView {
            ForEach(0..<5) { item in
                Text("\(item)")
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                .gray,
                                style: StrokeStyle(
                                    lineWidth: 3,
                                    lineCap: .round,
                                    dash: [5, 10]
                                ))
                        
                            .frame(width: 250, height: 150)
                    }
                    .offset(y: -20)
            }
        }
        .frame(width: CGFloat.screenWidth, height: 200)
        .tabViewStyle(PageTabViewStyle())
    }
    
    var cashReceiptView: some View {
        VStack {
            HStack {
                Text("현금 영수증")
                    .font(.infanHeadlineBold)
                Spacer()
                Toggle(isOn: Binding(
                    get: {
                        !isSelectedCashReceiptsNotApplied
                    }, set: { value in
                        if isSelectedCashReceiptsNotApplied {
                            isSelectedCashReceipts = value
                            isSelectedCashReceiptsNotApplied = !value
                        }
                    }
                )) {
                    Text("신청함")
                }
                .foregroundColor(.black)
                .toggleStyle(DotCircleToggleStyle())
                
                Toggle(isOn: Binding(
                    get: {
                        !isSelectedCashReceipts
                    }, set: { value in
                        if isSelectedCashReceipts {
                            isSelectedCashReceipts = !value
                            isSelectedCashReceiptsNotApplied = value
                        }
                    }
                )) {
                    Text("미신청")
                }
                .foregroundColor(.black)
                .toggleStyle(DotCircleToggleStyle())
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("개인소득공제(휴대폰)")
                    Text("010280*****")
                }
                .font(.infanHeadline)
                .fontWeight(.regular)
                Spacer()
                Button {
                    
                } label: {
                    Text("변경")
                }
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .frame(width: 50, height: 30)
                        .foregroundColor(.gray)
                    
                })
                .buttonStyle(.plain)
                .padding([.trailing, .top])
            }
            .opacity(isSelectedCashReceipts ? 1 : 0)

        }
    }
    var saveAccountView: some View {
        HStack {
            Spacer()
            
            Text("저장하기")
                .font(.infanHeadlineBold)
                .foregroundStyle(.white)
                .frame(width: 150, height: 50)
                .background(Color.black)
                .cornerRadius(25.0)
        }
    }
}

struct PaymentChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PaymentChoiceView()
        }
    }
}
