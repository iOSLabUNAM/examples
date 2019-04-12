//
//  GameViewController.swift
//  SceneKitGyro
//
//  Created by Luis Ezcurdia on 5/1/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import CoreMotion

class GameViewController: UIViewController {
    let frequency = 1.0 / 60.0  // 60 Hz == 60fps
    var timer: Timer!
    let scene = SCNScene(named: "art.scnassets/suzanne.scn")!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupLights()

        let scnView = self.view as! SCNView
        scnView.scene = scene

        scnView.allowsCameraControl = false
        scnView.showsStatistics = true
        scnView.backgroundColor = UIColor.black
        paralax()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupCamera() {
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)

        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
    }

    func setupLights() {
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)

        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
    }

    func paralax() {
        // retrieve the 3D object node
        let object = scene.rootNode.childNode(withName: "Suzanne", recursively: true)!
        // animate the 3d object
        fetchAccelerometerData { data in
            object.runAction(SCNAction.rotateBy(
                x: -1.0 * CGFloat(data.rotationRate.x/100),
                y: -1.0 * CGFloat(data.rotationRate.y/100),
                z: -1.0 * CGFloat(data.rotationRate.z/100),
                duration: self.frequency))
        }
    }

    func fetchAccelerometerData(updateHandler: @escaping (CMGyroData) -> Void) {
        let motion = CMMotionManager()
        guard motion.isGyroAvailable else {
            print("No Gyroscope available 😢")
            return
        }
        motion.startGyroUpdates()
        self.timer = Timer(fire: Date(), interval: frequency,
                           repeats: true, block: { (_) in
                            if let data = motion.gyroData {
                                updateHandler(data)
                            }
        })

        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
    }

}
