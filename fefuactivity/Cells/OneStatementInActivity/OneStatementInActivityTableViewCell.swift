//
//  OneStatementInActivityTableViewCell.swift
//  fefuactivity
//

//

import UIKit

class OneStatementInActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var how_time_ago: UILabel!
    @IBOutlet weak var type_of_activnosti: UILabel!
    @IBOutlet weak var image_of_activnosti: UIImageView!
    @IBOutlet weak var long_way_of_activnost: UILabel!
    @IBOutlet weak var long_time_of_activnosti: UILabel!
    @IBOutlet weak var header_time_of_activnost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        commonInit()
        // Configure the view for the selected state
    }
    private func commonInit(){
        self.viewWithTag(1)?.layer.cornerRadius = 12;
            
    }
}
