//
//  ViewController.swift
//  Alerts
//
//  Created by Luis Ezcurdia on 3/23/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private let profileView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Hello Alerts"
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    let simpleBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Simple alert", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false

        btn.addTarget(self, action: #selector(tapOkAlert), for: .touchUpInside)

        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.tangerine
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupView() {

        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 45)
        ])

        self.view.addSubview(simpleBtn)
        NSLayoutConstraint.activate([
            simpleBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            simpleBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            simpleBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            simpleBtn.heightAnchor.constraint(equalToConstant: 45)
            ])

        self.view.addSubview(profileView)
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            profileView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            profileView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            profileView.bottomAnchor.constraint(equalTo: simpleBtn.topAnchor, constant: -10)
            ])
    }

    // MARK : alerts code

    let lipsum = "Lorem ipsum dolor quet sit amet"

    func tapSimpleAlert(_ sender: Any) {
        print("Simple Alert")
        let alert = UIAlertController(title: "Simple Alert", message: lipsum, preferredStyle: .actionSheet)
        self.present(alert, animated: true, completion: nil)
    }

    @objc func tapOkAlert(_ sender: Any) {
        print("Ok Alert")
        let alert = UIAlertController(title: "Ok Alert", message: lipsum, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            debugPrint(action)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    func tapOkCancelAlert(_ sender: Any) {
        print("Ok Cancel Alert")
        let alert = UIAlertController(title: "Ok Cancel Alert", message: lipsum, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            debugPrint(action)
        }
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            debugPrint(action)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

}
