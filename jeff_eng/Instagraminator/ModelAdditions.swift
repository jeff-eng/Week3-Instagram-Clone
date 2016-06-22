//
//  ModelAdditions.swift
//  Instagraminator
//
//  Created by Jeffrey Eng on 6/21/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import UIKit
import CloudKit

enum PostError : ErrorType {
    case WritingImage
    case CreateCKRecord
}

extension Post {

    class func recordWith(post: Post) throws -> CKRecord? {   //CKRecord is optional b/c it could fail

        let imageURL = NSURL.imageURL() //Gets the URL for the image
        guard let data = UIImageJPEGRepresentation(post.image, 0.7) else { throw PostError.WritingImage } //Do compression on image if available
        
        let saved = data.writeToURL(imageURL, atomically: true)
        
        if saved {
            
            let asset = CKAsset(fileURL: imageURL) //URL is path to documents directory in our device
            let record = CKRecord(recordType: "Post") //Creates a new CKRecord with type of 'Post as a key-value pair
            record.setObject(asset, forKey: "image") //Sets they key to 'image' and the value is the asset(the constant set above)
            
            return record
            
        } else {
            throw PostError.CreateCKRecord
        }
    }
    
}