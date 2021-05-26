//
//  Model.swift
//  MeMe 1.0
//
//  Created by owner on 25/05/2021.
//

import Foundation
import UIKit 
struct Meme{
    var topText: String!
    var bottomText: String!
    var originalImage: UIImage!
    var memedImage: UIImage!
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
        }
}

