//
//  DishDetails.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/15/24.
//

import SwiftUI

struct DishDetails: View {
    
    let dish: Dish
    
    var body: some View {
        VStack(spacing: 40) {
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            Text(dish.desc ?? "")
                .padding(.horizontal)
            Text(dish.price.toCurrency)
                .padding(.vertical)
            Spacer()
        }
        .navigationTitle(dish.title ?? "")
    }
}
