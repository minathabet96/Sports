//
//  UpComingEventsCollectionViewCell.swift
//  Sports
//
//  Created by Samuel Adel on 14/05/2024.
//

import UIKit

class UpComingEventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var matchStage: UILabel!
    
    @IBOutlet weak var matchTime: UILabel!
    
    @IBOutlet weak var matchDate: UILabel!
    
    @IBOutlet weak var awayTeamLogo: UIImageView!
    
    @IBOutlet weak var awayTeamName: UILabel!
    
    @IBOutlet weak var homeTeamLogo: UIImageView!
    
    
    @IBOutlet weak var homeTeamName: UILabel!
    
    
    @IBOutlet weak var upComingEventViewCell: UIView!

    
    func setup(upcomingEvent:LeagueDetailsModel){
        leagueName.text = upcomingEvent.leagueName
            matchDate.text = upcomingEvent.eventDate
            matchTime.text = upcomingEvent.evnetTime
            homeTeamName.text = upcomingEvent.homeTeamName
            awayTeamName.text = upcomingEvent.awayTeamName
        
        }
    
    
}
