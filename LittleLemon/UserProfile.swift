//
//  UserProfile.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/14/24.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(UserStateManager.self) var userStateManager: UserStateManager
    
    private let defaults = UserDefaults.standard
    
    @State private var showImagePicker = false
    @State private var newProfileImage: UIImage?
    
    @State var user = User()
    
    var hasChanges: Bool {
        user != userStateManager.user
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Personal information")
                    .font(.title3)
                    .bold()
                    .padding([.horizontal, .top])
                
                profileImageSection
                personalInfoTextFields
                emailNotificationsSection
                
                if hasChanges {
                    saveChangesSection
                }
                
                logoutButton
            }
        }
        .fullScreenCover(isPresented: $showImagePicker, onDismiss: {
            if let newProfileImage {
                let imageId = UUID().uuidString
                user.profileImageName = imageId
            }
        }, content: {
            ImagePicker(image: $newProfileImage)
        })
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
            
            ToolbarItem(placement: .principal) {
                Image(.littleLemonLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 35)
                    .padding()
            }
        }
        .onAppear {
            setUserData(user: userStateManager.user)
        }
    }
    
    var profileImageSection: some View {
        HStack(spacing: 24) {
            if newProfileImage != nil || user.profileImage != nil {
                Image(uiImage: (newProfileImage ?? user.profileImage)!)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.primaryGray, lineWidth: 2))
            } else {
                Image(systemName: "person.fill")
                    .font(.system(size: 36))
                    .padding()
                    .foregroundColor(Color(.primaryGray))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.primaryGray, lineWidth: 2))
            }
            
            Button {
                showImagePicker.toggle()
            } label: {
                Text(newProfileImage != nil || user.profileImage != nil ? "Change" : "Add")
                    .font(.headline)
                    .foregroundStyle(Color(.white))
                    .contentShape(Rectangle())
                    .padding(.horizontal)
                
            }
            .padding()
            .background {
                Color.primaryGreen
            }
            .clipShape(.rect(cornerRadius: 10))
            
            if newProfileImage != nil || user.profileImage != nil {
                Button {
                    newProfileImage = nil
                    user.profileImageName = nil
                } label: {
                    Text("Remove")
                        .font(.headline)
                        .foregroundStyle(Color(.white))
                        .contentShape(Rectangle())
                        .padding(.horizontal)
                    
                }
                .padding(.vertical)
                .background {
                    Color.primaryGray
                }
                .clipShape(.rect(cornerRadius: 10))
            }
        }
        .padding(.horizontal)
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
    
    var emailNotificationsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Email notifications")
                .font(.title3)
                .fontWeight(.bold)
            
            Toggle(isOn: $user.orderStatusNotifications) {
                Text("Order statuses")
            }
            
            Toggle(isOn: $user.passwordChangeNotifications) {
                Text("Password changes")
            }
            
            Toggle(isOn: $user.specialOfferNotifications) {
                Text("Special offers")
            }
            
            Toggle(isOn: $user.newsletterNotifications) {
                Text("Newsletter")
            }
        }
        .padding()
    }
    
    var logoutButton: some View {
        Button {
            userStateManager.logOut()
        } label: {
            Text("Logout")
                .font(.headline)
                .foregroundStyle(Color(.dark))
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background {
            Color.primaryYellow
        }
        .clipShape(.rect(cornerRadius: 10))
        .padding()
    }
    
    var saveChangesSection: some View {
        HStack(spacing: 20) {
            Button {
                discardChanges()
            } label: {
                Text("Discard changes")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .contentShape(Rectangle())
            }
            .padding()
            .background {
                Color.primaryGray
            }
            .clipShape(.rect(cornerRadius: 10))
            
            Button {
                saveChanges()
            } label: {
                Text("Save changes")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .contentShape(Rectangle())
            }
            .padding()
            .background {
                Color.primaryGreen
            }
            .clipShape(.rect(cornerRadius: 10))
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }
    
    private func discardChanges() {
        setUserData(user: userStateManager.user)
    }
    
    private func saveChanges() {
        if user.profileImageName == nil, let imageName = userStateManager.user.profileImageName {
            ImageManager.shared.deleteImage(imageName: imageName)
        } else if let newProfileImage, let imageName = user.profileImageName {
            if let imageName = userStateManager.user.profileImageName {
                ImageManager.shared.deleteImage(imageName: imageName)
            }
            ImageManager.shared.saveImage(image: newProfileImage, imageName: imageName)
            self.newProfileImage = nil
        }
        userStateManager.saveUserData(user: user)
    }
    
    private func setUserData(user: User) {
        self.user.firstName = user.firstName
        self.user.lastName = user.lastName
        self.user.email = user.email
        self.user.phoneNumber = user.phoneNumber
        self.user.profileImageName = user.profileImageName
        self.user.orderStatusNotifications = user.orderStatusNotifications
        self.user.passwordChangeNotifications = user.passwordChangeNotifications
        self.user.specialOfferNotifications = user.specialOfferNotifications
        self.user.newsletterNotifications = user.newsletterNotifications
    }
}

#Preview {
    UserProfile()
}
