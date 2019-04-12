//
//  ProfileView.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/12/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    public var user: User? {
        didSet { updateView() }
    }

    private let avatar: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "user"))
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 112

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        lbl.textAlignment = .center
        lbl.text = "John Smith"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let emailLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .light)
        lbl.textAlignment = .center
        lbl.text = "john.smith@example.com"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let tokenField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 18)
        field.placeholder = " authtoken"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private let fetchBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Fetch User", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
        addSubview(avatar)
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            avatar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            avatar.widthAnchor.constraint(equalToConstant: 224),
            avatar.heightAnchor.constraint(equalToConstant: 224)
        ])

        addSubview(nameLbl)
        NSLayoutConstraint.activate([
            nameLbl.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 5),
            nameLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameLbl.heightAnchor.constraint(equalToConstant: 48)

        ])
        addSubview(emailLbl)
        NSLayoutConstraint.activate([
            emailLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor),
            emailLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            emailLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            emailLbl.heightAnchor.constraint(equalToConstant: 42)
        ])

        addSubview(tokenField)
        NSLayoutConstraint.activate([
            tokenField.topAnchor.constraint(equalTo: emailLbl.bottomAnchor, constant: 5),
            tokenField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            tokenField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            tokenField.heightAnchor.constraint(equalToConstant: 42)
        ])

        fetchBtn.addTarget(self, action: #selector(fetchCurrentUser), for: .touchUpInside)
        addSubview(fetchBtn)
        NSLayoutConstraint.activate([
            fetchBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            fetchBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            fetchBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            fetchBtn.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    func updateView() {
        guard let usr = user else { return }
        nameLbl.text = usr.name
        emailLbl.text = usr.email
        if let token = usr.token {
            tokenField.text = token
        }
        usr.avatarAsset?.imageMedium { [weak self] image in
            guard let that = self else { print("Oups! Could not find reference to self"); return }
            that.avatar.image = image
        }
    }

    @objc func fetchCurrentUser() {
        print("Fetching endpoint...")
        guard let token = SecretStore.shared.get(forKey: "token") else { return }
        if let user = UserStore.shared.user {
            print("Cached: \(user)")
            self.user = user
            return
        }

        let service = UserService(session: URLSession.shared, path: "/users", token: token)
        service.show(slug: "current") { [weak self] response in
            guard let that = self else { print("Oups! Could not find reference to self"); return }
            guard let resp = response else { return }
            if resp.status == .success {
                print("[Succesful]")
                UserStore.shared.user = resp.object
                that.user = resp.object
            } else {
                print(resp.status)
            }
        }
    }
}
