//
//  ReoprtOptionTableViewCell.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 14/02/23.
//

import UIKit

class ReoprtOptionTableViewCell: UITableViewCell {
    @IBOutlet weak var line: UIImageView!
    
    @IBOutlet weak var radioBtn: UIImageView!
    
    @IBOutlet weak var lblHint: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        radioBtn.image = RecBundleManager.image(named: "radio_button_unchecked")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
