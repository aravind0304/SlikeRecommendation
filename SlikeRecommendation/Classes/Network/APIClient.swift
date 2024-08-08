//
//  APIClient.swift


import Foundation
//import Alamofire

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case emptyData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .emptyData: return "emptydata"
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
    func getParameters() -> [String:String]
    func getBaseUrlPath() -> String
//    func getType() -> Alamofire.HTTPMethod
    func fetchDataModel<T>(completion:@escaping (Result<T, APIError>) -> Void)
    
}
extension APIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    func getAPIType() -> Bool {
        return false
    }
    func getDataObject<T: Decodable>(url:String,decodingType: T.Type, parametrs:[String:String], completion: @escaping  JSONTaskCompletionHandler) {
       
        print("AAAAA \(url)");
        if let url = URL(string: url) {
            let task = URLSession.shared.dataTask(with: url) { dataResponce, response, error in
                if error != nil {
                    completion(nil, .emptyData)
                    
                }
                if let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode)  {
                    if let data = dataResponce {
//                        if  let jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
//                            //print("AAAAA \(jsonString)")
//                        }
                        do {
                            let genericModel = try JSONDecoder().decode(decodingType, from: data)
                            completion(genericModel, nil)
                        } catch {
                            do {
                                _ = try JSONDecoder().decode(ErrorResponce.self, from: data)
                                completion(nil, .emptyData)
                            }catch {
                                completion(nil, .responseUnsuccessful)
                            }
                        }
                    }else {
                        completion(nil, .emptyData)
                        
                    }
                    return
                }else {
                    completion(nil, .responseUnsuccessful)
                    
                }
                
            }
            task.resume()
        }else {
            completion(nil, .responseUnsuccessful)
        }
    }
    
    func fetchDataModel<T: Decodable>(completion:@escaping (Result<T, APIError>) -> Void){
        getDataObject(url:self.getBaseUrlPath(),decodingType:T.self, parametrs: self.getParameters()) { (json , error) in
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

