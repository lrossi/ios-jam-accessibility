//
//  AdsListViewController.swift
//  Demo
//
//  Created by Ludovico Rossi on 15/05/2018.
//  Copyright © 2018 Schibsted Products & Technology. All rights reserved.
//

import UIKit

class AdsListViewController: UICollectionViewController {
    let storage: Storage = ExampleDataStorage()
    
    private let padding: CGFloat = 16
    private let interCellSpacing: CGFloat = 12
    private let showAdDetailSegue = "showAdDetail"
    private var selectedIndexPath: IndexPath?
    
    private var flowLayout: UICollectionViewFlowLayout {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            preconditionFailure()
        }
        return flowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flowLayout.estimatedItemSize = CGSize(width: 160, height: 1)
        flowLayout.minimumInteritemSpacing = interCellSpacing
        flowLayout.minimumLineSpacing = interCellSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom:
            padding, right: padding)
        flowLayout.sectionHeadersPinToVisibleBounds = true
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search ads", comment: "")
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storage.numberOfAds
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AdCell.self), for: indexPath) as? AdCell else {
            preconditionFailure("Unexpected cell type")
        }
        
        let ad = storage.ad(at: indexPath.item)
        let width = cellWidth()
        cell.configure(for: ad)
        cell.setWidth(width)
        
        cell.didToggleFavoriteStatus = { [weak self] in
            guard let ad = self?.storage.ad(at: indexPath.item) else {
                return
            }
            ad.isFavorite = !ad.isFavorite
            
            guard let cell = self?.collectionView?.cellForItem(at: indexPath) as? AdCell else {
                return
            }
            cell.updateAccessibility(for: ad)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: InfoView.self), for: indexPath) as? InfoView else {
            preconditionFailure("Unexpected view type")
        }
        
        let text: String
        
        switch storage.numberOfAds {
        case 0:
            text = NSLocalizedString("No ads found", comment: "")
        case 1:
            text = NSLocalizedString("1 ad found", comment: "")
        case let n:
            text = String(format: NSLocalizedString("%d ads found", comment: ""), n)
        }
        
        view.confugure(for: text)
        
        return view
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: showAdDetailSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard
            segue.identifier == showAdDetailSegue,
            let adDetailViewController = segue.destination as? AdDetailViewController,
            let selectedIndexPath = selectedIndexPath
        else {
            return
        }
        
        adDetailViewController.ad = storage.ad(at: selectedIndexPath.item)
        self.selectedIndexPath = nil
    }
    
    func cellWidth() -> CGFloat {
        return floor((UIScreen.main.bounds.width - padding - padding - interCellSpacing) / 2.0)
    }
}

extension AdsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 1, height: storage.isFiltering ? 55 : 0)
    }
}

extension AdsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        storage.filter(for: searchText)
        collectionView?.reloadData()
    }
}
