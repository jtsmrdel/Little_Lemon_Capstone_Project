//
//  MenuItem.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/15/24.
//

import Foundation

struct MenuItem: Decodable, CustomDebugStringConvertible {
    let id: Int
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
    
    var debugDescription: String {
        """
        id: \(id)
        title: \(title)
        description: \(description)
        price: \(price)
        image: \(image)
        category: \(category)
        
        """
    }
}
