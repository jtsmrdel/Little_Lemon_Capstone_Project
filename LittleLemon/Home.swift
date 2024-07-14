//
//  Home.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/13/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label(
                        "Menu",
                        systemImage: "list.dash"
                    )
                }
            UserProfile()
                .tabItem {
                    Label(
                        "Profile",
                        systemImage: "square.and.pencil"
                    )
                }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    Home()
}
