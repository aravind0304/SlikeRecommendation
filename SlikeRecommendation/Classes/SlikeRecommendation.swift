//
//  SlikeRecommendation.swift
//  Alamofire
//
//  Created by Aravind Kumar on 17/01/23.
//

import Foundation
import UIKit
@objc public class SlikeModel: NSObject {
    @objc public var slikeID:String!
    @objc public var msid:String!
    @objc public var rmn:String!
    @objc public var rm:String!
    @objc public var rtype:String!
    @objc public var ralgo:String!
    @objc public var rsrc:Bool = false
    @objc public var recency:NSNumber?
    @objc public var thumb:String!

}
@objc public protocol SlikeRecommendationData:AnyObject {
    func recommendationClickInformation(slikeMDO:SlikeModel)
}


@objcMembers
@objc final public class SlikeRecommendationManager: NSObject, SlikeRecommendationData {
    var fromEndScreen = false;
    public func recommendationClickInformation(slikeMDO: SlikeModel) {
        self.delegate?.recommendationClickInformation(slikeMDO: slikeMDO)
    }
    //Aston Band
    public weak var delegate:SlikeRecommendationData?
    public lazy var slikeRecommendationView: SlikeRecommendationView = {
        let view = SlikeRecommendationView.init(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    var viewModel:SlikeRecommendationViewModel?
    var sid:String?
    var msid:String?
    
    @objc public init(sid:String,msid:String) {
        super.init()
        self.sid = sid
        self.msid = msid
    }
    public func getSlikeRecommendation(completion: @escaping (_ status:Bool,_ model:[SlikeRecommendationModel]?)->Void) {
        if let msid = self.msid, let sid = self.sid {
            self.viewModel = SlikeRecommendationViewModel(sid: sid, msid: msid)
            self.viewModel?.bindDataViewContollers = {
                completion(true,self.viewModel?.slikeRecommendationModel)
            }
        }
    }
    
    @objc public func getSlikeRecommendationView(rect:CGRect,fromEndScreen:Bool, completion: @escaping (_ status:Bool,_ view:UIView?)->Void) {
        self.fromEndScreen = fromEndScreen;
        if let msid = self.msid, let sid = self.sid {
            //Need to work
            if self.viewModel != nil ,let data = self.viewModel?.slikeRecommendationModel {
                self.slikeRecommendationView.isFromEndScreen = fromEndScreen
                self.slikeRecommendationView.loadRecommendationUI(data: data)
                if data.count > 0 {
                    completion(true,self.slikeRecommendationView)
                }else {
                    completion(false,nil)
                }
            }else {
            self.viewModel = SlikeRecommendationViewModel(sid: sid, msid: msid)
                self.viewModel?.bindDataViewContollers = {
                    self.slikeRecommendationView.frame = rect
                    self.slikeRecommendationView.delegate = self
                    if let data = self.viewModel?.slikeRecommendationModel {
                        self.slikeRecommendationView.isFromEndScreen = fromEndScreen
                        self.slikeRecommendationView.loadRecommendationUI(data: data)
                        if data.count > 0 {
                            completion(true,self.slikeRecommendationView)
                        }else {
                            completion(false,nil)
                        }
                    }else {
                        completion(false,nil)
                    }
                }
            }
        }
    }
    @objc public func autoClickAction() {
        self.slikeRecommendationView.autoPlayStart()
    }
    public func showReportPage(with viewController:UIViewController) {
       let reportViewController = ReportViewController(nibName: "ReportViewController", bundle: RecBundleManager.resourcesBundle())
       reportViewController.modalPresentationStyle = .fullScreen
       viewController.present(reportViewController, animated: true)

   }
    
}
