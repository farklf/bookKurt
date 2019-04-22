//
//  Book.swift
//  BookList
//
//  Created by MAC Consultant on 4/14/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import Foundation
import UIKit

class viewModel {
    
    
    var id: String
    var kind: String
    var etag: String
    var thumbnail: UIImage
    
    init( thumbnail: UIImage, id: String, kind: String, etag: String) {
       
        self.id = id
        self.kind = kind
        self.etag = etag
        self.thumbnail = thumbnail
    }
}
