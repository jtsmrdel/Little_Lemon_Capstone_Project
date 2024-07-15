//
//  Menu.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/13/24.
//

import Foundation
import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var menuDataFetched = false
    
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
            FetchedObjects() { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        NavigationLink {
                            DishDetails(dish: dish)
                        } label: {
                            HStack {
                                Text("\(dish.title ?? "--")  -  \(dish.price.toCurrency)")
                                Spacer()
                                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(.rect(cornerRadius: 6))
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if !menuDataFetched {
                getMenuData()
            }
        }
    }
    
    private func getMenuData() {
        PersistenceController.shared.clear()
        
        let urlStr = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlStr)
        let urlRequest = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data {
                let menuData = try? JSONDecoder().decode(MenuList.self, from: data)
                menuData?.menu.forEach({ menuItem in
                    let dish = Dish(context: viewContext)
                    dish.id = Int16(menuItem.id)
                    dish.title = menuItem.title
                    dish.desc = menuItem.description
                    dish.price = menuItem.price
                    dish.category = menuItem.category
                    dish.image = menuItem.image
                })
                try? viewContext.save()
                menuDataFetched = true
            }
        }
        task.resume()
    }
}

#Preview {
    Menu()
}

extension Optional where Wrapped == String {
    
    var toCurrency: String {
        guard let unwrapped = self else { return "" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(floatLiteral: Double(unwrapped) ?? 0)) ?? unwrapped
    }
}
