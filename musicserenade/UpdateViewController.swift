//
//  UpdateViewController.swift
//  musicserenade
//
//  Created by Isaac Lee on 9/18/18.
//  Copyright © 2018 IsaacLee. All rights reserved.
//

import UIKit
import Parse

class UpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userGenderSwitch: UISwitch!
    @IBOutlet weak var interestedGenderSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
    }

    @IBAction func updateImageTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.image = image
            
        }
        
        dismiss(animated: true, completion: nil)
     
    }
        
    @IBAction func updateTapped(_ sender: Any) {
        
        PFUser.current()?["isFemale"] = userGenderSwitch.isOn
        PFUser.current()?["isInterestedInWomen"] = interestedGenderSwitch.isOn
        
        if let image = profileImageView.image {
           
            if let imageData = UIImagePNGRepresentation(image) {
            
                PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageData)
                
                PFUser.current()?.saveInBackground(block: { (success, error) in
                    if error != nil {
                        var errorMessage = "Update Failed - Try Again"
                    
                        if let newError = error as NSError? {
                            if let detailError = newError.userInfo["error"] as? String {
                                errorMessage = detailError
                            //Just in case we have an error
                            }
                        }
                    
                        self.errorLabel.isHidden = false
                        self.errorLabel.text = errorMessage
                    
                    } else {
                        print("Update Sucessful")
                    }
                })
        }
    }
  }
}


