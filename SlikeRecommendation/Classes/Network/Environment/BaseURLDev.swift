//
//  BaseURLDev.swift
//  NetworkModule
//
//  Created by ARAVIND KUMAR on 10/05/22.
//

import Foundation

#if NON_PROD
// Do not define BaseURLDev for Non-Production Environments
struct BaseURLDev: APIProtocol {
    
    var baseAPIUrl: String {
        "https://tvid.in/reco/"
    }
  
}
#endif
