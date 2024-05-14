//
//  SectionHeaderCollectionReusableView.swift
//  Sports
//
//  Created by Samuel Adel on 14/05/2024.
//

import UIKit

class SectionHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var sectionTitleText: UILabel!
    
    func setup(titleText:String){
        sectionTitleText.text=titleText
    }
}
