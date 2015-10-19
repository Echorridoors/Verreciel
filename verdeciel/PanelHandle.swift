//
//  File.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-08-28.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelHandle : Panel
{
	var destination:SCNVector3!
	var selectionLine1:SCNLine!
	var selectionLine2:SCNLine!
	var trigger:SCNTrigger!
	
	override func setup()
	{
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		selectionLine1 = SCNLine(nodeA: SCNVector3(x: -0.3, y: 0.05, z: 0),nodeB: SCNVector3(x: 0.3, y: 0.05, z: 0),color:cyan)
		selectionLine2 = SCNLine(nodeA: SCNVector3(x: -0.3, y: -0.05, z: 0),nodeB: SCNVector3(x: 0.3, y: -0.05, z: 0),color:cyan)
		interface.addChildNode(selectionLine1)
		interface.addChildNode(selectionLine2)
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 0.5), operation: 0)
		interface.addChildNode(trigger)
		
		self.eulerAngles.x += Float(degToRad(-templates.titlesAngle))
	}
	
	func enable()
	{
		isEnabled = true
		selectionLine1.updateColor(cyan)
		selectionLine2.updateColor(cyan)
	}
	
	func disable()
	{
		isEnabled = false
		selectionLine1.updateColor(grey)
		selectionLine2.updateColor(grey)
	}
	
	override func touch(id:Int = 0)
	{
		if player.handle != nil { player.handle.enable() }
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		player.position = destination
		ui.position = destination
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
		
		player.handle = self
		player.handle.disable()
	}
}