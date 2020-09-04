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
    
//    func decodeToImage (imageData: String) -> UIImage {
//        let nsData = NSData()
//        let image = UIImage(data: (nsData as NSData) as Data)
//        return image!
//    }
//    
//    func encodetoString(image: UIImage) -> String {
//        let imageData: NSData = image.pngData()! as NSData
//        print(imageData.description)
//        return imageData.description
//    }
    
    
    func saveImage(image: UIImage, nameImage: String) -> String {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return ""
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return ""
        }
        do {
            try data.write(to: directory.appendingPathComponent("\(nameImage).png")!)
            return "\(directory.path!)/\(nameImage).png"
        } catch {
            print(error.localizedDescription)
            return ""
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        
            return UIImage(contentsOfFile: URL(fileURLWithPath: named).path)
//        }
//        return nil
    }
    
    
    
    
}
