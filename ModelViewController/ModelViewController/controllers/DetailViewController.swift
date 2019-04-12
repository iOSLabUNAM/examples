//
//  DetailViewController.swift
//  ModelViewController
//
//  Created by Luis Ezcurdia on 3/16/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var user: User? {
        didSet {
            configureView()
        }
    }

    func configureView() {
        guard let unwrappedUser = user,
              let label = detailDescriptionLabel else { return }
        label.text = unwrappedUser.fullName
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
