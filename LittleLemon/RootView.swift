//
//  RootView.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/18/24.
//

import SwiftUI

struct RootView: View {
    
    @Environment(UserStateManager.self) var userStateManager: UserStateManager
    
    var body: some View {
        if userStateManager.isLoggedIn {
            Menu(user: userStateManager.user)
        } else {
            Onboarding()
        }
    }
}

#Preview {
    RootView()
        .environment(UserStateManager())
}
