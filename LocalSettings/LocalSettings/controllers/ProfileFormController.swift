//
//  ProfileFormController.swift
//  LocalSettings
//
//  Created by Luis Ezcurdia on 4/12/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ProfileFormController: UIViewController {
    let profileView: ProfileFormView = {
        let view = ProfileFormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create User"
        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveUser(_:)))
        navigationItem.rightBarButtonItem = addButton
        view.addSubview(profileView)
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func saveUser(_ sender: Any) {
        print("Save user start...")
        print("Send request")
        print("Recieve response")
        print("Dismiss with object?")
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
