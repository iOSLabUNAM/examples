//
//  ViewController.swift
//  AugmentedReality
//
//  Created by Luis Ezcurdia on 6/8/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.vertical, .horizontal]
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func positionFrom(transform: simd_float4x4) -> SCNVector3 {
        let pos = transform.columns.3
        return SCNVector3(x: pos.x, y: pos.y, z: pos.z)
    }

    @IBAction func onScreenTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: sceneView)
        guard let hitResult = sceneView.hitTest(location, types: .existingPlaneUsingExtent).first,
        let hitAnchor = hitResult.anchor
        else { return }
        if let ray = createRay(anchor: hitAnchor) {
            sceneView.scene.rootNode.addChildNode(ray)
        }
    }

    func createRay(anchor: ARAnchor) -> SCNNode? {
        guard let currentFrame = sceneView.session.currentFrame else { return nil }
        let node = SCNNode()
        node.name = "ray[\(UUID().uuidString)]"
        node.position = positionFrom(transform: currentFrame.camera.transform)
        node.eulerAngles.x = currentFrame.camera.eulerAngles.x
        node.eulerAngles.y = currentFrame.camera.eulerAngles.y
        node.eulerAngles.z = currentFrame.camera.eulerAngles.z

        node.geometry = SCNCylinder(radius: 0.01, height: CGFloat(anchor.transform.determinant))
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red

        return node
    }

    func createPlane(anchor: ARPlaneAnchor) -> SCNNode {
        let node = SCNNode()
        node.name = "plane"
        node.geometry = SCNPlane(width: CGFloat(anchor.extent.x),
                                 height: CGFloat(anchor.extent.z))
        node.eulerAngles.x = -.pi / 2
        node.opacity = 0.25

        return node
    }

    func createEarth(anchor: ARPlaneAnchor) -> SCNNode {
        let node = SCNScene(named: "art.scnassets/solar.scn")!.rootNode.childNodes.first!

        let rotate = SCNAction.rotate(by: CGFloat(360 * (Double.pi/180)),
                                      around: SCNVector3(0, 1, 0),
                                      duration: 8)
        let animation = SCNAction.repeatForever(rotate)
        node.runAction(animation)
        return node
    }

    func createTardis(anchor: ARPlaneAnchor) -> SCNNode? {
        guard let node = SCNScene(named: "art.scnassets/tardis.dae")!.rootNode.childNode(withName: "tardis", recursively: false) else { return nil }

        let rotate = SCNAction.rotate(by: CGFloat(360 * (Double.pi/180)),
                                      around: SCNVector3(0, 1, 0),
                                      duration: 2)
        let animation = SCNAction.repeatForever(rotate)
        node.runAction(animation)
        return node
    }

    // MARK: - ARSCNViewDelegate

/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        let plane = createPlane(anchor: planeAnchor)
        node.addChildNode(plane)

        if let tardis = createTardis(anchor: planeAnchor) {
            node.addChildNode(tardis)
        }

//        let earth = createEarth(anchor: planeAnchor)
//        node.addChildNode(earth)
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }

        for node in node.childNodes {
            switch node.name {
            case "earth":
                node.position = SCNVector3(planeAnchor.center.x, 1, planeAnchor.center.z)
            case "plane":
                node.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            default:
                print("noname")
            }
            if let plane = node.geometry as? SCNPlane {
                plane.width = CGFloat(planeAnchor.extent.x)
                plane.height = CGFloat(planeAnchor.extent.z)
            }
        }
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user

    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay

    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required

    }
}
