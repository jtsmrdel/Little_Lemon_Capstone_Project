//
//  Home.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/13/24.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label(
                        "Menu",
                        systemImage: "list.dash"
                    )
                }
                .environment(\.managedObjectContext, persistence.container.viewContext)
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
