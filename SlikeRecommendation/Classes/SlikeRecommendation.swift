//
//  SlikeRecommendation.swift
//  Alamofire
//
//  Created by Aravind Kumar on 17/01/23.
//

import Foundation
import UIKit

public protocol SlikeRecommendationResponce:AnyObject {
    func sucessDataReCeived(model:SlikeRecommendationModel?)
}

@objc final public class SlikeRecommendation: NSObject {
   
    weak var delegate:SlikeRecommendationResponce?

    var viewModel:SlikeRecommendationViewModel?
    var sid:String?
    var msid:String?
    
     public  init(sid:String,msid:String) {
        super.init()
        self.sid = sid
        self.msid = msid
    }
    
    public func getSlikeRecommendation(completion: @escaping (_ status:Bool,_ model:[SlikeRecommendationModel]?)->Void) {
        print("getSlikeRecommendation")
        if let msid = self.msid, let sid = self.sid {
            self.viewModel = SlikeRecommendationViewModel(sid: sid, msid: msid)
            self.viewModel?.bindDataViewContollers = {
                print(self.viewModel?.slikeRecommendationModel)
               // self.delegate?.sucessDataReCeived(model: self.viewModel?.slikeRecommendationModel)
                completion(true,self.viewModel?.slikeRecommendationModel)
            }
        }
        
    }
    
}
