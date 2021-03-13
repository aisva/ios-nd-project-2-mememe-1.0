//
//  Meme.swift
//  MemeMe
//
//  Created by Antonio Isasi on 7/3/21.
//  Copyright (c) 2021 Antonio Isasi. All rights reserved.
//

import UIKit

/// Model for a meme
internal struct Meme {
    
    /// Top text for generating a meme
    var topText: String
    
    /// Bottom text for generating a meme
    var bottomText: String
    
    /// Image for generating a meme
    var originalImage: UIImage
    
    /// Generated meme (with top text, bottom text and image)
    var memedImage: UIImage
}
