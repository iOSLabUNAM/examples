//
//  ViewController.swift
//  Profile
//
//  Created by Luis Ezcurdia on 3/2/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // tintColor, backgroundColor, textColor
    let colors = [UIColor(named: "tenne")!, UIColor(named: "cocoa-brown")!,
                  UIColor(named: "vivid-gamboge")!, UIColor(named: "crayola")!,
                  UIColor(named: "topaz")!]
    var randomizedColors : [UIColor]?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var funButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        resetButton.isEnabled = false
    }

    @IBAction func onTapView(_ sender: Any) {
        let alert = UIAlertController(title: "Theme colors", message: "Used colors for current configuration", preferredStyle: .actionSheet)
        alert.view.tintColor = colors[0]
        let currentPalette = randomizedColors ?? colors
        
        for color in currentPalette[0..<4] {
            let alertAction = UIAlertAction(title: color.hexString(false), style: .default , handler:{ (UIAlertAction)in
                print(color)
            })
            alert.addAction(alertAction)
        }
        alert.addAction(UIAlertAction(title: "Back", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func onTapReset(_ sender: Any) {
        setViewColors(background: colors[3], tint: colors[0])
        setActionButtonsColor(background: colors[1], tint: colors[4])
        resetButton.isEnabled = false
    }

    @IBAction func onTapFun(_ sender: Any) {
        randomizedColors = colors.shuffled()
        setViewColors(background: randomizedColors![0], tint: randomizedColors![1])
        setActionButtonsColor(background: randomizedColors![2], tint: randomizedColors![3])
        resetButton.isEnabled = true
    }

    func setActionButtonsColor(background: UIColor, tint: UIColor) {
        viewButton.backgroundColor = background
        viewButton.tintColor = tint
        resetButton.backgroundColor = background
        resetButton.tintColor = tint
        descTextView.backgroundColor = tint
        descTextView.textColor = background
    }

    func setViewColors(background: UIColor, tint: UIColor) {
        view.backgroundColor = background
        view.tintColor = tint
        titleLabel.textColor = tint
        funButton.backgroundColor = background
        funButton.tintColor = tint
    }
}
