//
//  Photo.swift
//  Milestone Project 3
//
//  Created by Maria Luiza Carvalho Sperotto on 17/10/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import Foundation
import UIKit

class Photo: NSObject {
    var caption: String
    var image: String
    
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = image
    }
}


