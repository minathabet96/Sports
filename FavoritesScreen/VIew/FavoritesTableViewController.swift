//
//  FavoritesTableViewController.swift
//  Sports
//
//  Created by Mina on 14/05/2024.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    var viewModel: FavoritesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoritesViewModel()
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LeaguesTableViewCell")
        print(viewModel.getLeagues().count)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setSelectedLeague(league: viewModel.getLeagues()[indexPath.row])
        let leageDetails:LeagueDetailsCollectionViewController = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsCollectionViewController
        leageDetails.favLeaguesViewModel=viewModel
        self.present(leageDetails, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = "Favorites"
        print(viewModel.getLeagues().count)
        tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getLeagues().count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesTableViewCell", for: indexPath) as! LeaguesTableViewCell
        cell.cellImage.layer.cornerRadius = 24
        cell.cellImage.image = UIImage(data: viewModel.getLeagues()[indexPath.row].img)
        cell.cellLabel.text = viewModel.getLeagues()[indexPath.row].title
        
        return cell
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Delete") { [weak self] _, _, _ in
            let alert = UIAlertController(title: "Delete league", message: "Are you sure you want to delete this league?", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Delete", style: .destructive) { _ in
                self?.viewModel.removeLeague(index: self?.viewModel.getLeagues()[indexPath.row].id ?? 0)
                tableView.reloadData()
            }
            let action2 = UIAlertAction(title: "cancel", style: .cancel)
            alert.addAction(action2)
            alert.addAction(action1)
            self?.present(alert, animated: true)
        }
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
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
