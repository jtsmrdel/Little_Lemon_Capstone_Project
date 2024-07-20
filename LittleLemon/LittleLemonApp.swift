//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by JT Smrdel on 6/29/24.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    
    let persistence = PersistenceController.shared
    
    @State var userStateManager = UserStateManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .environment(userStateManager)
        }
    }
}
