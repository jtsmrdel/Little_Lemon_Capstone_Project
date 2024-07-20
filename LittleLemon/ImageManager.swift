//
//  ImageManager.swift
//  LittleLemon
//
//  Created by JT Smrdel on 7/18/24.
//

import Foundation
import SwiftUI

class ImageManager: NSObject {
    static let shared = ImageManager()
    
    private override init() { }
    
    func saveImage(image: UIImage, imageName: String) {
        let savePath = FileManager.documentsDirectory.appendingPathComponent("\(imageName).jpg")
        if let jpegData = image.jpegData(compressionQuality: 0.5) {
            try? jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    func loadImage(imageName: String) -> UIImage? {
        let imagePath = FileManager.documentsDirectory.appendingPathComponent("\(imageName).jpg")
        return UIImage(contentsOfFile: imagePath.path())
    }
    
    func deleteImage(imageName: String) {
        let imagePath = FileManager.documentsDirectory.appendingPathComponent("\(imageName).jpg")
        try? FileManager.default.removeItem(at: imagePath)
    }
}

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
