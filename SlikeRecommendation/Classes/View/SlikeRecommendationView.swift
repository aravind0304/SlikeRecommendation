//
//  SlikeRecommendationView.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 17/01/23.
//

import UIKit

public class SlikeRecommendationView: UIView {
    var view: UIView!
    func xibSetup() {
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        bringSubviewToFront(view)
        self.setUi()
    }
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: "SlikeRecommendationView", bundle: RecBundleManager.resourcesBundle())
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    func setUi() {
    }
    func loadRecommendationUI(data:[SlikeRecommendationModel]) {
        print(data)
    }
}
