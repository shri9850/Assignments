//
//  ProductTableViewCell.swift
//  Assignments
//
//  Created by Shri's Mac Mini on 16/04/20.
//  Copyright © 2020 Redbytes. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
     let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
     let productDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
     let productImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 30
        iv.backgroundColor = #colorLiteral(red: 1, green: 0.3864146769, blue: 0.4975627065, alpha: 1)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productImage)
        addSubview(productNameLabel)
        addSubview(productDescriptionLabel)
        let marginGuide = self.contentView.layoutMarginsGuide
        // configure titleLabel
        self.contentView.addSubview(self.productNameLabel)
        self.productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.productNameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        self.productNameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        self.productNameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        self.productNameLabel.numberOfLines = 0
        self.productNameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        
        // Configure imageView
        self.contentView.addSubview(self.productImage)
        self.productImage.translatesAutoresizingMaskIntoConstraints = false
        self.productImage.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        self.productImage.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        self.productImage.topAnchor.constraint(equalTo: self.productNameLabel.bottomAnchor).isActive = true
        self.productImage.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        self.productImage.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        // configure Description Label
        self.contentView.addSubview(self.productDescriptionLabel)
        self.productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.productDescriptionLabel.leadingAnchor.constraint(equalTo: self.productImage.leadingAnchor, constant: 70).isActive = true
        self.productDescriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        self.productDescriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        self.productDescriptionLabel.topAnchor.constraint(equalTo: self.productNameLabel.bottomAnchor).isActive = true
        self.productDescriptionLabel.numberOfLines = 0
        self.productDescriptionLabel.font = UIFont(name: "Avenir-Book", size: 12)
        self.productDescriptionLabel.textColor = UIColor.darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
