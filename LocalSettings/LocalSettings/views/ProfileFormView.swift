//
//  ProfileFormView.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/13/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ProfileFormView: UIView {
    public var user: User? {
        didSet { updateView() }
    }

    private let nameField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 18)
        field.placeholder = " name"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private let emailField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 18)
        field.placeholder = " email"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    func setupLayout() {
        addSubview(nameField)
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: topAnchor),
            nameField.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameField.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameField.heightAnchor.constraint(equalToConstant: 48)
            ])

        addSubview(emailField)
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor),
            emailField.leadingAnchor.constraint(equalTo: leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: trailingAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 48)
            ])
    }

    func updateView() {
        guard let usr = user else { return }
        nameField.text = usr.name
        nameField.text = usr.email
    }
}
