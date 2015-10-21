//
//  SCNNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Panel : SCNNode
{
	var label = SCNLabel()
	var details = SCNLabel()
	var port:SCNPort!
	
	var isPowered:Bool = false
	var isEnabled:Bool = true
	var interface:SCNNode!
	var decals:SCNNode!
	
	var isInstalling:Bool = false
	var isInstalled:Bool = false
	var installer:SCNNode = SCNNode()
	var installProgress:CGFloat = 0
	var installProgressBar = SCNProgressBar(width: 1)
	
	override init()
	{
		super.init()
		
		interface = SCNNode()
		self.addChildNode(interface)
		decals = SCNNode()
		self.addChildNode(decals)
		
		setup()
		installation()
		start()
	}
	
	func setup()
	{
		
	}
	
	func install()
	{
		isInstalling = true
	}
	
	override func fixedUpdate()
	{
		if isInstalling == true {
			installProgress += CGFloat(arc4random_uniform(100))/100
			installProgressBar.update(installProgress)
			label.updateWithColor("Installing \(Int(installProgress))%", color: grey)
			installProgressBar.opacity = 1
			
			if installProgress >= 100 {
				installed()
				installer.opacity = 0
				isInstalling = false
			}
		}
		
		if isInstalled == true {
			installedFixedUpdate()
		}
	}
	
	func installedFixedUpdate()
	{
	
	}
	
	func installation()
	{
		installer = template_installer()
		installer.position = SCNVector3(0,0,templates.radius)
		installProgressBar = SCNProgressBar(width: 1)
		installProgressBar.position = SCNVector3(-0.5,-0.5,0)
		installProgressBar.opacity = 0
		installer.addChildNode(installProgressBar)
		self.addChildNode(installer)
		
		label.updateWithColor("--", color: grey)
		interface.opacity = 0
		decals.opacity = 0
	}
	
	func installed()
	{
		isInstalled = true
		installer.opacity = 0
		
		label.updateWithColor(name!, color: white)
		decals.position = SCNVector3(0,0,templates.radius - 0.5)
		interface.position = SCNVector3(0,0,templates.radius + 1)
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		decals.opacity = 1
		decals.position = SCNVector3(0,0,templates.radius)
		interface.opacity = 1
		interface.position = SCNVector3(0,0,templates.radius)
		details.opacity = 1
		SCNTransaction.setCompletionBlock({ self.port.enable() })
		SCNTransaction.commit()
	}
	
	func setPower(power:Bool)
	{
		print("Missing unpowered mode for \(name!).")
	}
	
	func updateInterface(interface:Panel)
	{
		// Empty node
		for node in self.childNodes {
			node.removeFromParentNode()
		}
		
		// Add
		for node in interface.childNodes {
			self.addChildNode(node)
		}
	}
	
	func template_installer() -> SCNNode
	{
		let sprite = SCNNode()
		
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(-0.1,0.1,0), nodeB: SCNVector3(0.1,-0.1,0), color: grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(-0.1,-0.1,0), nodeB: SCNVector3(0.1,0.1,0), color: grey))
		
		return sprite
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}