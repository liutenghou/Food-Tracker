//
//  Meal.swift
//  FoodTracker
//
//  Created by Liu Teng Hou on 4/24/18.
//  Copyright © 2018 Blue Anchor. All rights reserved.
//

import UIKit

class Meal {
    //MARK: Properties
    var name:String
    var photo:UIImage?
    var rating:Int
    
    //MARK: Initializer
    init?(name:String, photo:UIImage?, rating:Int){
        
        if name.isEmpty || rating < 0{
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
