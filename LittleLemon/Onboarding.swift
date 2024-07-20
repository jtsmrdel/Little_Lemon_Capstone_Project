//
//  Onboarding.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/13/24.
//

import SwiftUI

struct Onboarding: View {
    
    @State var selectProfileImage = false
    @State var hasError = false
    @State var errorMessage = ""
    
    @State var user = User()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HeroSection()
                VStack {
                    personalInfoTextFields
                    nextButton
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $selectProfileImage) {
                SelectProfileImage(user: $user)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                topBar
            }
        }
        .alert(errorMessage, isPresented: $hasError) {
            Button("Okay") {
                errorMessage = ""
                hasError = false
            }
        }
        .onAppear {
            selectProfileImage = false
        }
    }
    
    private var topBar: some View {
        Image(.littleLemonLogo)
            .resizable()
            .scaledToFit()
            .frame(height: 35)
            .padding()
    }
    
    var personalInfoTextFields: some View {
        VStack(spacing: 16) {
            Group {
                TextField("First name*", text: $user.firstName)
                    .textContentType(.givenName)
                
                TextField("Last name*", text: $user.lastName)
                    .textContentType(.familyName)
                
                TextField("Email*", text: $user.email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                
                TextField("Phone number", text: $user.phoneNumber)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
            }
            .autocorrectionDisabled()
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(.rect(cornerRadius: 12))
        }
        .padding()
    }
    
    private var nextButton: some View {
        Button {
            nextButtonAction()
        } label: {
            Text("Next")
                .font(.headline)
                .foregroundStyle(Color(.dark))
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(Color(.primaryYellow))
        .clipShape(.rect(cornerRadius: 10))
        .padding([.horizontal, .top])
    }
    
    
    
    private func nextButtonAction() {
        if user.firstName.isEmpty || user.lastName.isEmpty || user.email.isEmpty {
            errorMessage = "First name, last name, and email are required"
            hasError = true
        } else if !validateEmail(user.email) {
            errorMessage = "Invalid email"
            hasError = true
        } else {
            selectProfileImage.toggle()
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
