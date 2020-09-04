//
//  ImageHelper.swift
//  The Car Shop
//
//  Created by Mateo Leon Restrepo on 2/09/20.
//  Copyright © 2020 Matt León. All rights reserved.
//

import Foundation
import UIKit

public class ImageHelper {
    
    
    func saveImage(image: UIImage, nameImage: String) -> String {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return ""
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return ""
        }
        do {
            try data.write(to: directory.appendingPathComponent("\(nameImage).png")!)
            return "\(nameImage).png"
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    
    
    
}
