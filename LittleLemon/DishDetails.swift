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
            
            Text(dish.title ?? "[title]")
                .font(.title)
            
            Text(dish.desc ?? "[description")
                .padding(.horizontal)
            
            Text(dish.price.toCurrency)
                .padding(.vertical)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .principal) {
                topBar
            }
        }
    }
    
    private var topBar: some View {
        Image(.littleLemonLogo)
            .resizable()
            .scaledToFit()
            .frame(height: 35)
            .padding()
    }
}
