//
//  DetailsTableViewCell.swift
//  UnomokSample
//
//  Created by Bindu R S on 22/11/23.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!

    func setupCell(index: Int) {
        label.text = "item \(index+1)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
