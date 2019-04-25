//
//  bookService.swift
//  BookList
//
//  Created by MAC Consultant on 4/16/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import Foundation
typealias BookHandler = ([Book]?) -> Void

final class BookService{
    
    private init () {}
    static let shared = BookService()
    
    func getBooks(book: String?, completion: @escaping BookHandler){
        
        var myBooks = [Book]()
        
        
        guard let url = URL(string: bookAPI.bookSearchURL(from: book!)) else {
            
            completion([])
            print("Bad URL For Books")
            return
            
        }
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            
            
            if let error = err {
                
                print("No Data For books: \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let data = dat {
                
                do {
                    let bookObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    
                    
                    guard let books = bookObject["items"] as? [[String:Any]] else {
                        print("Wrong data structure")
                        return
                    }
                    
                    
                    
                    for bookDict in books {
                        
                        let book = try Book(with: bookDict)
                        myBooks.append(book!)
                        
                    }
                    
                    
                    DispatchQueue.main.async {
                        
                        completion(myBooks)
                    }
                    
                    
                    
                }catch{
                    
                    print("Couldn't Serialize Object: \(error.localizedDescription)")
                    completion(nil)
                    
                    return
                }
                print("successful")
                
            }
            
            }.resume()
        
        
    }
    
}
