//
//  ReportHeaderTableViewCell.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 07/02/23.
//

import UIKit

class ReportHeaderTableViewCell: UITableViewCell {
    var thisDeviceSelect = true
    var reportDay = 11
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!

    @IBOutlet weak var lblHint: UILabel!
    @IBOutlet weak var selctAnIssue: UILabel!

    @IBOutlet weak var imgR1: UIImageView!
    @IBOutlet weak var imgR2: UIImageView!

    @IBOutlet weak var imgRow: UIImageView!
    
    @IBOutlet weak var imgToday: UIImageView!
    @IBOutlet weak var imgWeek: UIImageView!
    @IBOutlet weak var imgMonth: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selctImage()
        self.selctReportDay()
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
    @IBAction func issueFaceOnAction(_ sender: Any) {
        if let btn = sender as? UIButton {
            self.reportDay = btn.tag
        }
        self.selctReportDay()
    }
    func selctReportDay() {
        imgToday.image = RecBundleManager.image(named: "radio_button_unchecked")
        imgWeek.image = RecBundleManager.image(named: "radio_button_unchecked")
        imgMonth.image = RecBundleManager.image(named: "radio_button_unchecked")
        
        if self.reportDay == 11 {
            imgToday.image = RecBundleManager.image(named: "radio_button_checked")
        }else if self.reportDay == 12 {
            imgWeek.image = RecBundleManager.image(named: "radio_button_checked")
        }
        else if self.reportDay == 13 {
            imgMonth.image = RecBundleManager.image(named: "radio_button_checked")
        }

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
