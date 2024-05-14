//
//  LeagueDetailsCollectionViewController.swift
//  Sports
//
//  Created by Samuel Adel on 14/05/2024.
//

import UIKit


class LeagueDetailsCollectionViewController: UICollectionViewController {
    
    var viewModel:LeagueDetailsViewModel!
    
    let sectoinTitles:[String] = ["UpComing Events","Latest Results","Teams"]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout=createLayouts()
        viewModel=LeagueDetailsViewModel(network: DataFetcher.shared, leagueID: 4)
        viewModel.leaguesViewBinder = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.fetchData()
    }
    private func createLayouts()->UICollectionViewCompositionalLayout{
       return  UICollectionViewCompositionalLayout{ [weak self] sectionIndex,environment in
                   // print(index)
                    guard let self=self else {return nil}
                   switch sectionIndex{
                   case 0:
                       return self.upcomingEventsLayout()
                   case 1:
                       return self.latestResultsLayout()
                   case 2:
                       return self.teamsLayout()
                   default:
                       return nil
                   }
               
            }
    }
    private func supplementaryHeaderItem()->NSCollectionLayoutBoundarySupplementaryItem{
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
    }
    func upcomingEventsLayout()->NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(200)), subitems: [item])
        group.contentInsets=NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        let section=NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets=NSDirectionalEdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 16)
        section.boundarySupplementaryItems=[supplementaryHeaderItem()]
        return section
    }
    
    func latestResultsLayout() -> NSCollectionLayoutSection {
        print("Latest Result Called")
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        

        return section
    }
    func teamsLayout()->NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.50), heightDimension: .absolute(150)), subitems: [item])
        group.contentInsets=NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section=NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets=NSDirectionalEdgeInsets.init(top: 10, leading: 14, bottom: 10, trailing: 14)
        section.boundarySupplementaryItems=[supplementaryHeaderItem()]
        return section
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectoinTitles.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModel.getLeagueDetails().count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventsCell", for: indexPath)
        switch indexPath.section{
        case 0:
            let upComingEventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingEventsCell", for: indexPath) as! UpComingEventsCollectionViewCell
            upComingEventCell.setup(upcomingEvent: viewModel.getLeagueDetails()[indexPath.row])
            return upComingEventCell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventsCell", for: indexPath) as! LatestEventsCollectionViewCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCollectionViewCell
            return cell
        default:
            return cell
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeaderRV", for: indexPath) as! SectionHeaderCollectionReusableView
            header.setup(titleText: sectoinTitles[indexPath.section])
            print(sectoinTitles[indexPath.section])
            return header
        default:
            return UICollectionReusableView()
        }
    }



    // MARK: UICollectionViewDelegate

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
