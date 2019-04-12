//
//  ProfileView.swift
//  Alerts
//
//  Created by Luis Ezcurdia on 3/23/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    private let avatar: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "user_male"))
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFit

        iv.layer.borderWidth = 1
        iv.layer.masksToBounds = false
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.cornerRadius = 75
        iv.clipsToBounds = true

        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "User"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    let bioText: UITextView = {
        let tv = UITextView()
        tv.text = "lorem ipsum dolor quet sit amet consectetur adipsum, lorem ipsum dolor quet sit amet consectetur adipsum, lorem ipsum dolor quet sit amet consectetur adipsum, lorem ipsum dolor quet sit amet consectetur adipsum, lorem ipsum dolor quet sit amet consectetur adipsum, lorem ipsum dolor quet sit amet consectetur adipsum, lorem ipsum dolor quet sit amet consectetur adipsum, lorem ipsum dolor quet sit amet consectetur adipsum, lorem ipsum dolor quet sit amet consectetur adipsum, lorem ipsum dolor quet sit amet consectetur adipsum, lorem ipsum dolor quet sit amet consectetur adipsum, lorem ipsum dolor quet sit amet consectetur adipsum, lorem ipsum dolor quet sit amet consectetur adipsum."
        tv.font = UIFont.systemFont(ofSize: 16, weight: .light)
        tv.backgroundColor = .clear
        tv.textColor = .white
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.isSelectable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    func setupLayout() {
        backgroundColor = UIColor(named: "yankees blue") ?? UIColor.black
        self.addSubview(avatar)
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            avatar.heightAnchor.constraint(equalToConstant: 150),
            avatar.widthAnchor.constraint(equalToConstant: 150),
            avatar.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        self.addSubview(nameLbl)
        NSLayoutConstraint.activate([
            nameLbl.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 5),
            nameLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            nameLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            nameLbl.heightAnchor.constraint(equalToConstant: 45)
        ])

        self.addSubview(bioText)
        NSLayoutConstraint.activate([
            bioText.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 5),
            bioText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            bioText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            bioText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
    }
}
