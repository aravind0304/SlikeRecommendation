
//  Created by Aravind Kumar on 18/01/23.
//

import UIKit
import AlamofireImage

class RecommendationCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var posterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.posterImageView.clipsToBounds = true
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    func setloadData(data:SlikeRecommendationModel) {
        if let img = data.thumb, let url = URL(string: img) {
            //let placeholderImage = UIImage(named: "placeholder")
          
            self.posterImageView.af.setImage(withURL: url)
            
        }
    }
}
