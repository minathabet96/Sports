//
//  TeamDetailsTableViewController.swift
//  Sports
//
//  Created by Samuel Adel on 15/05/2024.
//

import UIKit

class TeamDetailsTableViewController: UITableViewController {
    var viewModel:TeamDetailsViewModel!
    var leageDetailsViewModel:LeagueDetailsViewModel!
    var loadingView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel = TeamDetailsViewModel(network: DataFetcher.shared,  teamId: leageDetailsViewModel.getSelectedTeamId() ?? 0, sportType: leageDetailsViewModel.getSportType())
        viewModel.teamDetailsViewBinder = {
            [weak self] in
            DispatchQueue.main.async {
                self?.hideLoading()
                self?.tableView.reloadData()
            }
        }
        showLoading()
        viewModel.fetchData()
    }
    func createLoadingView() -> UIView {
           let loadingView = UIView(frame: tableView.bounds)
           loadingView.backgroundColor = UIColor(white: 0, alpha: 0.2)
           let activityIndicator = UIActivityIndicatorView(style: .large)
           activityIndicator.center = loadingView.center
           loadingView.addSubview(activityIndicator)
           activityIndicator.startAnimating()
           return loadingView
       }

       func showLoading() {
           loadingView = createLoadingView()
           tableView.addSubview(loadingView!)
       }

       func hideLoading() {
           loadingView?.removeFromSuperview()
           loadingView = nil
       }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            if  (viewModel.getTeamDetails().teamPlayers == nil){
                return 200
            }else{
                return 80
            }
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 1
        case 1:
             if (viewModel.getTeamDetails().teamPlayers == nil)  {
                return 1
             }else{
                 return viewModel.getTeamDetails().teamPlayers?.count ?? 0
             }
         default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! TeamLogoTableViewCell
            imageCell.setup(teamDetails: viewModel.getTeamDetails())
            return imageCell
        case 1:
            if (viewModel.getTeamDetails().teamPlayers == nil)  {
                print("Players are nil or empty")
                let playerImageHolderCell = tableView.dequeueReusableCell(withIdentifier: "playersImageHolder", for: indexPath)
                return playerImageHolderCell
            }
        let playerCell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
            playerCell.setUP(player: (viewModel.getTeamDetails().teamPlayers?[indexPath.row])!)
            return playerCell
        default:
            return UITableViewCell.init()
        }

    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
          switch section {
          case 0:
              return nil
          case 1:
              return "Players"
          default:
              return nil
          }
      }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
