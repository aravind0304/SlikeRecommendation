//
//  ReportHeaderTableViewCell.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 07/02/23.
//

import UIKit
protocol SelctActionType:AnyObject {
    func selctValue(vaule:Int)
    func updateTextField(type:Int,value:String)
}
class ReportHeaderTableViewCell: UITableViewCell {
    weak var delegate:SelctActionType?
    var thisDeviceSelect = true
    var reportDay = 11
   
    @IBOutlet weak var lblSelctIsuue: UILabel!
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
        txtEmail.attributedPlaceholder = NSAttributedString(
            string: "Enter your Email Id",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
        txtMobileNo.attributedPlaceholder = NSAttributedString(
            string: "Enter your Mobile Number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
        txtField.attributedPlaceholder = NSAttributedString(
            string: txtField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
        txtEmail.delegate = self
        txtEmail.keyboardType = .emailAddress
        
        txtMobileNo.delegate = self
        txtMobileNo.keyboardType = .phonePad

        txtField.delegate = self
        txtField.keyboardType = .default
        
        imgRow.image = RecBundleManager.image(named: "expandR")
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
            self.delegate?.selctValue(vaule: 15)

        }else if self.reportDay == 12 {
            imgWeek.image = RecBundleManager.image(named: "radio_button_checked")
            self.delegate?.selctValue(vaule: 16)

        }
        else if self.reportDay == 13 {
            imgMonth.image = RecBundleManager.image(named: "radio_button_checked")
            self.delegate?.selctValue(vaule: 17)
        }

    }
    func selctImage() {
        if thisDeviceSelect {
            imgR1.image = RecBundleManager.image(named: "radio_button_checked")
            imgR2.image = RecBundleManager.image(named: "radio_button_unchecked")
            self.delegate?.selctValue(vaule: 13)

        }else {
            imgR2.image = RecBundleManager.image(named: "radio_button_checked")
            imgR1.image = RecBundleManager.image(named: "radio_button_unchecked")
            self.delegate?.selctValue(vaule: 14)

        }
        
    }
    @IBAction func selctIssueAction(_ sender: Any) {
        self.delegate?.selctValue(vaule: 11)
    }
    
    @IBAction func subMitAction(_ sender: Any) {
        self.delegate?.selctValue(vaule: 12)
    }
}
extension ReportHeaderTableViewCell : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        
        if newString.length == 1 && newString == " " {
            return false
        }
        if textField == txtEmail  {
            if newString.length >= 20 {
                return false
            }
            self.delegate?.updateTextField(type: 1, value: newString as String)
            
        } else if textField == txtMobileNo {
            if newString.length >= 20 {
                return false
            }
            self.delegate?.updateTextField(type: 2, value: newString as String)

        }else  if textField == txtField  {
            if newString.length > 600 {
                return false
            }
            self.lblHint.text = "\(newString.length)/600"
            self.delegate?.updateTextField(type: 3, value: newString as String)

        }
        return true
    }
}
