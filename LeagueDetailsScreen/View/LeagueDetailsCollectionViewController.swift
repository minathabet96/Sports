//
//  LeagueDetailsCollectionViewController.swift
//  Sports
//
//  Created by Samuel Adel on 14/05/2024.
//

import UIKit

class LeagueDetailsCollectionViewController: UICollectionViewController {
    var hideLoadingVar:Int=0
    var viewModel:LeagueDetailsViewModel!
    var loadingView: UIView?
    /// TODO add fav model 
    var leagueViewModle:LeaguesViewModel!
    let sectoinTitles:[String] = ["UpComing Events","Latest Results","Teams"]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout=createLayouts()
        viewModel=LeagueDetailsViewModel(network: DataFetcher.shared, league: leagueViewModle.getSelectedLeague()! , sportType: leagueViewModle.sportParam)
        registeringViewModels()
        addAddIcon()
        showLoading()
        viewModel.fetchData()
    }
    
    private func registeringViewModels(){
        viewModel.upcomingEventsViewBinder = { [weak self] in
            DispatchQueue.main.async {
                self?.hideLoadingVar += 1
                if self?.hideLoadingVar == 2{
                    self?.hideLoading()
                }
                self?.collectionView.reloadData()
            }
        }
        viewModel.latestResultsViewBinder={
            [weak self] in
                DispatchQueue.main.async {
                    self?.hideLoadingVar += 1
                    if self?.hideLoadingVar == 2{
                        self?.hideLoading()
                    }
                    self?.collectionView.reloadData()
                }
        }
    }
    private func addAddIcon(){
        var iconImage = UIImage(named: "fav_unselected")
        if  CoreDataManager.shared.checkIfLeagueIsFav(leagueId: viewModel.getCurrentLeagueData().leagueID) {
            iconImage = UIImage(named: "fav_selected")
        }
         let iconButton = UIBarButtonItem(image: iconImage, style: .plain, target: self, action: #selector(iconTapped))
        navigationItem.rightBarButtonItem = iconButton
    }
    @objc func iconTapped() {
        if CoreDataManager.shared.checkIfLeagueIsFav(leagueId: viewModel.getCurrentLeagueData().leagueID) {
            CoreDataManager.shared.removeLeague(leagueId: viewModel.getCurrentLeagueData().leagueID)
            addAddIcon()
        }else{
            CoreDataManager.shared.addLeague(league: viewModel.getLeagueFavModel())
            addAddIcon()
        }
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
        section.contentInsets=NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 10, trailing: 16)
        section.boundarySupplementaryItems=[supplementaryHeaderItem()]
        return section
    }
    
    func latestResultsLayout() -> NSCollectionLayoutSection {
        print("Latest Result Called")
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(500)), subitems: [item])
        group.interItemSpacing = .fixed(20)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    func teamsLayout()->NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.50), heightDimension: .absolute(150)), subitems: [item])
        group.contentInsets=NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section=NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets=NSDirectionalEdgeInsets.init(top: 0, leading: 14, bottom: 10, trailing: 14)
        section.boundarySupplementaryItems=[supplementaryHeaderItem()]
        return section
        
    }
    func createLoadingView() -> UIView {
           let loadingView = UIView(frame: collectionView.bounds)
           loadingView.backgroundColor = UIColor(white: 0, alpha: 0.2)
           let activityIndicator = UIActivityIndicatorView(style: .large)
           activityIndicator.center = loadingView.center
           loadingView.addSubview(activityIndicator)
           activityIndicator.startAnimating()
           return loadingView
       }

       func showLoading() {
           loadingView = createLoadingView()
           collectionView.addSubview(loadingView!)
       }

       func hideLoading() {
           loadingView?.removeFromSuperview()
           loadingView = nil
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
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            print("indexPath.row \(indexPath.row)")
            viewModel.setSelectedTeamId(teamId:viewModel.getLeagueTeams()[indexPath.row].homeTeamKey ?? 0 )
            let teamDetails:TeamDetailsTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "teamDetailsTVC") as! TeamDetailsTableViewController
            teamDetails.leageDetailsViewModel = viewModel
            self.present(teamDetails, animated: true)
        }
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectoinTitles.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section{
        case 0:
            if viewModel.getLeagueUpcomingEvents().isEmpty{
                return 1

            }else{
                return   viewModel.getLeagueUpcomingEvents().count
            }
        case 1:
            if viewModel.getLeagueLatestResults().isEmpty{
                return 1
            }else{
                return   viewModel.getLeagueLatestResults().count
            }
        case 2:
            if viewModel.getLeagueTeams().isEmpty{
                return 1
            }
            else{
                return   viewModel.getLeagueTeams().count
            }
        default:
            return    0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            if viewModel.getLeagueUpcomingEvents().isEmpty{
                let upComingEventCellEmpty = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImageHolder", for: indexPath)
                return upComingEventCellEmpty
            }
            let upComingEventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingEventsCell", for: indexPath) as! UpComingEventsCollectionViewCell
            upComingEventCell.setup(upcomingEvent: viewModel.getLeagueUpcomingEvents()[indexPath.row])
            return upComingEventCell
        case 1:
            if viewModel.getLeagueLatestResults().isEmpty{
                let upComingEventCellEmpty = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImageHolder", for: indexPath)
                return upComingEventCellEmpty
            }
            let latestResult = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventsCell", for: indexPath) as! LatestEventsCollectionViewCell
            latestResult.setup(latestResult: viewModel.getLeagueLatestResults()[indexPath.row])
            return latestResult
        case 2:
            if viewModel.getLeagueTeams().isEmpty{
                let upComingEventCellEmpty = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImageHolder", for: indexPath)
                return upComingEventCellEmpty
            }
            let teamsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCollectionViewCell
            teamsCell.setup(team: viewModel.getLeagueTeams()[indexPath.row])
            return teamsCell
        default:
            return UICollectionViewCell.init()
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
