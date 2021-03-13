//
//  MemeEditorViewController+Keyboard.swift
//  MemeMe
//
//  Created by Antonio Isasi on 7/3/21.
//  Copyright (c) 2021 Antonio Isasi. All rights reserved.
//

import UIKit

/// Extension that allows the MemeEditorViewController to handle keyboard notifications
extension MemeEditorViewController {
    
    // MARK: - Private methods
    
    /**
     Moves the root view upwards when the keyboard is displayed.

     - Parameter notification: The notification notifying that the keyboard has been displayed.
     */
    @objc func keyboardWillShow(_ notification: Notification) {
        if (bottomTextField.isFirstResponder && view.frame.origin.y == 0) {
            view.frame.origin.y -= getKeyboardHeight(notification) ?? 0
        }
    }
    
    /// Moves the root view downwards when the keyboard is hidden
    @objc func keyboardWillHide() {
        view.frame.origin.y = 0
    }

    /**
     Gets the height of the keyboard.

     - Parameter notification: The notification notifying that the keyboard is being displayed.

     - Returns: The height of the keyboard.
     */
    func getKeyboardHeight(_ notification: Notification) -> CGFloat? {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            return keyboardSize.cgRectValue.height
        }
        return nil
    }
    
    /// Subscribes to the Notification Center to get keyboard-related notifications
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Unsubscribes from the Notification Center to not get keyboard-related notifications any more
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
