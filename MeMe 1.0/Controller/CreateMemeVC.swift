//
//  ViewController.swift
//  MeMe 1.0
//
//  Created by owner on 22/05/2021.
//

import UIKit
import AVFoundation

class CreateMemeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var pickFromCamera: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    // @IBOutlet weak var shareButton: UIBarButtonItem! // Replaced by navigationItem
    
    
    // setting delegates for the textfields and attributes for them also
    let styledTextFieldDelegate = TextFieldDelegate()
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
      NSAttributedString.Key.strokeColor: UIColor.black,
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
      NSAttributedString.Key.strokeWidth: -3.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldStyle(toTextField: topTextField, defaultText: "TOP")
        setupTextFieldStyle(toTextField: bottomTextField, defaultText: "BOTTOM")
        // shareButton.isEnabled = false
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareIcon))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pickFromCamera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera) //checks if the camera is installed on device and enables or disables it otherwise
        subscribeToKeyboardNotifications() // This is called inside the viewWillAppear
        self.tabBarController?.tabBar.isHidden = true // hides the tab-bar controller when loaded
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications() // This is called inside the ViewWillDisappear
    }
    
    // sets up textFieldStyle
    func setupTextFieldStyle(toTextField textField: UITextField, defaultText: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.delegate = styledTextFieldDelegate
        textField.text = defaultText
        textField.textAlignment = .center
        textField.backgroundColor = UIColor(white: 1, alpha: 0.2)
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil) //calls the objc method to show the keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self) // Removing all observers at once
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isEditing{
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
        // checks for the bottom text field before raising the view for keyboard to display
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
            view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
        // gets the height of the keyboard to subtract for the view space to be moved
    }
    
    
    @IBAction func pickAnImage(_ sender: Any) {
        openImagePicker(.photoLibrary)
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        openImagePicker(.camera)
    }

    func openImagePicker(_ type: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    // This replaces the IBAction for the shareButton method below
    @objc func shareIcon(){
        let memedImage = generateMemedImage()
        let shareActivityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        shareActivityViewController.completionWithItemsHandler = { activity, completed, items, error in
          if completed {
            self.saveMeme(memedImage: memedImage)
            self.dismiss(animated: true, completion: nil)
          }
            
        }
           present(shareActivityViewController, animated: true, completion: nil)
    }
    
    @objc func cancel(){
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImageView.image = image
        }
        // shareButton.isEnabled = true
        navigationItem.leftBarButtonItem?.isEnabled = true //replaces the shareButton
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
      dismiss(animated: true, completion: nil)
    }
    
    func saveMeme(memedImage: UIImage){
        // create meme
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: selectedImageView.image!, memedImage: memedImage)
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    func generateMemedImage() -> UIImage {
        // Render view to an image
        self.toolBar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.toolBar.isHidden = false
        return memedImage
    }
}

