//
//  panels.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

extension GameViewController
{
	func panel_thruster()
	{
		let panelNode = SCNNode()
		panelNode.name = "panel.thurster"
		panelNode.position = SCNVector3(x:0,y:floorNode[0].y,z:0)
		panelNode.addChildNode(knob("speed",position:SCNVector3(x: 0, y: 0, z: 0)))
		panelNode.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 1)); // rotate 90 degrees
		
		
		var testLabel = SCNLabel(text: "speed", scale: 0.05, align: alignment.left)
		testLabel.position = SCNVector3(x: 0.1, y: 0.65, z: 0)
		panelNode.addChildNode(testLabel)
		
		var testLabel2 = SCNLabel(text: "-", scale: 0.05, align: alignment.left)
		testLabel2.position = SCNVector3(x: 0.1, y: -0.65, z: 0)
		testLabel2.name = "label.speed"
		panelNode.addChildNode(testLabel2)
		
		scene.rootNode.addChildNode(panelNode)
	}
	
	func panel_thruster_update()
	{
		let panelNode = scene.rootNode.childNodeWithName("panel.thurster", recursively: false)!
		
		let knobMesh = panelNode.childNodeWithName("knob.mesh", recursively: true)!
		let targetAngle = Double(user.speed) * -1
		knobMesh.runAction(SCNAction.rotateToAxisAngle(SCNVector4Make(0, 0, 1, Float(M_PI/2 * targetAngle)), duration: 0.7))
		
		for node in knobMesh.childNodes
		{
			var node: SCNNode = node as! SCNNode
			if( user.speed == 0){
				node.geometry!.firstMaterial?.diffuse.contents = red
			}
			else{
				node.geometry!.firstMaterial?.diffuse.contents = cyan
			}
		}
		
		let labelNode = panelNode.childNodeWithName("label.speed", recursively: true)! as! SCNLabel
		labelNode.update(String(Int(user.speed)))
	}

	func panel_commander()
	{
		// Draw the frame
		
		let scale:Float = 0.8
		let nodeA = SCNVector3(x: highNode[3].x * scale, y: highNode[3].y * scale, z: highNode[3].z)
		let nodeB = SCNVector3(x: highNode[4].x * scale, y: highNode[4].y * scale, z: highNode[4].z)
		let nodeC = SCNVector3(x: lowNode[3].x * scale, y: lowNode[3].y * scale, z: lowNode[3].z)
		let nodeD = SCNVector3(x: lowNode[4].x * scale, y: lowNode[4].y * scale, z: lowNode[4].z)
		
		// Interface
		
		let panelNode = SCNNode()
		panelNode.position = SCNVector3(x: 0, y: 0, z: lowNode[3].z)
		
		panelNode.addChildNode(toggle("thruster",position: SCNVector3(x: 0.75, y: 0.35, z: 0)))
		panelNode.addChildNode(toggle("electric",position: SCNVector3(x: -0.75, y: 0.35, z: 0)))
		
		panelNode.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2)); // rotate 90 degrees
		scene.rootNode.addChildNode(panelNode)
	}
	
}