//  Created by Devine Lu Linvega on 2015-07-06.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelThruster : Panel
{
	var accelerate:SCNTrigger!
	var decelerate:SCNTrigger!
	
	var line1:SCNLine!
	var line2:SCNLine!
	var line3:SCNLine!
	var line4:SCNLine!
	
	var cutLine1Left:SCNLine!
	var cutLine1Right:SCNLine!
	var cutLine2Left:SCNLine!
	var cutLine2Right:SCNLine!
	var cutLine3Left:SCNLine!
	var cutLine3Right:SCNLine!
	var cutLine4Left:SCNLine!
	var cutLine4Right:SCNLine!
	
	var maxSpeed:Int = 0
	var speed:Int = 0
	var actualSpeed:Float = 0
	
	var trigger:SCNTrigger!
	
	// MARK: Default -
	
	override func setup()
	{
		name = "thruster"
		
		// Lines
		line1 = SCNLine(nodeA: SCNVector3(-0.5, -0.3, 0), nodeB: SCNVector3(0.5, -0.3, 0), color: grey)
		line2 = SCNLine(nodeA: SCNVector3(-0.5, -0.1, 0), nodeB: SCNVector3(0.5, -0.1, 0), color: grey)
		line3 = SCNLine(nodeA: SCNVector3(-0.5, 0.1, 0), nodeB: SCNVector3(0.5, 0.1, 0), color: grey)
		line4 = SCNLine(nodeA: SCNVector3(-0.5, 0.3, 0), nodeB: SCNVector3(0.5, 0.3, 0), color: grey)
		
		cutLine1Left = SCNLine(nodeA: SCNVector3(-0.5, -0.3, 0), nodeB: SCNVector3(-0.1, -0.3, 0), color: grey)
		cutLine1Right = SCNLine(nodeA: SCNVector3(0.5, -0.3, 0), nodeB: SCNVector3(0.1, -0.3, 0), color: grey)
		cutLine2Left = SCNLine(nodeA: SCNVector3(-0.5, -0.1, 0), nodeB: SCNVector3(-0.1, -0.1, 0), color: grey)
		cutLine2Right = SCNLine(nodeA: SCNVector3(0.5, -0.1, 0), nodeB: SCNVector3(0.1, -0.1, 0), color: grey)
		cutLine3Left = SCNLine(nodeA: SCNVector3(-0.5, 0.1, 0), nodeB: SCNVector3(-0.1, 0.1, 0), color: grey)
		cutLine3Right = SCNLine(nodeA: SCNVector3(0.5, 0.1, 0), nodeB: SCNVector3(0.1, 0.1, 0), color: grey)
		cutLine4Left = SCNLine(nodeA: SCNVector3(-0.5, 0.3, 0), nodeB: SCNVector3(-0.1, 0.3, 0), color: grey)
		cutLine4Right = SCNLine(nodeA: SCNVector3(0.5, 0.3, 0), nodeB: SCNVector3(0.1, 0.3, 0), color: grey)
		
		interface.addChildNode(cutLine1Left)
		interface.addChildNode(cutLine1Right)
		interface.addChildNode(cutLine2Left)
		interface.addChildNode(cutLine2Right)
		interface.addChildNode(cutLine3Left)
		interface.addChildNode(cutLine3Right)
		interface.addChildNode(cutLine4Left)
		interface.addChildNode(cutLine4Right)
		
		interface.addChildNode(line1)
		interface.addChildNode(line2)
		interface.addChildNode(line3)
		interface.addChildNode(line4)
		
		// Triggers
		accelerate = SCNTrigger(host: self, size: CGSize(width: 1, height: 1), operation: 1)
		accelerate.position = SCNVector3(0, 0.5, 0)
		accelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, 0), nodeB: SCNVector3(0.5, 0, 0), color: cyan))
		accelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, 0), nodeB: SCNVector3(-0.5, 0, 0), color: cyan))
		
		decelerate = SCNTrigger(host: self, size: CGSize(width: 1, height: 1), operation: 0)
		decelerate.position = SCNVector3(0, -0.5, 0)
		decelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.2, 0), nodeB: SCNVector3(0.5, 0, 0), color: red))
		decelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.2, 0), nodeB: SCNVector3(-0.5, 0, 0), color: red))
		
		interface.addChildNode(accelerate)
		interface.addChildNode(decelerate)
		
		port.input = eventTypes.drive
		port.output = eventTypes.unknown
		
		let buttonWidth = 0.65
		trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 0.5), operation: 2)
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(-buttonWidth,-0.25,0), nodeB: SCNVector3(buttonWidth,-0.25,0), color: red))
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(-buttonWidth,0.25,0), nodeB: SCNVector3(buttonWidth,0.25,0), color: red))
		
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(-buttonWidth,0.25,0), nodeB: SCNVector3(-buttonWidth - 0.25,0,0), color: red))
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(-buttonWidth,-0.25,0), nodeB: SCNVector3(-buttonWidth - 0.25,0,0), color: red))
		
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(buttonWidth,0.25,0), nodeB: SCNVector3(buttonWidth + 0.25,0,0), color: red))
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(buttonWidth,-0.25,0), nodeB: SCNVector3(buttonWidth + 0.25,0,0), color: red))
		details.addChildNode(trigger)
	}
	
	override func start()
	{
		decals.opacity = 0
		interface.opacity = 0
		label.update("--", color: grey)
	}

	override func touch(id:Int = 0)
	{
		if id == 0 { speedDown() ; return }
		if id == 1 { speedUp() ; return }
		if id == 2 { capsule.undock() ; return }
	}
	
	override func update()
	{
		maxSpeed = 0
		
		if battery.thrusterPort.origin != nil && battery.thrusterPort.origin.event != nil {
			if battery.thrusterPort.origin.event == items.cell1 || battery.thrusterPort.origin.event == items.cell2 || battery.thrusterPort.origin.event == items.cell3 || battery.thrusterPort.origin.event == items.cell4 { maxSpeed = 1 }
			if battery.thrusterPort.origin.event == items.array1 || battery.thrusterPort.origin.event == items.array2 || battery.thrusterPort.origin.event == items.array3 || battery.thrusterPort.origin.event == items.array4 { maxSpeed = 2 }
			if battery.thrusterPort.origin.event == items.grid1 || battery.thrusterPort.origin.event == items.grid2 || battery.thrusterPort.origin.event == items.grid3 || battery.thrusterPort.origin.event == items.grid4 { maxSpeed = 3 }
			if battery.thrusterPort.origin.event == items.matrix1 || battery.thrusterPort.origin.event == items.matrix2 || battery.thrusterPort.origin.event == items.matrix3 || battery.thrusterPort.origin.event == items.matrix4 { maxSpeed = 4 }
		}
		
		if maxSpeed > 0 { line1.opacity = 1 ; cutLine1Left.opacity = 0 ; cutLine1Right.opacity = 0 } else { line1.opacity = 0 ; cutLine1Left.opacity = 1 ; cutLine1Right.opacity = 1 }
		if maxSpeed > 1 { line2.opacity = 1 ; cutLine2Left.opacity = 0 ; cutLine2Right.opacity = 0 } else { line2.opacity = 0 ; cutLine2Left.opacity = 1 ; cutLine2Right.opacity = 1 }
		if maxSpeed > 2 { line3.opacity = 1 ; cutLine3Left.opacity = 0 ; cutLine3Right.opacity = 0 } else { line3.opacity = 0 ; cutLine3Left.opacity = 1 ; cutLine3Right.opacity = 1 }
		if maxSpeed > 3 { line4.opacity = 1 ; cutLine4Left.opacity = 0 ; cutLine4Right.opacity = 0 } else { line4.opacity = 0 ; cutLine4Left.opacity = 1 ; cutLine4Right.opacity = 1 }
	}
	
	override func installedFixedUpdate()
	{
		if battery.isThrusterPowered() == false {
			speed = 0
			modeUnpowered()
		}
		else if capsule.isDocked == true {
			modeDocked()
		}
		else if capsule.dock != nil {
			modeDocking()
		}
		else {
			modeFlight()
		}
		
		update()
	
		thrust()
	}
	
	// MARK: Custom -
	
	func modeUnpowered()
	{
		label.updateColor(grey)
		details.update("unpowered", color: grey)
		port.disable()
		trigger.opacity = 0
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(clear)
		decelerate.updateChildrenColors(clear)
		
		line1.opacity = 0 ; cutLine1Left.opacity = 1 ; cutLine1Right.opacity = 1
		line2.opacity = 0 ; cutLine2Left.opacity = 1 ; cutLine2Right.opacity = 1
		line3.opacity = 0 ; cutLine3Left.opacity = 1 ; cutLine3Right.opacity = 1
		line4.opacity = 0 ; cutLine4Left.opacity = 1 ; cutLine4Right.opacity = 1
	}
	
	func modeDocking()
	{
		label.updateColor(white)
		details.update("Docking \( Int((1 - distanceBetweenTwoPoints(capsule.at, point2: capsule.dock.at)/0.5) * 100 ))%", color: white)
		port.enable()
		trigger.opacity = 0
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(grey)
		decelerate.updateChildrenColors(grey)
		
		line1.blink()
		line1.color(white)
		line2.color(grey)
		line3.color(grey)
		line4.color(grey)
	}
	
	func modeDocked()
	{
		label.updateColor(white)
		details.update("Undock", color:white)
		port.enable()
		trigger.opacity = 1
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(grey)
		decelerate.updateChildrenColors(grey)
		
		line1.opacity = 1
		line1.color(grey)
		line2.color(grey)
		line3.color(grey)
		line4.color(grey)
	}
	
	func modeFlight()
	{
		label.updateColor(white)
		details.update(String(format: "%.1f", actualSpeed), color: grey)
		port.enable()
		trigger.opacity = 0
		
		if speed > 0 { line1.color(white) } else { line1.color(grey) }
		if speed > 1 { line2.color(white) } else { line2.color(grey) }
		if speed > 2 { line3.color(white) } else { line3.color(grey) }
		if speed > 3 { line4.color(white) } else { line4.color(grey) }
		
		accelerate.enable()
		decelerate.enable()
		
		if speed == maxSpeed {
			accelerate.updateChildrenColors(grey)
		}
		else{
			accelerate.updateChildrenColors(cyan)
		}
		
		if speed == 0 {
			decelerate.updateChildrenColors(grey)
		}
		else{
			decelerate.updateChildrenColors(red)
		}
	}
	
	func speedUp()
	{
		if speed < maxSpeed {
			speed += 1
		}
	}
	
	func speedDown()
	{
		if speed >= 1 {
			speed -= 1
		}
	}
	
	func thrust()
	{
		if capsule.isDocked ==  true { speed = 0 ; actualSpeed = 0 ; return }
		
		if speed * 10 > Int(actualSpeed * 10) {
			actualSpeed += 0.1
		}
		else if speed * 10 < Int(actualSpeed * 10) {
			actualSpeed -= 0.1
		}
		
		if capsule.dock != nil {
			speed = 0
		}
		else if actualSpeed < 0.1 {
			actualSpeed = 0.1
		}
		
		if actualSpeed > 0
		{
			let speed:Float = Float(actualSpeed)/600
			let angle:CGFloat = CGFloat((capsule.direction) % 360)
			
			let angleRad = degToRad(angle)
			
			capsule.at.x += CGFloat(speed) * CGFloat(sin(angleRad))
			capsule.at.y += CGFloat(speed) * CGFloat(cos(angleRad))
		}
		
		journey.distance += actualSpeed
		space.starTimer += actualSpeed
	}
	
	override func onInstallationBegin()
	{
		player.lookAt(deg: -45)
	}
}