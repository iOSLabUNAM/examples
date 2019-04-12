//
//  ViewController.swift
//  Animation
//
//  Created by Luis Ezcurdia on 5/18/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var loadingView: LoadingView = {
        let view = LoadingView(frame: self.view.frame)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.loadingView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.view.addGestureRecognizer(tap)
    }

    @objc func onTap() {
        loadingView.animatePulse()
    }

}
