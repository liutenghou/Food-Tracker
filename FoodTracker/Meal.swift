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
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    //MARK: Initializer
    init?(name:String, photo:UIImage?, rating:Int){
        
        //name cannot be empty
        guard !name.isEmpty else{
            return nil
        }
        
        //rating must be 0-5
        guard (rating >= 0) && (rating <= 5) else{
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    //MARK: NSCoding
    
    //save
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey:PropertyKey.nameKey)
        aCoder.encode(photo, forKey:PropertyKey.photoKey)
        aCoder.encode(rating, forKey:PropertyKey.ratingKey)
    }
    
    //load
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let nameDecoded = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as? String
            else {
                os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
                return nil
            }
        // Because photo is an optional property of Meal, just use conditional cast.
        let photoDecoded = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        guard let ratingDecoded = aDecoder.decodeObject(forKey: PropertyKey.ratingKey) as? Int
            else {
                os_log("Meal object has no rating", log:OSLog.default, type: .debug)
                return nil
            }
        
        //must call the designated initializer
        self.init(name:nameDecoded, photo:photoDecoded, rating:ratingDecoded)
    }
}
