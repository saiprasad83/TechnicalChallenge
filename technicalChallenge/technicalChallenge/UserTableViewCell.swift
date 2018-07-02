//
//  UserTableViewCell.swift
//  technicalChallenge
//
//  Created by Sai prasad Soma on 7/2/18.
//  Copyright © 2018 Sai prasad Soma. All rights reserved.
//

import UIKit
protocol CellProtocol {
    func selectedCell(cell:UserTableViewCell)
}
class UserTableViewCell: UITableViewCell {
    var deleagte:CellProtocol?
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var labelFName: UILabel!
    @IBOutlet weak var labelSname: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func action(_ sender: UIButton) {
        deleagte?.selectedCell(cell: self)
    }
    
}
