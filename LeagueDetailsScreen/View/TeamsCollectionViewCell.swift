//
//  TeamsCollectionViewCell.swift
//  Sports
//
//  Created by Samuel Adel on 14/05/2024.
//

import UIKit
import Kingfisher
class TeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    func setup(team: LeagueDetailsModel) {
            teamName.text = team.awayTeamName
            if let logoURL = URL(string: team.awayTeamLogo) {
                teamLogo.kf.setImage(with: logoURL)
            }
            teamLogo.layer.cornerRadius = teamLogo.frame.size.width / 2
            teamLogo.clipsToBounds = true
        layer.cornerRadius=20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        }
}
