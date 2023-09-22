//
//  PaymentChoiceVIew.swift
//  Infantory
//
//  Created by 변상필 on 2023/09/22.
//

import SwiftUI

struct PaymentChoiceVIew: View {
    @State var isSelectedCashReceipts = true
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    ForEach(0..<5) { item in
                        Text("\(item)")
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(lineWidth: 1)
                                    .frame(width: 250, height: 150)
                            }
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: 230)
                .tabViewStyle(PageTabViewStyle())
                
                Divider()
                
                HStack {
                    Text("현금 영수증")
                        .font(.infanHeadlineBold)
                    Spacer()
                        Toggle(isOn: $isSelectedCashReceipts) {
                            Text("신청함")
                            
                        }
                        .foregroundColor(.black)
                        .toggleStyle(DotCircleToggleStyle())
                    
                    Toggle(isOn: $isSelectedCashReceipts) {
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
                }
                
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("계좌 선택")
            .navigationBarTitleDisplayMode(.inline)
        }
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

struct PaymentChoiceVIew_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PaymentChoiceVIew()
        }
    }
}
