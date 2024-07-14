//
//  Onboarding.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/13/24.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                TextField("First Name", text: $firstName)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(.rect(cornerRadius: 12))
                    .padding(.horizontal)
                TextField("Last Name", text: $lastName)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(.rect(cornerRadius: 12))
                    .padding(.horizontal)
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(.rect(cornerRadius: 12))
                    .padding(.horizontal)
                Button {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                    } else if !email.contains("@") {
                        debugPrint("Invalid email")
                    } else {
                        debugPrint("First and Last Name are required")
                    }
                } label: {
                    Text("Register")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color(red: 244/255, green: 206/255, blue: 20/255))
                .clipShape(.capsule)
                .padding([.horizontal, .top])
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
        }
        .onAppear {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
            }
        }
    }
    
    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

#Preview {
    Onboarding()
}
