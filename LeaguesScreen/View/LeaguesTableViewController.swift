//
//  LeaguesTableViewController.swift
//  Sports
//
//  Created by Mina on 12/05/2024.
//

import UIKit
import Kingfisher
import Reachability
class LeaguesTableViewController: UITableViewController {
    var viewModel: LeaguesViewModel!
    var loadingView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Leagues"
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LeaguesTableViewCell")
        self.showLoading()
        viewModel.leaguesViewBinder = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchData()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setSelectedLeague(selectedLeague:viewModel.getLeagues()[indexPath.row])
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            handleReachability(viewController: self)
            }
        else {
            let leageDetails:LeagueDetailsCollectionViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsCollectionViewController
            leageDetails.leagueViewModle=viewModel
            
            self.navigationController?.pushViewController(leageDetails, animated: true)
        }
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
                cell.cellImage.kf.setImage(with: URL(string: "https://static.vecteezy.com/system/resources/previews/000/488/409/original/tennis-cup-winner-gold-stock-vector-illustration.jpg"), completionHandler: { result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            self.hideLoading()
                        }
                        
                    case .failure(let error):
                        print("Error loading image: \(error.localizedDescription)")
                    }
                })
            case "basketball":
                cell.cellImage.kf.setImage(with: URL(string: "https://www.fiba.basketball/api/img/graphic/5f1a2c53-ff81-4b23-9c4f-bd85d75c6d98/1000/1000?mt=.jpg"), completionHandler: { result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            self.hideLoading()
                        }
                        
                    case .failure(let error):
                        print("Error loading image: \(error.localizedDescription)")
                    }
                })
            case "cricket":
                cell.cellImage.kf.setImage(with: URL(string: "https://5.imimg.com/data5/SELLER/Default/2021/7/BM/TC/ED/5388092/4-500x500.JPG"), completionHandler: { result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            self.hideLoading()
                        }
                        
                    case .failure(let error):
                        print("Error loading image: \(error.localizedDescription)")
                    }
                })
            default:
                cell.cellImage.kf.setImage(with: URL(string: viewModel.getLeagues()[indexPath.row].leagueLogo ?? "https://cloudfront-us-east-2.images.arcpublishing.com/reuters/5ZD3FGEX2JJU7FZSN2FDIIXFQ4.jpg"), completionHandler: { result in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            self.hideLoading()
                        }
                        
                    case .failure(let error):
                        print("Error loading image: \(error.localizedDescription)")
                    }
                })}
            
            cell.cellLabel.text = viewModel.getLeagues()[indexPath.row].leagueName
        }
        
        return cell
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
func handleReachability(viewController: UIViewController) {
    let alert = UIAlertController(title: nil, message: "There's no internet connection", preferredStyle: .actionSheet)
    viewController.present(alert, animated: true)
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        alert.dismiss(animated: true)
    }
}
