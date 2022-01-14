//
//  CollectionViewCellStartTracking.swift
//  fefuactivity
//

//

import UIKit

class CollectionViewCellStartTracking: UICollectionViewCell {
    @IBOutlet weak var activity_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
    }
    
}
