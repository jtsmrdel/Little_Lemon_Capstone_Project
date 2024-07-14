//
//  UserProfile.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/14/24.
//

import SwiftUI

struct UserProfile: View {
    
    let firstName = UserDefaults.standard.string(
        forKey: kFirstName
    ) ?? "[No Data]"
    let lastName = UserDefaults.standard.string(
        forKey: kLastName
    ) ?? "[No Data]"
    let email = UserDefaults.standard.string(
        forKey: kEmail
    ) ?? "[No Data]"
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Personal information")
                .font(.title)
                .padding(.vertical)
            Image(.profileImagePlaceholder)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.bottom)
            Text(firstName)
            Text(lastName)
            Text(email)
            Button {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                dismiss()
            } label: {
                Text("Logout")
                    .font(.system(size: 20))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(Color(red: 244/255, green: 206/255, blue: 20/255))
            .clipShape(.capsule)
            .padding([.horizontal, .top])
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
