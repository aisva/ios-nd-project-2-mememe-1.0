//
//  MemeEditorViewController+UITextFieldDelegate.swift
//  MemeMe
//
//  Created by Antonio Isasi on 7/3/21.
//  Copyright (c) 2021 Antonio Isasi. All rights reserved.
//

import UIKit

/// Extension that makes the MemeEditorViewController conform to the UITextFieldDelegate
extension MemeEditorViewController: UITextFieldDelegate {
    
    // MARK: - Private methods
    
    /// Sets up the delegates
    func setupDelegates() {
        topTextField.delegate = self
        bottomTextField.delegate = self
    }
    
    // MARK: - Delegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.text, textField) == (Placeholders.top, topTextField) ||
            (textField.text, textField) == (Placeholders.bottom, bottomTextField) {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.text = textField == topTextField ? Placeholders.top : Placeholders.bottom
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
