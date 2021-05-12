//
//  ViewModel.swift
//  PuppyGram
//
//  Created by Kerby Jean on 5/12/21.
//

import Foundation

class ViewModel {
    
    // MARK: Properties
    var puppyItems: [Item] = []
    var filteredPuppyItems: [Item] = []
    var isFiltering = false 
    
    /// Return items count when filtering is true or false
    var itemCount: Int {
        if isFiltering {
            return filteredPuppyItems.count
        } else {
            return puppyItems.count
        }
        
    }
    
    
    // MARK: Functions
    func loadData(completionHandler: @escaping () -> Void) {
        Services.shared.fetchData(completionHandler: { (result) in
            let puppyItems = try! result.get()
            print(puppyItems)
            DispatchQueue.main.async {
                self.puppyItems = puppyItems
                completionHandler()
            }
        })
    }
    
    /// Return index when filtering is true or false
    func item(atIndex index: Int) -> Item {
        if isFiltering {
            return filteredPuppyItems[index]
        } else {
            return puppyItems[index]
        }
    }
    
    /// Filter puppy items and assign result to filteredPuppyItems
    func filterContentForSearchText(_ searchText: String?) {
        if searchText != "" {
            isFiltering = true
            filteredPuppyItems = puppyItems.filter { (puppyItem: Item) -> Bool in
                return puppyItem.title.lowercased().contains(searchText!.lowercased())
            }
        } else {
            isFiltering = false
        }
    }
}
