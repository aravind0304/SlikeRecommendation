//
//  SlikeRecommendationViewModel.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 17/01/23.
//

import Foundation
import Alamofire

class SlikeRecommendationViewModel {
    private var dataHandler : APIClient!
    var bindDataViewContollers : (()->Void)?
    private (set) var slikeRecommendationModel:[SlikeRecommendationModel]? {
        didSet {
            bindDataViewContollers?()
        }
    }
   
    init(sid:String,msid:String) {
    self.dataHandler = SlikeRecommenFeedData(sid: sid, msid: msid)
        self.dataHandler.fetchDataModel { [weak self](res:(Result<[SlikeRecommendationModel], APIError>)) in
            switch res {
            case .success(let result):
                guard let strongSelf = self else { return }
                strongSelf.slikeRecommendationModel = result
            case .failure(let error):
                print("the error \(error)")
                guard let strongSelf = self else { return }
                strongSelf.slikeRecommendationModel = nil

            }
        }
    }
    
}
class SlikeRecommenFeedData:APIClient {
    var sid = ""
    var msid = ""

    init(sid:String,msid:String) {
        self.sid = sid
        self.msid = msid

    }
    private var parametrs:[String:String] {
        get {
            return ["sid":self.sid,"msid":self.msid,"rand":"\(Date().millisecondsSince1970)"]
        }
    }
    func getType() -> Alamofire.HTTPMethod {
        .get
    }
    func getParameters() -> [String : String] {
        return parametrs
    }
    func getBaseUrlPath() -> String {
        return Environment.current.baseAPIUrl + "similar/result.json?" + "sid=\(self.sid)" + "&" + "msid=\(self.msid)" + "&" + "rand=\("\(Date().millisecondsSince1970)")"
        
    }
}
