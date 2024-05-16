//
//  PlayerTableViewCell.swift
//  Sports
//
//  Created by Samuel Adel on 15/05/2024.
//

import UIKit
import Kingfisher
class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    
    @IBOutlet weak var playerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUP(player:Player){
        playerName.text = player.playerName ?? ""
        playerPosition.text = player.position ?? ""
        if player.playerImage != nil{
            if let imageURLString = player.playerImage,
            let imageURL = URL(string: imageURLString) {
                    playerImage.kf.setImage(with: imageURL)
                } else {
                    playerImage.image = UIImage(named: "playerHolder")
                }
        }
        
    }

}
