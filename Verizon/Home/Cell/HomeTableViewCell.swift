//
//  HomeTableViewCell.swift
//  Verizon
//
//  Created by Jeganathan, Vivin on 7/13/19.
//  Copyright © 2019 Jeganathan, Vivin. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var homeCellViewModel: HomeCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        self.titleLabel.text = ""
        self.durationLabel.text = ""
        super.prepareForReuse()
    }
    
    func configureCell(homeCellViewModel: HomeCellViewModel) {
        
        self.homeCellViewModel = homeCellViewModel
        
        configureTextLabels()
        requestImage()
    }
    
    func configureTextLabels() {
        
        titleLabel?.text = homeCellViewModel?.getTitle() ?? ""
        durationLabel?.text = "Duration: " + (homeCellViewModel?.getDuration() ?? "0") + " mins"
    }
    
    func requestImage() {
        
        self.thumbnailImageView?.image = UIImage(named: "placeholder")
        homeCellViewModel?.getImage { [weak self] (image) in
            
            DispatchQueue.main.async {
                self?.thumbnailImageView?.image = image
            }
        }
    }

}
