//
//  SlikeRecommendationView.swift
//  SlikeRecommendation
//
//  Created by Aravind Kumar on 17/01/23.
//

import UIKit

public class SlikeRecommendationView: UIView {
     weak var delegate:SlikeRecommendationData?
    var isFromEndScreen = false
    var kRecommendationCollectionViewCell  = "RecommendationCollectionViewCell"

    var view: UIView!
    var recommendationArray:[SlikeRecommendationModel]!
    @IBOutlet weak var ctView: UICollectionView!
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
        self.registerNib()
    }
    func loadRecommendationUI(data:[SlikeRecommendationModel]) {
        self.recommendationArray = data
        self.ctView.reloadData()
    }
    func registerNib() {
        let nib = UINib(nibName: kRecommendationCollectionViewCell, bundle: RecBundleManager.resourcesBundle())
        self.ctView.register(nib, forCellWithReuseIdentifier: kRecommendationCollectionViewCell)
        ctView.delegate = self
        ctView.dataSource = self
        ctView.backgroundColor = UIColor.clear
    }
   @objc public func autoPlayStart() {
        if self.recommendationArray.count > 0 {
            let mdo = self.recommendationArray[0]
            if let msid = mdo.msid, let slikeid  = mdo.k {
                let slikeModel = SlikeModel()
                slikeModel.msid = "\(msid)";
                slikeModel.slikeID = slikeid;
                slikeModel.rmn = mdo.rmn ?? "";
                slikeModel.rm = mdo.rm ?? "";
                slikeModel.rtype = mdo.rtype ?? "";
                slikeModel.ralgo = mdo.ralgo ?? "";

                self.delegate?.recommendationClickInformation(slikeMDO: slikeModel)
            }
        }
    }
}

extension SlikeRecommendationView:UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.recommendationArray.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendationCollectionViewCell, for: indexPath) as! RecommendationCollectionViewCell
        cell.setloadData(data: self.recommendationArray[indexPath.row])
        cell.nextView.isHidden = true
        if isFromEndScreen && indexPath.row == 0 {
            cell.nextView.isHidden = false
        }
        return cell;
    }
}
extension SlikeRecommendationView:UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mdo = self.recommendationArray[indexPath.row]
        if let msid = mdo.msid, let slikeid  = mdo.k {
            let slikeModel = SlikeModel()
            slikeModel.msid = "\(msid)";
            slikeModel.slikeID = slikeid;
            slikeModel.rmn = mdo.rmn ?? "";
            slikeModel.rm = mdo.rm ?? "";
            slikeModel.rtype = mdo.rtype ?? "";
            slikeModel.ralgo = mdo.ralgo ?? "";
            
            self.delegate?.recommendationClickInformation(slikeMDO: slikeModel)
        }
    }
}

extension SlikeRecommendationView:UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cal =  self.frame.size.height-20
        return CGSize(width: cal+cal*0.75,height: cal)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
