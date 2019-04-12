//
//  ViewController.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/12/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewUser(_:)))
        navigationItem.rightBarButtonItem = addButton
        view.addSubview(profileView)
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func addNewUser(_ sender: Any) {
        self.performSegue(withIdentifier: "createUserSegue", sender: self)
    }
}
