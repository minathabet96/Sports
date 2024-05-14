//
//  LatestEventsCollectionViewCell.swift
//  Sports
//
//  Created by Samuel Adel on 14/05/2024.
//

import UIKit
import Kingfisher
class LatestEventsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var team1Name: UILabel!
    
    @IBOutlet weak var team1Logo: UIImageView!
    @IBOutlet weak var matchTime: UILabel!
    @IBOutlet weak var team2Logo: UIImageView!
    
    @IBOutlet weak var team2Name: UILabel!
    
    
    
    @IBOutlet weak var latestEventContainer: UIView!
    
    func setup(latestResult:LeagueDetailsModel){
        team1Name.text = latestResult.homeTeamName
        team2Name.text = latestResult.awayTeamName
        matchTime.text = latestResult.eventFinalResult
        if let team1LogoURL = URL(string: latestResult.homeTeamLogo ?? "") {
                team1Logo.kf.setImage(with: team1LogoURL)
            }
               
        if let team2LogoURL = URL(string: latestResult.awayTeamLogo ?? "") {
                team2Logo.kf.setImage(with: team2LogoURL)
            }
        layer.cornerRadius=10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
