
import Foundation
import Alamofire
public protocol APIProtocol {
    var baseAPIUrl: String { get }
    var headerData: HTTPHeaders { get }
   
}

extension APIProtocol {
    var headerData: HTTPHeaders {
        [
            "Authorization": "",
            "Accept": "application/json",
            "platform": "2",
            "version": "1"
        ]
    }
}
