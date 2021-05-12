//
//  ViewController.swift
//  PuppyGram
//
//  Created by Kerby Jean on 5/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    var puppyItems = [Item]()
    
    private let leftAndRightPaddings: CGFloat = 6.0
    private let numberOfItemsPerRow: CGFloat = 2.0
    
    // MARK: - UI Element
    var collectionView: UICollectionView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    // MARK: - Functions
    func setupViews() {
        
        view.backgroundColor = .white

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 40, width: view.frame.width, height: 100))
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        titleLabel.text = "Hi,\nWelcome to PuppyGram"
        
        view.addSubview(titleLabel)
        
        let width = (view.frame.width - leftAndRightPaddings*(numberOfItemsPerRow+1)) / numberOfItemsPerRow
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: width * 1.4)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 30, left: 5, bottom: 30, right: 5)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: titleLabel.layer.frame.maxY, width: view.frame.width, height: 100), collectionViewLayout: layout)
        collectionView.register(PuppyCell.self, forCellWithReuseIdentifier: PuppyCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    func loadData() {
        Services.shared.fetchData(completionHandler: {[weak self] (result) in
            let puppyItems = try! result.get()
            DispatchQueue.main.async {
                self?.puppyItems = puppyItems
                self?.collectionView.reloadData()
            }
        })
    }
}



// MARK: - UICollectionViewDelegate/UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        puppyItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PuppyCell.identifier, for: indexPath) as? PuppyCell else {
            fatalError()
        }
        let puppy = puppyItems[indexPath.row]
        cell.puppy = puppy
        return cell
    }
}



