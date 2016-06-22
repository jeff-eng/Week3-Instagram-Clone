//
//  API.swift
//  Instagraminator
//
//  Created by Jeffrey Eng on 6/21/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import Foundation
import CloudKit

typealias APICompletion = (success: Bool) -> ()

class API {
    static let shared = API()
    
    let container : CKContainer
    let database : CKDatabase
    
    private init() { //Creating a true singleton here so it can't be tampered with
        self.container = CKContainer.defaultContainer()
        self.database = self.container.privateCloudDatabase
    }
    
    func write(post: Post, completion: APICompletion) {
        
        do {
            
            if let record = try Post.recordWith(post) {
                self.database.saveRecord(record, completionHandler: { (record, error) in
                    if error == nil && record != nil {
                        print(record)
                        completion(success: true)
                    }
                })
            }
        } catch let error { print(error) }
        
    }
}