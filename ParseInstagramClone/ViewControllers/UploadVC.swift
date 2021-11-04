//
//  SettingsVC.swift
//  ParseInstagramClone
//
//  Created by Ceren Çapar on 3.11.2021.
//

import UIKit
import Parse

class UploadVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        let keyboardGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(keyboardGestureRecognizer)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectPicture))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        postButton.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func selectPicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        postButton.isEnabled = true
    }
    
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        postButton.isEnabled = false
        
        let object = PFObject(className: "Posts")
        
        let date = imageView.image?.jpegData(compressionQuality: 0.5)
        let imageid = UUID().uuidString
        let pfImage = PFFileObject(name: "image", data: date!)
        
        object["postImage"] = pfImage
        object["comments"] = commentTextField.text
        object["postOwner"] = PFUser.current()!.username!
        object["postid"] = imageid
        
        object.saveInBackground { success, error in
            if error != nil {
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else {
                self.imageView.image = UIImage(named: "select")
                self.commentTextField.text = ""
                self.tabBarController?.selectedIndex = 0
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPost"), object: nil)
            }
        }
        
    }
    
    
}
