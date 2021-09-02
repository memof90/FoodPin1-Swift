//
//  Restaurant.swift
//  FoodPin
//
//  Created by Memo Figueredo on 2/9/21.
//

import Foundation

struct Restaurant : Hashable {
    var name: String = ""
    var type: String = ""
    var location: String = ""
    var image: String = ""
    var isFavorite: Bool = false
    
//    create instance to structure to restaurant
    init(name: String, type: String, location: String, image: String, isFavorite: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isFavorite = isFavorite
    }
//    create to define multiple initializers that accept diferent parameters and inicializer the seem object Restaurant()
    init() {
        self.init(name: "", type: "", location: "", image: "", isFavorite: false)
    }
}


