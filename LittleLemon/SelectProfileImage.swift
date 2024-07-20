//
//  SelectProfileImage.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/18/24.
//

import SwiftUI

struct SelectProfileImage: View {
    
    @State private var showImagePicker = false
    @State private var profileImage: UIImage?
    @State private var selectEmailNotifications = false
    
    @Binding var user: User
    
    var body: some View {
        HeroSection()
        
        VStack {
            if let profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.primaryGray, lineWidth: 2))
                    .padding(.vertical, 24)
            } else {
                Image(systemName: "person.fill")
                    .font(.system(size: 90))
                    .padding()
                    .foregroundColor(Color(.primaryGray))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.primaryGray, lineWidth: 2))
                    .padding(.vertical, 24)
            }
            
            Button {
                if profileImage != nil {
                    profileImage = nil
                } else {
                    showImagePicker.toggle()
                }
            } label: {
                Text(profileImage != nil ? "Remove image" : "Add image")
                    .font(.headline)
                    .foregroundStyle(Color(.white))
                    .contentShape(Rectangle())
                    .padding(.horizontal)
                
            }
            .padding(.vertical)
            .background {
                profileImage != nil ? Color.primaryGray : Color.primaryGreen
            }
            .clipShape(.rect(cornerRadius: 10))
            
            Spacer()
            
            nextButton
        }
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
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    selectEmailNotifications.toggle()
                } label: {
                    Text("Skip")
                        .contentShape(Rectangle())
                        .foregroundStyle(.primaryGray)
                }
            }
        }
        .fullScreenCover(isPresented: $showImagePicker) {
            ImagePicker(image: $profileImage)
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $selectEmailNotifications) {
            SelectEmailNotifications(user: $user)
        }
        .onAppear {
            selectEmailNotifications = false
        }
    }
    
    private var nextButton: some View {
        Button {
            if let profileImage {
                let imageId = UUID().uuidString
                ImageManager.shared.saveImage(
                    image: profileImage,
                    imageName: imageId
                )
                user.profileImageName = imageId
            }
            selectEmailNotifications.toggle()
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
}

#Preview {
    SelectProfileImage(user: .init(get: {
        User()
    }, set: { user in
        
    }))
}
