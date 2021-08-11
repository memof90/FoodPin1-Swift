//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Memo Figueredo on 28/7/21.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
//    MARK: IBOultlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView! {
        didSet { //didSet: observador de propiedades
            thumbnailImageView.layer.cornerRadius = 20.0
            thumbnailImageView.clipsToBounds = true
        }
    }
    
    
//MARK: CHANGE COLOR CEHCK
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.tintColor = .systemYellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
