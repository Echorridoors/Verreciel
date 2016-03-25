
//  Created by Devine Lu Linvega on 2015-07-06.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelThruster : MainPanel
{
	var accelerate:SCNTrigger!
	var decelerate:SCNTrigger!
	var action:SCNTrigger!
	
	// Speed Lines
	var interface_flight = SCNNode()
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
	
	// Docking
	var interface_dock = SCNNode()
	
	// Warping
	var interface_warp = SCNNode()
	
	var lineLeft:SCNLine!
	var lineRight:SCNLine!
	
	var maxSpeed:Int = 0
	var speed:Int = 0
	var actualSpeed:Float = 0
	
	var canWarp:Bool = false
	var isLocked:Bool = false
	
	// MARK: Default -
	
	override init()
	{
		super.init()
		
		name = "thruster"
		info = "[missing text]"
		
		// Flight
		
		mainNode.addChildNode(interface_flight)
		
		line1 = SCNLine(nodeA: SCNVector3(-0.5, -0.3, 0), nodeB: SCNVector3(0.5, -0.3, 0), color: grey)
		line2 = SCNLine(nodeA: SCNVector3(-0.5, -0.1, 0), nodeB: SCNVector3(0.5, -0.1, 0), color: grey)
		line3 = SCNLine(nodeA: SCNVector3(-0.5, 0.1, 0), nodeB: SCNVector3(0.5, 0.1, 0), color: grey)
		line4 = SCNLine(nodeA: SCNVector3(-0.5, 0.3, 0), nodeB: SCNVector3(0.5, 0.3, 0), color: grey)
		
		interface_flight.addChildNode(line1)
		interface_flight.addChildNode(line2)
		interface_flight.addChildNode(line3)
		interface_flight.addChildNode(line4)
		
		cutLine1Left = SCNLine(nodeA: SCNVector3(-0.5, -0.3, 0), nodeB: SCNVector3(-0.1, -0.3, 0), color: grey)
		cutLine1Right = SCNLine(nodeA: SCNVector3(0.5, -0.3, 0), nodeB: SCNVector3(0.1, -0.3, 0), color: grey)
		cutLine2Left = SCNLine(nodeA: SCNVector3(-0.5, -0.1, 0), nodeB: SCNVector3(-0.1, -0.1, 0), color: grey)
		cutLine2Right = SCNLine(nodeA: SCNVector3(0.5, -0.1, 0), nodeB: SCNVector3(0.1, -0.1, 0), color: grey)
		cutLine3Left = SCNLine(nodeA: SCNVector3(-0.5, 0.1, 0), nodeB: SCNVector3(-0.1, 0.1, 0), color: grey)
		cutLine3Right = SCNLine(nodeA: SCNVector3(0.5, 0.1, 0), nodeB: SCNVector3(0.1, 0.1, 0), color: grey)
		cutLine4Left = SCNLine(nodeA: SCNVector3(-0.5, 0.3, 0), nodeB: SCNVector3(-0.1, 0.3, 0), color: grey)
		cutLine4Right = SCNLine(nodeA: SCNVector3(0.5, 0.3, 0), nodeB: SCNVector3(0.1, 0.3, 0), color: grey)
		
		interface_flight.addChildNode(cutLine1Left)
		interface_flight.addChildNode(cutLine1Right)
		interface_flight.addChildNode(cutLine2Left)
		interface_flight.addChildNode(cutLine2Right)
		interface_flight.addChildNode(cutLine3Left)
		interface_flight.addChildNode(cutLine3Right)
		interface_flight.addChildNode(cutLine4Left)
		interface_flight.addChildNode(cutLine4Right)
		
		// Dock
		
		mainNode.addChildNode(interface_dock)
		interface_dock.addChildNode(SCNLine(nodeA: SCNVector3(-0.1, 0, 0), nodeB: SCNVector3(0, 0.1, 0), color: grey))
		interface_dock.addChildNode(SCNLine(nodeA: SCNVector3(0.1, 0, 0), nodeB: SCNVector3(0, 0.1, 0), color: grey))
		interface_dock.addChildNode(SCNLine(nodeA: SCNVector3(-0.1, -0.1, 0), nodeB: SCNVector3(0, 0, 0), color: grey))
		interface_dock.addChildNode(SCNLine(nodeA: SCNVector3(0.1, -0.1, 0), nodeB: SCNVector3(0, 0, 0), color: grey))
		
		// Warp
		
		mainNode.addChildNode(interface_warp)
		var verticalOffset:CGFloat = 0.1
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(-0.1, verticalOffset, 0), nodeB: SCNVector3(0, 0.1 + verticalOffset, 0), color: cyan))
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(0.1, verticalOffset, 0), nodeB: SCNVector3(0, 0.1 + verticalOffset, 0), color: cyan))
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(-0.1, verticalOffset, 0), nodeB: SCNVector3(-0.4, verticalOffset, 0), color: cyan))
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(0.1, verticalOffset, 0), nodeB: SCNVector3(0.4, verticalOffset, 0), color: cyan))
		verticalOffset = -0.1
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(-0.1, verticalOffset, 0), nodeB: SCNVector3(0, 0.1 + verticalOffset, 0), color: cyan))
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(0.1, verticalOffset, 0), nodeB: SCNVector3(0, 0.1 + verticalOffset, 0), color: cyan))
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(-0.1, verticalOffset, 0), nodeB: SCNVector3(-0.4, verticalOffset, 0), color: cyan))
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(0.1, verticalOffset, 0), nodeB: SCNVector3(0.4, verticalOffset, 0), color: cyan))
		verticalOffset = 0.3
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(-0.1, verticalOffset, 0), nodeB: SCNVector3(0, 0.1 + verticalOffset, 0), color: cyan))
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(0.1, verticalOffset, 0), nodeB: SCNVector3(0, 0.1 + verticalOffset, 0), color: cyan))
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(-0.1, verticalOffset, 0), nodeB: SCNVector3(-0.4, verticalOffset, 0), color: cyan))
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(0.1, verticalOffset, 0), nodeB: SCNVector3(0.4, verticalOffset, 0), color: cyan))
		verticalOffset = -0.3
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(-0.1, verticalOffset, 0), nodeB: SCNVector3(0, 0.1 + verticalOffset, 0), color: cyan))
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(0.1, verticalOffset, 0), nodeB: SCNVector3(0, 0.1 + verticalOffset, 0), color: cyan))
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(-0.1, verticalOffset, 0), nodeB: SCNVector3(-0.4, verticalOffset, 0), color: cyan))
		interface_warp.addChildNode(SCNLine(nodeA: SCNVector3(0.1, verticalOffset, 0), nodeB: SCNVector3(0.4, verticalOffset, 0), color: cyan))
		
		// Etcs
		
		lineLeft = SCNLine(nodeA: SCNVector3(-0.5, 0.5, 0), nodeB: SCNVector3(-0.5, -0.5, 0), color: red)
		mainNode.addChildNode(lineLeft)
		lineRight = SCNLine(nodeA: SCNVector3(0.5, 0.5, 0), nodeB: SCNVector3(0.5, -0.5, 0), color: red)
		mainNode.addChildNode(lineRight)
		
		// Triggers
		
		accelerate = SCNTrigger(host: self, size: CGSize(width: 1, height: 1), operation: 1)
		accelerate.position = SCNVector3(0, 0.5, 0)
		accelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, 0), nodeB: SCNVector3(0.5, 0, 0), color: cyan))
		accelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, 0), nodeB: SCNVector3(-0.5, 0, 0), color: cyan))
		
		decelerate = SCNTrigger(host: self, size: CGSize(width: 1, height: 1), operation: 0)
		decelerate.position = SCNVector3(0, -0.5, 0)
		decelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.2, 0), nodeB: SCNVector3(0.5, 0, 0), color: red))
		decelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.2, 0), nodeB: SCNVector3(-0.5, 0, 0), color: red))
		
		action = SCNTrigger(host: self, size: CGSize(width: 1.5, height: 1.5), operation: 2)
		
		mainNode.addChildNode(accelerate)
		mainNode.addChildNode(decelerate)
		mainNode.addChildNode(action)
		
		port.input = Event.self
		port.output = Event.self
		
		details.update("--")
		
		decalsNode.empty()
	}

	override func touch(id:Int = 0)
	{
		if id == 0 {
			speedDown()
		}
		else if id == 1 {
			speedUp()
		}
		if id == 2 {
			if canWarp == true {
				capsule.warp(pilot.port.origin.event as! Location)
			}
			else{
				capsule.undock()
			}
		}
	}
	
	override func update()
	{
		maxSpeed = 0
		
		if battery.thrusterPort.origin != nil && battery.thrusterPort.origin.event != nil {
			if battery.thrusterPort.origin.event == items.cell1 || battery.thrusterPort.origin.event == items.cell2 { maxSpeed = 1 }
			if battery.thrusterPort.origin.event == items.array1 || battery.thrusterPort.origin.event == items.array2 { maxSpeed = 2 }
			if battery.thrusterPort.origin.event == items.grid1 || battery.thrusterPort.origin.event == items.grid2 { maxSpeed = 3 }
			if battery.thrusterPort.origin.event == items.matrix1 || battery.thrusterPort.origin.event == items.matrix2 { maxSpeed = 4 }
		}
		
		if maxSpeed > 0 { line1.opacity = 1 ; cutLine1Left.opacity = 0 ; cutLine1Right.opacity = 0 } else { line1.opacity = 0 ; cutLine1Left.opacity = 1 ; cutLine1Right.opacity = 1 }
		if maxSpeed > 1 { line2.opacity = 1 ; cutLine2Left.opacity = 0 ; cutLine2Right.opacity = 0 } else { line2.opacity = 0 ; cutLine2Left.opacity = 1 ; cutLine2Right.opacity = 1 }
		if maxSpeed > 2 { line3.opacity = 1 ; cutLine3Left.opacity = 0 ; cutLine3Right.opacity = 0 } else { line3.opacity = 0 ; cutLine3Left.opacity = 1 ; cutLine3Right.opacity = 1 }
		if maxSpeed > 3 { line4.opacity = 1 ; cutLine4Left.opacity = 0 ; cutLine4Right.opacity = 0 } else { line4.opacity = 0 ; cutLine4Left.opacity = 1 ; cutLine4Right.opacity = 1 }
	}
	
	override func fixedUpdate()
	{
		super.fixedUpdate()
		
		canWarp = false
		
		update()
		
		if isLocked == true {
			modeLocked()
		}
		else if battery.thrusterPort.isReceivingItemOfType(.battery) == false {
			speed = 0
			modeUnpowered()
		}
		else if capsule.isWarping == true {
			modeWarping()
		}
		else if port.isReceiving(items.warpDrive) == true && pilot.port.isReceivingLocationOfType(.portal) == true {
			modeWaitingForWarp()
			canWarp = true
		}
		else if port.isReceiving(items.warpDrive) == true {
			modeMissingPilotForWarp()
			canWarp = true
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
		
		thrust()
	}
	
	// MARK: Locking
	
	func lock()
	{
		isLocked = true
	}
	
	func unlock()
	{
		isLocked = false
	}
	
	// MARK: Custom -
	
	func onPowered()
	{
		print("* THRUSTER | Powered: \(name)")
		refresh()
	}
	
	func onUnpowered()
	{
		print("* THRUSTER | Powered: \(name)")
		refresh()
	}
	
	// MARK: Modes -
	
	func modeLocked()
	{
		details.update("locked")
		
		interface_flight.opacity = 0
		interface_dock.opacity = 1
		interface_warp.opacity = 0
		
		action.disable()
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(grey)
		decelerate.updateChildrenColors(grey)
		
		lineLeft.color(grey)
		lineRight.color(grey)
	}
	
	func modeWarping()
	{
		details.update("warping")
		
		interface_flight.opacity = 0
		interface_dock.opacity = 0
		interface_warp.opacity = 1
		
		action.disable()
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(clear)
		decelerate.updateChildrenColors(clear)
		
		line1.opacity = 1 ; cutLine1Left.opacity = 0 ; cutLine1Right.opacity = 0
		line2.opacity = 1 ; cutLine2Left.opacity = 0 ; cutLine2Right.opacity = 0
		line3.opacity = 1 ; cutLine3Left.opacity = 0 ; cutLine3Right.opacity = 0
		line4.opacity = 1 ; cutLine4Left.opacity = 0 ; cutLine4Right.opacity = 0
		
		line1.blink()
		line2.blink()
		line3.blink()
		line4.blink()
		
		lineLeft.color(clear)
		lineRight.color(clear)
	}
	
	func modeWaitingForWarp()
	{
		details.update("warp")
		
		interface_flight.opacity = 0
		interface_dock.opacity = 0
		interface_warp.opacity = 1
		
		action.enable()
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(cyan)
		decelerate.updateChildrenColors(cyan)
		
		lineLeft.color(cyan)
		lineRight.color(cyan)
	}
	
	func modeMissingPilotForWarp()
	{
		details.update("pilot")
		
		interface_flight.opacity = 0
		interface_dock.opacity = 0
		interface_warp.opacity = 1
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(grey)
		decelerate.updateChildrenColors(grey)
		
		line1.opacity = 1 ; cutLine1Left.opacity = 0 ; cutLine1Right.opacity = 0
		line2.opacity = 1 ; cutLine2Left.opacity = 0 ; cutLine2Right.opacity = 0
		line3.opacity = 1 ; cutLine3Left.opacity = 0 ; cutLine3Right.opacity = 0
		line4.opacity = 1 ; cutLine4Left.opacity = 0 ; cutLine4Right.opacity = 0
		
		lineLeft.color(grey)
		lineRight.color(grey)
	}
	
	func modeUnpowered()
	{
		details.update("unpowered")
		
		interface_flight.opacity = 0
		interface_dock.opacity = 0
		interface_warp.opacity = 0
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(grey)
		decelerate.updateChildrenColors(grey)
		
		line1.opacity = 0 ; cutLine1Left.opacity = 1 ; cutLine1Right.opacity = 1
		line2.opacity = 0 ; cutLine2Left.opacity = 1 ; cutLine2Right.opacity = 1
		line3.opacity = 0 ; cutLine3Left.opacity = 1 ; cutLine3Right.opacity = 1
		line4.opacity = 0 ; cutLine4Left.opacity = 1 ; cutLine4Right.opacity = 1
	}
	
	func modeDocking()
	{
		let dockingProgress = Int((1 - distanceBetweenTwoPoints(capsule.at, point2: capsule.dock.at)/0.5) * 100)
		details.update("docking \(dockingProgress)%")
		
		interface_flight.opacity = 0
		interface_dock.opacity = 1
		interface_warp.opacity = 0
		
		action.enable()
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(grey)
		decelerate.updateChildrenColors(grey)
		
		lineLeft.color(clear)
		lineRight.color(clear)
	}
	
	func modeDocked()
	{
		details.update("undock")
		
		interface_flight.opacity = 0
		interface_dock.opacity = 1
		interface_warp.opacity = 0

		action.enable()
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(red)
		decelerate.updateChildrenColors(red)
		
		lineLeft.color(red)
		lineRight.color(red)
	}
	
	func modeFlight()
	{
		details.update(String(format: "%.1f", actualSpeed))
		
		interface_flight.opacity = 1
		interface_dock.opacity = 0
		interface_warp.opacity = 0
		
		if speed > 0 { line1.color(white) } else { line1.color(grey) }
		if speed > 1 { line2.color(white) } else { line2.color(grey) }
		if speed > 2 { line3.color(white) } else { line3.color(grey) }
		if speed > 3 { line4.color(white) } else { line4.color(grey) }
		
		action.disable()
		
		accelerate.enable()
		decelerate.enable()
		
		accelerate.updateChildrenColors((speed == maxSpeed ? grey : cyan))
		decelerate.updateChildrenColors((speed == 0 ? grey : red))
		
		lineLeft.color(clear)
		lineRight.color(clear)
		
		interface_dock.opacity = 0
		interface_flight.opacity = 1
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
		if capsule.isWarping == true { speed = 100 ; return }
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
		super.onInstallationBegin()
		
		if debug.isActive == false { player.lookAt(deg: -45) }
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}