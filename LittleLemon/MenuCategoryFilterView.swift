//
//  MenuCategoryFilterView.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/19/24.
//

import SwiftUI

enum MenuCategory: String, CaseIterable {
    case starters
    case mains
    case desserts
    case drinks
}

struct MenuCategoryFilterView: View {
    
    @Binding var selectedItem: MenuCategory?
    var items: [MenuCategory]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(items, id: \.self) { item in
                    Text(item.rawValue.capitalized)
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background {
                            if let selectedItem, item == selectedItem {
                                Color.primaryYellow
                            } else {
                                Color.secondaryGray
                            }
                        }
                        .contentShape(Rectangle())
                        .clipShape(.rect(cornerRadius: 16))
                        .onTapGesture {
                            if let curr = selectedItem, curr == item {
                                selectedItem = nil
                            } else {
                                selectedItem = item
                            }
                        }
                }
            }
            .padding(.leading)
        }
    }
}

#Preview {
    MenuCategoryFilterView(
        selectedItem: .constant(.starters),
        items: MenuCategory.allCases
    )
}
