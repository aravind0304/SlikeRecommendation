
//  Created by Aravind Kumar on 18/01/23.
//

import UIKit
import AlamofireImage
//#define SlikePlayerImagePause(file,imageBundle)  [UIImage imageNamed:file inBundle:imageBundle compatibleWithTraitCollection:nil]

class RecommendationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblDution: UILabel!
    
    @IBOutlet weak var viewDuration: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.posterImageView.clipsToBounds = true
        self.layer.cornerRadius = 3.0
        self.clipsToBounds = true
        viewDuration.clipsToBounds = true
        viewDuration.layer.cornerRadius = 3
        viewDuration.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        self.img.image = RecBundleManager.image(named: "play")
        nextView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        nextView.clipsToBounds = true
        nextView.isHidden = true
    }
    func setloadData(data:SlikeRecommendationModel) {
        self.posterImageView.backgroundColor = UIColor.black
        self.posterImageView.image = nil
        if var img = data.thumb {
            if !img.hasPrefix("http") {
                img = "https:" + img
            }
            if let url = URL(string: img) {
                print(url);
                self.posterImageView.af.setImage(withURL: url)
            }
        }else  if var img = data.image {
            if !img.hasPrefix("http") {
                img = "https:" + img
            }
            if let url = URL(string: img) {
                print(url);
                self.posterImageView.af.setImage(withURL: url)
            }
        }
        lblDution.text = data.duration ?? "00:00"
        lblTitle.text = data.title
    }
    
}
