//
//  DetailsCollectionViewCell.swift
//  UnomokSample
//
//  Created by Bindu R S on 22/11/23.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!

    func setupCell(index: Int) {
        label.text = "item \(index+1)"
    }
}
