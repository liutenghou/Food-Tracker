//
//  Meal.swift
//  FoodTracker
//
//  Created by Liu Teng Hou on 4/24/18.
//  Copyright © 2018 Blue Anchor. All rights reserved.
//

import UIKit
import os.log

class Meal : NSObject, NSCoding {
    //MARK: Properties
    var name:String
    var photo:UIImage?
    var rating:Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    
    //MARK: types
    struct PropertyKey{
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Initializer
    init?(name:String, photo:UIImage?, rating:Int){
        if name.isEmpty || rating < 0{
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey:PropertyKey.name)
        aCoder.encode(photo, forKey:PropertyKey.photo)
        aCoder.encode(rating, forKey:PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeObject(forKey: PropertyKey.rating)
        
        //must call the designated initializer
        self.init(name:name, photo:photo, rating:rating)
    }
}
