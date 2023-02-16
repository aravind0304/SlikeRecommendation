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
    @IBOutlet weak var txtViewField: UITextView!

    @IBOutlet weak var lblHint: UILabel!
    @IBOutlet weak var selctAnIssue: UILabel!
    
    @IBOutlet weak var lblBrife: UILabel!

    @IBOutlet weak var imgRow: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtViewField.delegate = self
        imgRow.image = RecBundleManager.image(named: "expandR")
        lblBrife.text = "Briefly explain your issue (optional)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func subMitAction(_ sender: Any) {
        self.delegate?.selctValue(vaule: 12)
    }
    
    @IBAction func selctIssueAction(_ sender: Any) {
        self.delegate?.selctValue(vaule: 11)
    }
    
    
}
extension ReportHeaderTableViewCell : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.updateTextField(type: 3, value: textView.text)
        self.lblHint.text = "\(textView.text.count)/600"

        }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let count  = textView.text.count + (text.count - range.length)
        return count <= 600
    }
}
