//
//  BaseURLDev.swift
//  NetworkModule
//
//  Created by Shivam.Srivastava on 10/05/22.
//

import Foundation

#if NON_PROD
// Do not define BaseURLDev for Non-Production Environments
struct BaseURLDev: APIProtocol {
    
    var baseAPIUrl: String {
         "https://reco.slike.in/"
    }
  
}
#endif
