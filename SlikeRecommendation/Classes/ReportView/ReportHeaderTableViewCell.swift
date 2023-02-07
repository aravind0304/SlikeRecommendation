//
//  ReportHeaderTableViewCell.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 07/02/23.
//

import UIKit

class ReportHeaderTableViewCell: UITableViewCell {
    var thisDeviceSelect = true
   // var isDeviceSelect = false

    @IBOutlet weak var imgR1: UIImageView!
    @IBOutlet weak var imgR2: UIImageView!

    @IBOutlet weak var imgRow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selctImage()

     

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func r1Action(_ sender: Any) {
        thisDeviceSelect = true
        self.selctImage()
    }
    @IBAction func r2Action(_ sender: Any) {
        thisDeviceSelect = false
        self.selctImage()

    }
    func selctImage() {
        if thisDeviceSelect {
            imgR1.image = RecBundleManager.image(named: "radio_button_checked")
            imgR2.image = RecBundleManager.image(named: "radio_button_unchecked")
        }else {
            imgR2.image = RecBundleManager.image(named: "radio_button_checked")
            imgR1.image = RecBundleManager.image(named: "radio_button_unchecked")
        }
    }
}
