//
//  LeaguesTableViewController.swift
//  Sports
//
//  Created by Mina on 12/05/2024.
//

import UIKit
import Kingfisher
class LeaguesTableViewController: UITableViewController {
    var viewModel: LeaguesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LeaguesTableViewCell")
        viewModel.leaguesViewBinder = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchData()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getLeagues().count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesTableViewCell", for: indexPath) as! LeaguesTableViewCell
        if !viewModel.getLeagues().isEmpty {
            switch viewModel.sportParam {
            case "tennis":
                cell.cellImage.kf.setImage(with: URL(string: "https://static.vecteezy.com/system/resources/previews/000/488/409/original/tennis-cup-winner-gold-stock-vector-illustration.jpg"))
            case "basketball":
                cell.cellImage.kf.setImage(with: URL(string: "https://www.fiba.basketball/api/img/graphic/5f1a2c53-ff81-4b23-9c4f-bd85d75c6d98/1000/1000?mt=.jpg"))
            case "cricket":
                cell.cellImage.kf.setImage(with: URL(string: "https://5.imimg.com/data5/SELLER/Default/2021/7/BM/TC/ED/5388092/4-500x500.JPG"))
            default:
                cell.cellImage.kf.setImage(with: URL(string: viewModel.getLeagues()[indexPath.row].leagueLogo ?? "https://cloudfront-us-east-2.images.arcpublishing.com/reuters/5ZD3FGEX2JJU7FZSN2FDIIXFQ4.jpg"))
            }
            
            cell.cellLabel.text = viewModel.getLeagues()[indexPath.row].leagueName
        }
        
        return cell
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
