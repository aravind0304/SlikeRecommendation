//
//  RoprtListViewController.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 14/02/23.
//

import UIKit
protocol RoprtListSelctActionType:AnyObject {
    func selctValue(vaule:String)
}
class RoprtListViewController: UIViewController {
    weak var delegate:RoprtListSelctActionType?
    @IBOutlet weak var btnClose: UIButton!
    var optionsArray = ["Video is blurry/pixelated",
                    "Unable to use player controls",
                    "Audio not in Sync",
                    "No audio or sounds unclear",
                    "Video frequently buffering or lagging",
                    "Video is stuck while audio keeps playing",
                    "Video crashed & redirected to previous page",
                    "Video did not even start",
                    "Video did not start after the ad",
                    "Seeing an error message",
                    "I am seeing a black screen","Others"]
    private let kReoprtOptionTableViewCell = "ReoprtOptionTableViewCell"
    @IBOutlet weak var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.tbView.delegate = self
        self.tbView.dataSource = self
        self.btnClose.setImage(RecBundleManager.image(named: "sl_close"), for: .normal)
        self.btnClose.setImage(RecBundleManager.image(named: "sl_close"), for: .selected)
        self.tbView.clipsToBounds = true
        self.tbView.layer.cornerRadius = 10
        self.tbView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        
        // Do any additional setup after loading the view.
    }
    func registerNib() {
        
        let nibView = UINib(nibName: "ReoprtOptionTableViewCell", bundle: RecBundleManager.resourcesBundle())
        self.tbView.register(nibView, forCellReuseIdentifier: kReoprtOptionTableViewCell)
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
extension RoprtListViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
        hv.backgroundColor = UIColor.clear
        return hv
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let hv = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
        hv.backgroundColor = UIColor.clear
        return hv
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell : ReoprtOptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: kReoprtOptionTableViewCell, for: indexPath) as? ReoprtOptionTableViewCell else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        cell.line.isHidden = false
        if indexPath.row == self.optionsArray.count {
            cell.line.isHidden = true
        }
        cell.lblHint.text = self.optionsArray[indexPath.row]
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selctValue(vaule: self.optionsArray[indexPath.row])
        self.dismiss(animated: true)
    }
}
