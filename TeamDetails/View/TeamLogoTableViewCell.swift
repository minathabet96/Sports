//
//  TeamLogoTableViewCell.swift
//  Sports
//
//  Created by Samuel Adel on 15/05/2024.
//

import UIKit

class TeamLogoTableViewCell: UITableViewCell {
    @IBOutlet weak var teamLogo: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    
    
    
    @IBOutlet weak var teamCoachName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(teamDetails:Team){
        teamName.text = teamDetails.teamName ?? "Unknown"
        if teamDetails.teamLogo != nil{
            if let logoUrlString = teamDetails.teamLogo,
               let logoUrl = URL(string: logoUrlString) {
                teamLogo.kf.setImage(with: logoUrl)
            } else {
                if let basketballImage = UIImage(named: "basketball_illustration") {
                        teamLogo.image = basketballImage
                        teamLogo.layer.cornerRadius = basketballImage.size.width / 2
                        teamLogo.layer.masksToBounds = true
                    }
            }
        }
        if let coach = teamDetails.teamCoach?.first {
            teamCoachName.text = coach.coachName ?? ""
        } else {
            teamCoachName.text = "Unknown Coach"
        }
    }
    
}
