//
//  ViewController.swift
//  Instagraminator
//
//  Created by Jeffrey Eng on 6/20/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, Setup {
    
    @IBOutlet weak var imageView: UIImageView!
    
    lazy var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setup() {
        self.navigationItem.title = "Instagraminator"
    }
    
    func setupAppearance() {
         self.imageView.layer.cornerRadius = 3.0
    }
    
    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Source", message: "Please select the source type", preferredStyle: .ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
            self.presentImagePicker(.Camera)
        }
        
        let photosAction = UIAlertAction(title: "Photos", style: .Default) { (action) in
            self.presentImagePicker(.PhotoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photosAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addButtonSelected(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        }
        
        else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
    @IBAction func editButtonSelected(sender: AnyObject) {
        
        guard let image = self.imageView.image else { return }
        
        Filters.blackwhite(image) { (theImage) in
            self.imageView.image = theImage
        }
    }
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        
        guard let image = self.imageView.image else { return }
        
        API.shared.write(Post(image: image)) { (success) in
            if success {
                print("Yahoo!")
            }
        }
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


















