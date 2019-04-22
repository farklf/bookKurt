//
//  BookListScreen.swift
//  BookList
//
//  Created by MAC Consultant on 4/14/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class BookListScreen: UIViewController {

    var books: [Book] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var myBooks = [Book]() {
    didSet {
    //Dispatch Queue, is called GCD (Grand Central Dispatch) and is how we handle multithreading
    //The main thread is where ALL UI changes must occur, this is asynchronous
    DispatchQueue.main.async {
    self.tableView.reloadData()
    }
    }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createSearchBar()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchController.isActive = false
        searchController.definesPresentationContext = true
        
        
    }
    func createSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "search books..."
        
    }
    
    
   

}
extension BookListScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //tells the table view how many rows to produce
//        return self.books.count
  //        return myBooks.count
        
        return myBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
            
              let  book = myBooks[indexPath.row]
            
            cell.bookKindLabel.text = book.kind
            cell.bookIdLabel.text = book.id
            cell.bookEtagLabel.text = book.etag
        
            print(book.kind)
            print(book.etag)
            print(book.id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            //remove beer in array at the indexPath.row
            books.remove(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Add this to un-highlight the row that was tapped
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //Select the correct beer from the array
        let book = myBooks[indexPath.row]
        
        
        //pass in the beer to the detail VC
         let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
         
         detailVC.kind = book.kind
         detailVC.id = book.id
         detailVC.etag = book.etag
         detailVC.thumbnail = book.thumbnail
         
         //present the detail VC
         self.navigationController?.pushViewController(detailVC, animated: true)
        
        
        
        
        
    }
    
} // end extension

extension BookListScreen: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        BookService.shared.getBooks(viewModel: searchController.searchBar.text?.replacingOccurrences(of: " ", with: ""), completion: { [weak self] bk in
            
            if let books =  bk {self?.myBooks = books}
            
            }
        )
    }
}
