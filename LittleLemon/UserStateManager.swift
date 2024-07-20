//
//  UserStateManager.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/19/24.
//

import Foundation
import SwiftUI

let firstName = "firstName"
let lastName = "lastName"
let email = "email"
let phoneNumber = "phoneNumber"
let profileImageName = "profileImageName"
let orderStatusNotifications = "orderStatus"
let passwordChangeNotifications = "passwordChanges"
let specialOfferNotifications = "specialOffers"
let newsletterNotifications = "newsletter"
let loggedIn = "loggedIn"

@Observable
class UserStateManager {
    
    private let defaults = UserDefaults.standard
    
    var isLoggedIn = false
    var user = User()
    
    init() {
        if defaults.bool(forKey: loggedIn) {
            isLoggedIn = true
            loadUserData()
        }
    }
    
    func login(user: User) {
        saveUserData(user: user)
        defaults.setValue(true, forKey: loggedIn)
        isLoggedIn = true
    }
    
    func saveUserData(user: User) {
        defaults.setValue(user.firstName, forKey: firstName)
        defaults.setValue(user.lastName, forKey: lastName)
        defaults.setValue(user.email, forKey: email)
        defaults.setValue(user.phoneNumber, forKey: phoneNumber)
        defaults.setValue(user.profileImageName, forKey: profileImageName)
        defaults.setValue(user.orderStatusNotifications, forKey: orderStatusNotifications)
        defaults.setValue(user.passwordChangeNotifications, forKey: passwordChangeNotifications)
        defaults.setValue(user.specialOfferNotifications, forKey: specialOfferNotifications)
        defaults.setValue(user.newsletterNotifications, forKey: newsletterNotifications)
        
        self.user = user
    }
    
    func logOut() {
        defaults.setValue(false, forKey: loggedIn)
        defaults.removeObject(forKey: firstName)
        defaults.removeObject(forKey: lastName)
        defaults.removeObject(forKey: email)
        defaults.removeObject(forKey: phoneNumber)
        defaults.removeObject(forKey: profileImageName)
        defaults.removeObject(forKey: orderStatusNotifications)
        defaults.removeObject(forKey: passwordChangeNotifications)
        defaults.removeObject(forKey: specialOfferNotifications)
        defaults.removeObject(forKey: newsletterNotifications)
        isLoggedIn = false
    }
    
    private func loadUserData() {
        user.firstName = defaults.string(forKey: firstName) ?? ""
        user.lastName = defaults.string(forKey: lastName) ?? ""
        user.email = defaults.string(forKey: email) ?? ""
        user.phoneNumber = defaults.string(forKey: phoneNumber) ?? ""
        user.profileImageName = defaults.string(forKey: profileImageName)
        user.orderStatusNotifications = defaults.bool(forKey: orderStatusNotifications)
        user.passwordChangeNotifications = defaults.bool(forKey: passwordChangeNotifications)
        user.specialOfferNotifications = defaults.bool(forKey: specialOfferNotifications)
        user.newsletterNotifications = defaults.bool(forKey: newsletterNotifications)
    }
}

@Observable
final class User: Equatable, CustomDebugStringConvertible {
    
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var profileImageName: String?
    var orderStatusNotifications = false
    var passwordChangeNotifications = false
    var specialOfferNotifications = false
    var newsletterNotifications = false
    
    var profileImage: UIImage? {
        guard let imageName = profileImageName else { return nil }
        return ImageManager.shared.loadImage(imageName: imageName)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName &&
        lhs.email == rhs.email &&
        lhs.phoneNumber == rhs.phoneNumber &&
        lhs.profileImageName == rhs.profileImageName &&
        lhs.orderStatusNotifications == rhs.orderStatusNotifications &&
        lhs.passwordChangeNotifications == rhs.passwordChangeNotifications &&
        lhs.specialOfferNotifications == rhs.specialOfferNotifications &&
        lhs.newsletterNotifications == rhs.newsletterNotifications
    }
    
    var debugDescription: String {
        """
        firstName: \(firstName)
        lastName: \(lastName)
        email: \(email)
        phoneNumber: \(phoneNumber)
        profileImageName: \(profileImageName ?? "nil")
        orderStatusNotifications: \(orderStatusNotifications)
        passwordChangeNotifications: \(passwordChangeNotifications)
        specialOfferNotifications: \(specialOfferNotifications)
        newsletterNotifications: \(newsletterNotifications)
        """
    }
}
