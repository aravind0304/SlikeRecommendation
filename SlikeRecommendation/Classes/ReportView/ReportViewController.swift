//
//  ReportViewController.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 07/02/23.
//

import UIKit

class ReportViewController: UIViewController {
    var ss = ""
    var feedbackSubmitBaseUrl = ""
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var loaderView: UIView!
    var reportString = ""
    var explanation = ""
    @IBOutlet weak var btnClose: UIButton!
    private let kReportHeaderTableViewCell = "ReportHeaderTableViewCell"
    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.registerNib()
        self.tbView.delegate = self
        self.tbView.dataSource = self
        self.btnClose.setImage(RecBundleManager.image(named: "sl_close"), for: .normal)
        self.btnClose.setImage(RecBundleManager.image(named: "sl_close"), for: .selected)
        self.showHideLoader(show: false)
    }
    func registerNib() {
        
        let nibView = UINib(nibName: "ReportHeaderTableViewCell", bundle: RecBundleManager.resourcesBundle())
        print(nibView)
        self.tbView.register(nibView, forCellReuseIdentifier: kReportHeaderTableViewCell)
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
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
            return 900
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell : ReportHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: kReportHeaderTableViewCell, for: indexPath) as? ReportHeaderTableViewCell else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        cell.backgroundColor = UIColor.clear
        cell.delegate = self
        if self.reportString == "" {
            cell.lblSelctIsuue.text  = "Select an issue"
        }else {
            cell.lblSelctIsuue.text  = self.reportString
        }
        if self.reportString == "Others" {
            cell.lblBrife.text = "Briefly explain your issue (Required)"
        }else {
            cell.lblBrife.text = "Briefly explain your issue (optional)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension ReportViewController : SelctActionType,RoprtListSelctActionType {
    func updateTextField(type: Int, value: String) {
        if type == 3 {
            self.explanation = value
        }
    }
    
    func selctValue(vaule: String) {
        self.reportString = vaule
        self.tbView.reloadData()
    }
    
    func selctValue(vaule: Int) {
        if vaule == 11 {
            let roprtListViewController = RoprtListViewController(nibName: "RoprtListViewController", bundle: RecBundleManager.resourcesBundle())
            roprtListViewController.modalPresentationStyle = .overCurrentContext
            roprtListViewController.view.backgroundColor = UIColor.clear
            roprtListViewController.delegate = self
            self.present(roprtListViewController, animated: true)
        }
        else if vaule == 12 {
            //Submit
            if reportString == "Others" && self.explanation == "" {
                self.showAlert(isSucess: false, message: "Briefly explain your issue")
                return
            }
            let dict = ["issueValue"    : reportString,
                        "deviceModel"   : UIDevice.modelName,
                        "OSVersion"     : self.getOSInfo(),
                        "deviceType"    : "iOS",
                        "explanation"   : self.explanation,
                        "ss"            : self.ss
            ]
            print(dict)
            self.submitData(parameterDictionary: dict)
        }
        
    }
    func submitData(parameterDictionary:[String:Any]) {
        self.showHideLoader(show: true)
        
        let Url = String(format: self.feedbackSubmitBaseUrl)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        if let code = json["code"] as? Int, code == 200 {
                            //Show Sucess
                            if let msg = json["msg"] as? String {
                                self.showAlert(isSucess: true, message: msg)
                            }
                        }else {
                            //Show Failure
                            if let msg = json["msg"] as? String {
                                self.showAlert(isSucess: false , message: msg)
                            }
                        }
                    }
                } catch {
                    self.showAlert(isSucess: false , message: "Something went wrong!")
                    
                    print(error)
                }
            }
        }.resume()
    }
    
}
extension ReportViewController {
    func showAlert(isSucess:Bool,message:String) {
        self.showHideLoader(show: false)
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                if isSucess {
                    self.dismiss(animated: true)
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func getOSInfo()->String {
        let os = ProcessInfo.processInfo.operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }
   
    func showHideLoader(show:Bool) {
        DispatchQueue.main.async {
            if show {
                self.loaderView.isHidden = false
                self.activityLoader.startAnimating()
            }else {
                self.loaderView.isHidden = true
                self.activityLoader.stopAnimating()
            }
        }
    }
}
