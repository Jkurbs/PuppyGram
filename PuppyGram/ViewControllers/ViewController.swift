//
//  ViewController.swift
//  PuppyGram
//
//  Created by Kerby Jean on 5/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel = ViewModel()
    
    private let leftAndRightPaddings: CGFloat = 6.0
    private let numberOfItemsPerRow: CGFloat = 2.0
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        definesPresentationContext = true
        return searchController
    }()
    
    // MARK: - UI Element
    lazy var collectionView: UICollectionView = {
        
        let width = (view.frame.width - leftAndRightPaddings*(numberOfItemsPerRow+1)) / numberOfItemsPerRow
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: width * 1.4)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 50, left: 5, bottom: 30, right: 5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        navigationItem.searchController = searchController
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        collectionView.register(PuppyCell.self, forCellWithReuseIdentifier: PuppyCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Functions
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
    }
}



// MARK: - UICollectionViewDelegate/UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PuppyCell.identifier, for: indexPath) as? PuppyCell else {
            fatalError()
        }
        cell.puppyItem = viewModel.item(atIndex: indexPath.row)
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel.filterContentForSearchText(searchBar.text!)
        self.collectionView.reloadData()
    }
}



