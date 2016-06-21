//
//  ViewController.swift
//  Instagraminator
//
//  Created by Jeffrey Eng on 6/20/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate /*Setup*/ { // need to create a Protocol.swift file with a protocol named Setup

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addButtonSelected: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setup() {
        self.navigationItem.title = "Instagraminator"
    }
    
    func setUpAppearance() {
         self.imageView.layer.cornerRadius = 3.0
    }
    
    lazy var imagePicker = UIImagePickerController()
    
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
    }
}

