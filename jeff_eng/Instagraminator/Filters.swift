//
//  Filters.swift
//  Instagraminator
//
//  Created by Jeffrey Eng on 6/21/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (theImage: UIImage?) -> ()

class Filters {
    
    static var original = UIImage() //Store a reference to original in case the user changes their mind and doesn't want to apply the filter
    
    private class func filter(name: String, image: UIImage, completion: FiltersCompletion) {
        
        NSOperationQueue().addOperationWithBlock {
            
            guard let filter = CIFilter(name: name) else { fatalError("Incorrect. Try again.") }
            
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey) //The CIImage(image: image) converts from UIImage to CIImage
            
            //Creating a context for the image
            let options = [kCIContextWorkingColorSpace : NSNull()] //NSNull is an object representing nil
            let eAGContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let gPUContext = CIContext(EAGLContext: eAGContext, options: options)
            
            guard let outputImage = filter.outputImage else { fatalError("Error creating output image") }//Filtered output image and saves reference to it OR Throw fatal error if output image fails
            
            let cgImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                completion(theImage: UIImage(CGImage: cgImage))
            })
            
            for name in CIFilter.filterNamesInCategories(nil){ print(name) }
        }
        
        
    }
    
    class func blackwhite(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    class func chrome(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    
    class func vintage(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    //Another filter
    
    //Another filter
}
