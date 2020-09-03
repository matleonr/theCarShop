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
    
    func decodeToImage (base64:String) -> UIImage {
        let imageData = Data.init(base64Encoded: base64, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    
    func encode(image: UIImage) -> String {
        return image.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    
    func generateImagesToCars() -> [String] {
        var images: [String] = []

        let image1 = ""
        let image2 = ""
        let image3 = ""
        let image4 = ""
        let image5 = ""
        let image6 = ""
        let image7 = ""

        images.append(image1)
        images.append(image2)
        images.append(image3)
        images.append(image4)
        images.append(image5)
        images.append(image6)
        images.append(image7)

        return images
    }
    
}
