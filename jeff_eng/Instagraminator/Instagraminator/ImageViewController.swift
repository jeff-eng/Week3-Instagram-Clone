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
        // self.imageView.layer.cornerRadius = 3.0
    }
    
    lazy var imagePicker = UIImagePickerController()
    
    
}

