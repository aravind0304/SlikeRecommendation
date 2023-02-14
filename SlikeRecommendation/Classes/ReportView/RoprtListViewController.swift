//
//  RoprtListViewController.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 14/02/23.
//

import UIKit

class RoprtListViewController: UIViewController {
    @IBOutlet weak var btnClose: UIButton!

    private let kReoprtOptionTableViewCell = "ReoprtOptionTableViewCell"
    @IBOutlet weak var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.tbView.delegate = self
        self.tbView.dataSource = self
        self.btnClose.setImage(RecBundleManager.image(named: "sl_close"), for: .normal)
        self.btnClose.setImage(RecBundleManager.image(named: "sl_close"), for: .selected)
        // Do any additional setup after loading the view.
    }
    func registerNib() {
        
        let nibView = UINib(nibName: kReoprtOptionTableViewCell, bundle: RecBundleManager.resourcesBundle())
        print(nibView)
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
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell : ReoprtOptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: kReoprtOptionTableViewCell, for: indexPath) as? ReoprtOptionTableViewCell else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
