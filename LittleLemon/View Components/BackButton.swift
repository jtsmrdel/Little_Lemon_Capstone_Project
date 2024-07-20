//
//  BackButton.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/18/24.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.backward.circle.fill")
                .font(.system(size: 25))
                .tint(.primaryGreen)
        }
    }
}

#Preview {
    BackButton()
}
