//
//  MemeEditorViewController+MemeGeneration.swift
//  MemeMe
//
//  Created by Antonio Isasi on 7/3/21.
//  Copyright (c) 2021 Antonio Isasi. All rights reserved.
//

import UIKit

/// Extension that allows the MemeEditorViewController to generate memes
extension MemeEditorViewController {
    
    // MARK: - Private methods
    
    /// Creates a meme object
    func save() {
        _ = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!,
                 originalImage: pickedImageView.image!, memedImage: memedImage!)
    }
    
    /**
     Generates a memed image.

     - Returns: The memed image.
     */
    func generateMemedImage() -> UIImage {

        // Hide top and bottom toolbars
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        // Render root view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // Show top and bottom toolbars
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false

        return memedImage
    }
}
