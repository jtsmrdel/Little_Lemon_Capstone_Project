//
//  SelectEmailNotifications.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/18/24.
//

import SwiftUI

struct SelectEmailNotifications: View {
    
    @Environment(UserStateManager.self) var userStateManager: UserStateManager
    
    @Binding var user: User
    
    var body: some View {
        HeroSection()
        
        VStack(alignment: .leading) {
            emailNotificationsSection
            Spacer()
            registerButton
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .principal) {
                Image(.littleLemonLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 35)
                    .padding()
            }
        }
    }
    
    var emailNotificationsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Email notifications")
                .font(.title3)
                .fontWeight(.bold)
            
            Toggle(isOn: $user.orderStatusNotifications) {
                Text("Order statuses")
            }
            
            Toggle(isOn: $user.passwordChangeNotifications) {
                Text("Password changes")
            }
            
            Toggle(isOn: $user.specialOfferNotifications) {
                Text("Special offers")
            }
            
            Toggle(isOn: $user.newsletterNotifications) {
                Text("Newsletter")
            }
        }
        .padding()
    }
    
    private var registerButton: some View {
        Button {
            userStateManager.login(user: user)
        } label: {
            Text("Register")
                .font(.headline)
                .foregroundStyle(Color(.dark))
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(Color(.primaryYellow))
        .clipShape(.rect(cornerRadius: 10))
        .padding([.horizontal, .top])
    }
}

#Preview {
    SelectEmailNotifications(user: .init(get: {
        User()
    }, set: { user in
        
    }))
}
