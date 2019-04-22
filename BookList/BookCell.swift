//
//  BookCell.swift
//  BookList
//
//  Created by MAC Consultant on 4/14/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    
    @IBOutlet weak var bookthumbNail: UIImageView!
    
    @IBOutlet weak var bookKindLabel: UILabel!
    
    @IBOutlet weak var bookIdLabel: UILabel!
        
    @IBOutlet weak var bookEtagLabel: UILabel!
    
    func setBook(book: Book) {
        
        bookKindLabel.text = book.kind
        bookIdLabel.text = book.id
        bookEtagLabel.text = book.etag
   //   bookthumbNail.image = book.thumbnail
        
    }
    
    
    
    
    
}
