//
//  APIClient.swift


import Foundation
import Alamofire

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

enum Result<T, U> where U: Error,T:Decodable {
    case success(T)
    case failure(U)
}

protocol APIClient:Decodable {
    func getParameters(valueType:String) -> [String:Any]
    func getBaseUrlPath() -> String
    func getType() -> Alamofire.HTTPMethod
    func fetchDataModel<T>(completion:@escaping (Result<T, APIError>) -> Void)
    
}
extension APIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
   
    func getAPIType() -> Bool {
        return false
    }
    func getDataObject<T: Decodable>(url:String,decodingType: T.Type, parametrs:[String:Any],action:HTTPMethod, completion: @escaping  JSONTaskCompletionHandler) {
        var header = Environment.current.headerData
        AF.request(url,
                   method: action,
                   parameters: parametrs,
                   encoding: URLEncoding(destination: .methodDependent),
                   headers: header)
          .responseString{response in
            if let apiData = response.response {
             
                if apiData.statusCode==200  {
                if let data = response.data {
                    if  let jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    print(jsonString)
                    }
                do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            }
              else {
                  print(response)
                completion(nil, .responseUnsuccessful)
              }
            }
            else {
                completion(nil, .responseUnsuccessful)
            }
          }
      }
    
    func fetchDataModel<T: Decodable>(completion:@escaping (Result<T, APIError>) -> Void){
        
        getDataObject(url:self.getBaseUrlPath(),decodingType:T.self, parametrs: self.getParameters(valueType: "new"), action: self.getType() ) { (json , error) in
            
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                
                if let value = json as? T {
                    completion(.success(value))
                }
                else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
    }
}

