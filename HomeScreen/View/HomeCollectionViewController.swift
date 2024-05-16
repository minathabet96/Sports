//
//  HomeCollectionViewController.swift
//  Sports
//
//  Created by Mina on 12/05/2024.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController{
    var viewModel: HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        collectionView.delegate = self
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = "Sports"
    }
    
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let collectionViewWidth = collectionView.bounds.width
    //        let spacing: CGFloat = 20
    //        let itemsPerRow: CGFloat = 2
    //
    //
    //        let itemWidth = (collectionViewWidth - spacing * (itemsPerRow + 1)) / itemsPerRow
    //
    //
    //        return CGSize(width: itemWidth, height: collectionView.bounds.height)
    //    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModel.getSports().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.cellLabel.text = viewModel.getSports()[indexPath.row].title
        cell.cellImage.image = UIImage(named: viewModel.getSports()[indexPath.row].image)
        cell.layer.cornerRadius = 24
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesVC = self.storyboard?.instantiateViewController(identifier: "leagues") as! LeaguesTableViewController
        let title = viewModel.getSports()[indexPath.row].title
        if title == "Hockey" || title == "Volleyball" || title == "Baseball" {
            let alert = UIAlertController(title: "Coming soon", message: "this sport is currently unavailable", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }
        else {
            leaguesVC.viewModel = LeaguesViewModel(network: DataFetcher.shared, sportParam: viewModel.getSports()[indexPath.row].title.lowercased())
            self.navigationController?.pushViewController(leaguesVC, animated: true)
        }
    }
        func setup() {
            let itemWidth = (collectionView.frame.width / 2 ) - 10
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 80)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            collectionView.collectionViewLayout = layout
            //  collectionView(T##UICollectionView, layout: T##UICollectionViewLayout, sizeForItemAt: T##IndexPath)        }
            
        }
    
        
        //    func drawFirstLayout() -> NSCollectionLayoutSection {
        //        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        //        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //
        //        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalHeight(0.3))
        //        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        //        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        //        let section = NSCollectionLayoutSection(group: group)
        //
        //        section.orthogonalScrollingBehavior = .continuous
        //        section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 16, bottom: 16, trailing: 0)
        //        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
        //        }
        //        return section
        //    }
        
        /*
         // Uncomment this method to specify if the specified item should be highlighted during tracking
         override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
         return true
         }
         */
        
        /*
         // Uncomment this method to specify if the specified item should be selected
         override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
         return true
         }
         */
        
        /*
         // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
         override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
         return false
         }
         
         override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
         return false
         }
         
         override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
         
         }
         */
        
    }

