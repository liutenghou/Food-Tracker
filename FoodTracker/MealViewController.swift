//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Leo Liu on 7/17/17.
//  Copyright © 2017 Blue Anchor. All rights reserved.
//

import UIKit
import os.log

//MealViewController implements these "Protocols"
class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    //new meal to be added with save button
    var meal:Meal?
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //handle text input through "delegate callback"
        nameTextField.delegate = self;
        
        //enable save button only when valid Meal name
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard
        textField.resignFirstResponder();
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //take text after return is pressed, do something with it
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //disable the save button while editing
        saveButton.isEnabled = false
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //configure the destination view controller only when "save" button pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("The save button was not pressed, cancelling", log: OSLog.default,
                   type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        meal = Meal(name: name, photo: photo, rating: rating)
        
    }

    //MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        nameTextField.text = "Default Text";
    }
    //when image is tapped
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //hide the keyboard
        nameTextField.resignFirstResponder();
        //only allow photos to be picked, not taken
        let imagePickerController = UIImagePickerController();
        imagePickerController.sourceType = .photoLibrary;
        //lets viewcontroller be notified when user picks an image
        imagePickerController.delegate = self;
        self.present(imagePickerController, animated: true, completion: nil);
        
    }
    
    //let's users select the image after imagePicker is presented
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss the picker if the user cancels it
        dismiss(animated: true, completion: nil);
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage;
        //dismiss image picker
        dismiss(animated: true, completion: nil);
    }
    
    //MARK: private methods
    private func updateSaveButtonState(){
        //disable to save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        
    }

}

