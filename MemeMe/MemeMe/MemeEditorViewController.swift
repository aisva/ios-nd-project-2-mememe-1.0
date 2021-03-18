//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Antonio Isasi on 7/3/21.
//  Copyright (c) 2021 Antonio Isasi. All rights reserved.
//

import UIKit

/// View controller for the Meme Editor
final internal class MemeEditorViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: - Outlets
    
    /// An image view for displaying images picked from the photo library or the camera
    @IBOutlet weak var pickedImageView: UIImageView!
    /// A button for taking pictures with the device camera
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    /// A text field for entering meme's top message
    @IBOutlet weak var topTextField: UITextField!
    /// A text field for entering meme's bottom message
    @IBOutlet weak var bottomTextField: UITextField!
    /// A top toolbar for holding a share button and a cancel button
    @IBOutlet weak var topToolbar: UIToolbar!
    /// A bottom toolbar for holding a camera button and an album button
    @IBOutlet weak var bottomToolbar: UIToolbar!
    /// A button for sharing memes
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // MARK: - Variables / constants
    
    /// The memed image generated by the user
    var memedImage: UIImage?
    
    /// Text field placeholders
    enum Placeholders {
        static let top = "TOP"
        static let bottom = "BOTTOM"
    }
    
    /// Text field attributes
    let textFieldAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3.0
    ]
    
    /// Variable that handles status bar visibility
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        configureUI(reset: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - Private methods
        
    /**
     Configures the UI.
     
     - Parameter reset: A boolean to determine whether to configure the UI for the first time or to reset it.
     
     */
    func configureUI(reset: Bool) {
        configureTextField(textField: topTextField, reset: reset)
        configureTextField(textField: bottomTextField, reset: reset)
        configureButtons(reset: reset)
        configureImageView(reset: reset)
    }
    
    /**
     Configures text fields.
     
     - Parameter reset: A boolean to determine whether to configure text fields for the first time or to reset them.
     
     */
    func configureTextField(textField: UITextField, reset: Bool) {
        textField.text = textField == topTextField ? Placeholders.top : Placeholders.bottom
        if !reset {
            textField.defaultTextAttributes = textFieldAttributes
            textField.textAlignment = .center
        }
    }
    
    /**
     Configures buttons.
     
     - Parameter reset: A boolean to determine whether to configure buttons for the first time or to reset them.
     
     */
    func configureButtons(reset: Bool) {
        shareButton.isEnabled = false
        if !reset {
            cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        }
    }
    
    /**
     Configures the image view.
     
     - Parameter reset: A boolean to determine whether to configure the image view for the first time or to reset it.
     
     */
    func configureImageView(reset: Bool) {
        pickedImageView.image = nil
        if !reset {
            pickedImageView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        }
    }
    
    /**
     Picks an image from the photo library or the camera.
     
     - Parameter sender: The UIBarButtonItem that calls this method.
     
     */
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sender == cameraButton ? .camera : .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    /**
     Shares an image via an activity view controller.
     
     - Parameter sender: The UIBarButtonItem that calls this method.
     
     */
    @IBAction func shareAMemedImage(_ sender: UIBarButtonItem) {
        memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        controller.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
            if completed {
                self.save()
            }            
        }
        present(controller, animated: true, completion: nil)
    }
    
    /**
     Cancels the memed image displayed on the screen.
     
     - Parameter sender: The UIBarButtonItem that calls this method.
     
     */
    @IBAction func cancelMemedImage(_ sender: UIBarButtonItem) {
        configureUI(reset: true)
    }
    
    // MARK: - Delegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            pickedImageView.image = image
        }
        shareButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
