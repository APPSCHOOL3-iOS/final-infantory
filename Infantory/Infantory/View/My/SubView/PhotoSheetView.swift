//
//  PhotoSheetView.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import SwiftUI

struct PhotoSheetView: View {
    @State var showActionSheet: Bool = false
    var body: some View {
        
        Button(action: {
            showActionSheet.toggle()
        }) {
            Text("서근개발노트")
        }
        .actionSheet(isPresented: $showActionSheet, content: getActionSheet)
    }
    
    // actionSheet 함수
    func getActionSheet() -> ActionSheet {
        
        let button1: ActionSheet.Button = .default(Text("default".uppercased()))
        let button2: ActionSheet.Button = .destructive(Text("destructive".uppercased()))
        let button3: ActionSheet.Button = .cancel()
        
        let title = Text("action Sheet")
        
        return ActionSheet(title: title,
                           message: nil,
                           buttons: [button1, button2, button3])
    }
}
struct PhotoSheetView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSheetView()
    }
}
