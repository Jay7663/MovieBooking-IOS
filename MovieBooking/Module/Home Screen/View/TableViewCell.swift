//
//  TableViewCell.swift
//  MovieBooking
//
//  Created by Yagnik Bavishi on 12/04/22.
//

import UIKit
import SwiftyStarRatingView

class TableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var ratingBar: SwiftyStarRatingView!
    @IBOutlet weak var lblMovieOverView: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    // MARK: - AwakeFormNib
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingBar.isEnabled = false
        cardView.layer.cornerRadius = 20
        cardView.layer.masksToBounds = false
    }
    
} // End of class
