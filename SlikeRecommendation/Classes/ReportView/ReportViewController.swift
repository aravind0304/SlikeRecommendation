//
//  ReportViewController.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 07/02/23.
//

import UIKit

class ReportViewController: UIViewController {
    private let kReportHeaderTableViewCell = "ReportHeaderTableViewCell"

    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.registerNib()
      self.tbView.delegate = self
        self.tbView.dataSource = self
    }
    func registerNib() {
        
        let nibView = UINib(nibName: "ReportHeaderTableViewCell", bundle: RecBundleManager.resourcesBundle())
        print(nibView)
        self.tbView.register(nibView, forCellReuseIdentifier: kReportHeaderTableViewCell)
    }

}
extension ReportViewController:UITableViewDelegate,UITableViewDataSource {
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
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 400
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell : ReportHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: kReportHeaderTableViewCell, for: indexPath) as? ReportHeaderTableViewCell else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
