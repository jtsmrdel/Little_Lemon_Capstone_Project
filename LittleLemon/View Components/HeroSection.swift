//
//  HeroSection.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/18/24.
//

import SwiftUI

struct HeroSection: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .font(.system(size: 44))
                .fontWeight(.medium)
                .foregroundStyle(.primaryYellow)
                .padding([.top, .horizontal])
            
            Text("Pittsburgh")
                .font(.system(size: 24))
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding([.horizontal])
            
            HStack {
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipies served with a modern twist.")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                    .padding([.horizontal, .bottom])
                
                Image(.hero)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(.rect(cornerRadius: 16))
                    .padding()
                    .padding(.top, -30)
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            Color.primaryGreen
        }
    }
}

#Preview {
    HeroSection()
}
