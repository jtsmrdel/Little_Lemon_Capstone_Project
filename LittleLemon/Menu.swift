//
//  Menu.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/13/24.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Text("Little Lemon Restaurant")
                .font(.title)
                .padding(.top)
            Text("Pittsburgh")
                .font(.title3)
                .padding(.top, 0)
            Text("Little Lemon Restaurant proudly serves authentic Mediterranean dishes")
                .padding()
                .multilineTextAlignment(.center)
            List {
                
            }
        }
    }
}

#Preview {
    Menu()
}
