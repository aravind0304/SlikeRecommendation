//
//  ViewController.swift
//  SlikeRecommendation
//
//  Created by Aravind.kumar on 01/17/2023.
//  Copyright (c) 2023 Aravind.kumar. All rights reserved.
//

import UIKit
import SlikeRecommendation

class ViewController: UIViewController {
    
        var slikeRecommendation : SlikeRecommendation?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.slikeRecommendation = SlikeRecommendation(sid: "1x5e4he99z", msid: "93287120")
        //self.slikeRecommendation?.delegate = self
//        self.slikeRecommendation?.getSlikeRecommendation(completion: { status,model  in
//            print(model)
//        })
        self.loadViewCall()
    }
    func loadViewCall() {
        let rect = CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: self.view.frame.size.width/3)
        self.slikeRecommendation?.getSlikeRecommendationView(rect:rect, completion: { status, viewS in
            if let vv = viewS {
                self.view.addSubview(vv)
                print(status,vv)
            }
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

