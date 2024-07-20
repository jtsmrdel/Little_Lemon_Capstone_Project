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
    @State private var searchText = ""
    @State private var showProfile = false
    @State private var selectedCategoryFilter: MenuCategory?
    
    let user: User
    
    var body: some View {
        NavigationStack {
            VStack {
                heroSection
                categoryFilterSection
                menuItemsSection
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showProfile) {
                UserProfile()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    topBar
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showProfile.toggle()
                    } label: {
                        if let profileImage = user.profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .frame(width: 35, height: 35)
                                .scaledToFill()
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.primaryGray, lineWidth: 2))
                                .padding(.vertical)
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: 20))
                                .padding(5)
                                .foregroundColor(Color(.primaryGray))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.primaryGray, lineWidth: 2))
                                .padding(.vertical)
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
    
    private var topBar: some View {
        Image(.littleLemonLogo)
            .resizable()
            .scaledToFit()
            .frame(height: 35)
            .padding()
    }
    
    private var heroSection: some View {
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
            
            TextField("Search menu", text: $searchText)
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(.rect(cornerRadius: 12))
                .padding([.horizontal, .bottom])
        }
        .frame(maxWidth: .infinity)
        .background {
            Color.primaryGreen
        }
    }
    
    private var categoryFilterSection: some View {
        VStack(alignment: .leading) {
            Text("Order for delivery!".uppercased())
                .font(.callout)
                .bold()
                .padding()
                .padding(.bottom, 8)
            
            MenuCategoryFilterView(
                selectedItem: $selectedCategoryFilter,
                items: MenuCategory.allCases
            )
            .padding(.bottom)
            Divider()
        }
        .frame(maxWidth: .infinity)
    }
    
    private var menuItemsSection: some View {
        FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
            List {
                ForEach(dishes) { dish in
                    NavigationLink {
                        DishDetails(dish: dish)
                    } label: {
                        MenuItemListItem(dish: dish)
                    }
                }
            }
            .listStyle(.plain)
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
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(
            key: "title",
            ascending: true,
            selector: #selector(
                NSString.localizedStandardCompare(
                    _:
                )
            )
        )]
    }
    
    private func buildPredicate() -> NSPredicate {
        if !searchText.isEmpty, let category = selectedCategoryFilter {
            let searchTextPredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            let categoryPredicate = NSPredicate(format: "category == %@", category.rawValue)
            return NSCompoundPredicate(
                type: .and, 
                subpredicates: [searchTextPredicate, categoryPredicate]
            )
        } else if !searchText.isEmpty {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        } else if let category = selectedCategoryFilter {
            return NSPredicate(format: "category == %@", category.rawValue)
        } else {
            return NSPredicate(value: true)
        }
    }
}

#Preview {
    Menu(user: User())
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
