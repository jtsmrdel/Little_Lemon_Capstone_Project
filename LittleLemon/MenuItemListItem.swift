//
//  MenuItemListItem.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/19/24.
//

import SwiftUI

struct MenuItemListItem: View {
    
    let dish: Dish
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            VStack(alignment: .leading, spacing: 12) {
                
                Text(dish.title ?? "[title]")
                    .font(.headline)
                
                Text(dish.desc ?? "[description]")
                    .lineLimit(2)
                    .foregroundColor(.gray)
                
                Text(dish.price.toCurrency)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
            }
            
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75, height: 75)
            .clipShape(.rect(cornerRadius: 6))
        }
    }
}
