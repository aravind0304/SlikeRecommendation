//
//  SlikeRecommendation.swift
//  Alamofire
//
//  Created by Aravind Kumar on 17/01/23.
//

import Foundation
import UIKit

@objcMembers
@objc final public class SlikeRecommendation: NSObject {
    //Aston Band
    
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
                print(self.viewModel?.slikeRecommendationModel)
                completion(true,self.viewModel?.slikeRecommendationModel)
            }
        }
    }
    
    @objc public func getSlikeRecommendationView(rect:CGRect,completion: @escaping (_ status:Bool,_ view:UIView?)->Void) {
        if let msid = self.msid, let sid = self.sid {
            self.viewModel = SlikeRecommendationViewModel(sid: sid, msid: msid)
            self.viewModel?.bindDataViewContollers = {
                self.slikeRecommendationView.frame = rect
            
                if let data = self.viewModel?.slikeRecommendationModel {
                    self.slikeRecommendationView.loadRecommendationUI(data: data)
                    completion(true,self.slikeRecommendationView)
                }else {
                    completion(false,nil)
                }
            }
        }
    }
    
}
