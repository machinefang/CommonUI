//
//  ViewController.swift
//  UploadPics
//
//  Created by Fang, Xin on 8/21/17.
//  Copyright © 2017 XFang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


protocol FirebaseReferences {}
extension FirebaseReferences {
    var dbRef : DatabaseReference {
        return Database.database().reference()
    }
    var userid : String? {
        return Auth.auth().currentUser?.uid
    }
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FirebaseReferences {
    var imagePicker : UIImagePickerController = UIImagePickerController()

    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
    }


    @IBAction func uploadButtonClicked(_ sender: Any) {
//        uploadButton.isEnabled = false

        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            self.imagePicker.sourceType = .photoLibrary
            self.present()
        }else{
            self.present(self.showAlert(Title: "Title", Message: "Library is not available on this Device or accesibility has been revoked!"), animated: true, completion: nil)

        }

    }

    @IBAction func cameraButtonClicked(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            self.imagePicker.sourceType = .camera
            self.present()
        }
        else{
            self.present(self.showAlert(Title: "Title", Message: "Camera is not available on this Device or accesibility has been revoked!"), animated: true, completion: nil)

        }



    }

    func present(){
        self.present(imagePicker, animated: true, completion: nil)

    }

     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("info of the pic reached :\(info) ")
        self.imagePicker.dismiss(animated: true, completion: nil)
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
        var data = NSData()
        data = UIImageJPEGRepresentation(self.imageView.image!, 0.8)! as NSData
        // set upload path
        let filePath = "\(Auth.auth().currentUser!.uid)/\("userPhoto")"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        self.dbRef.child(filePath).putData(data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                //store downloadURL
                let downloadURL = metaData!.downloadURL()!.absoluteString
                //store downloadURL at database
                self.databaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["userPhoto": downloadURL])
            }
            
        }
        
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }



    func showAlert(Title : String!, Message : String!)  -> UIAlertController {

        let alertController : UIAlertController = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let okAction : UIAlertAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            print("User pressed ok function")

        }

        alertController.addAction(okAction)
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        
        return alertController
    }


}

