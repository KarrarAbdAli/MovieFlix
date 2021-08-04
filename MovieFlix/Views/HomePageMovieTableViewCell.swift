//
//  TableViewCell.swift
//  MovieFlix
//
//  Created by Karrar Abd Ali on 04/08/2021.
//  Copyright © 2021 Karrar Abd Ali. All rights reserved.
//

import UIKit

class HomePageMovieTableViewCell: UITableViewCell {
//MARK: - var
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var infoButtonAction: (() -> Void)?
    
    //MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = Constants.Colors.backgroundColor
        movieNameLabel.textColor = Constants.Colors.textColor
        releaseDateLabel.textColor = Constants.Colors.textColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //MARK: - Methods
    @IBAction func didClickMovieDetails(_ sender: Any) {
        infoButtonAction?()
    }
}
