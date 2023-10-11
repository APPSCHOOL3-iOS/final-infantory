//
//  ProfileEditView.swift
//  Infantory
//
//  Created by 윤경환 on 10/11/23.
//

import SwiftUI

struct ProfileEditView: View {
    @StateObject var photosSelectorStore: PhotosSelectorStore = PhotosSelectorStore.shared
    @State var profileName: String = ""
    @State var name: String = ""
    @State var introduce: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosSelector()
                    .padding()
                Text("프로필 정보")
                Spacer()
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}
