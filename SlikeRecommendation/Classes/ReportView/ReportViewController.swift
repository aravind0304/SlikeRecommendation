//
//  ReportViewController.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 07/02/23.
//

import UIKit

class ReportViewController: UIViewController {
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var loaderView: UIView!
    var reportString = ""
    var issueFacedDay = "Today"
    var issueFacedOn = "This Device/Mobile"
    var explanation = ""
    var userEmail = ""
    var userMob = ""

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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension ReportViewController : SelctActionType,RoprtListSelctActionType {
    func updateTextField(type: Int, value: String) {
        if type == 1 {
            self.userEmail = value
        }else if type == 2 {
            self.userEmail = value
        } else if type == 3 {
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
            if !userMob.isEmpty &&  userMob.count < 9 {
                self.showAlert(isSucess: false, message: "Please enter valid mobile number")
                return
            }
            if !self.isValidEmail(self.userEmail) {
                self.showAlert(isSucess: false, message: "please enter valid email id")
                return
            }
            
            let dict = ["issueValue"    : reportString,
                        "deviceModel"   : UIDevice.modelName,
                        "OSVersion"     : self.getOSInfo(),
                        "issueFacedOn" : self.issueFacedOn,
                        "issueFacedDay" : self.issueFacedDay,
                        "deviceType"    : "iOS",
                        "explanation"   : self.explanation,
                        "userEmail"     : userEmail,
                        "userMobile" : userMob]
            self.submitData(parameterDictionary: dict)
        }else if vaule ==  13 {
            self.issueFacedOn = "This Device/Mobile"
        }
        else if vaule ==  14 {
            self.issueFacedOn = "Diffrent Device"
        }
        else if vaule ==  15 {
            self.issueFacedDay = "Today"
        }
        else if vaule ==  16 {
            self.issueFacedDay = "A week ago"
        }
        else if vaule ==  17 {
            self.issueFacedDay = "A month ago"
        }
    }
    func submitData(parameterDictionary:[String:Any]) {
        self.showHideLoader(show: true)

        let Url = String(format: "https://vsnl.slike.in/devcmsapi/feedback")
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
                self.showHideLoader(show: false)

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
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func showHideLoader(show:Bool) {
        DispatchQueue.main.async {
            if !show {
                self.loaderView.isHidden = false
                self.activityLoader.startAnimating()
            }else {
                self.loaderView.isHidden = true
                self.activityLoader.stopAnimating()
            }
        }
    }
}
