//
//  CapsuleNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreCapsule: SCNNode
{
	var hull:Float = 100
	var shield:Float = 100
	var oxygen:Float = 100
	
	var at:CGPoint = universe.loiqe_spawn.at
	var journey:Float = 0
	
	var direction:CGFloat! = 1
	var sector:sectors = sectors.normal
	
	var isDocked:Bool = false
	var dock:Location!
	var mesh:SCNNode!
	
	// MARK: Default -
	
	override init()
	{
		super.init()
		
		self.direction = 0
		
		nodeSetup()
		panelSetup()
	}
	
	override func start()
	{
		battery.installed()
	}
	
	override func fixedUpdate()
	{
		service()
		systems()
		docking()
	}
	
	// MARK: Custom -
	
	func docking()
	{
		if dock == nil { return }
		if isDocked == true { return }
		
		let horizontalLocation:Int = Int(capsule.at.y * 1000)
		let horizontalTarget:Int = Int(dock.at.y * 1000)
		let horizontalOffset:Int = horizontalLocation - horizontalTarget
		
		let verticalLocation:Int = Int(capsule.at.y * 1000)
		let verticalTarget:Int = Int(dock.at.y * 1000)
		let verticalOffset:Int = verticalLocation - verticalTarget
		
		var approachSpeed:CGFloat = 0.001
		let distanceRatio = distanceBetweenTwoPoints(capsule.at, point2: capsule.dock.at)/0.5
		approachSpeed = (CGFloat(approachSpeed) * CGFloat(distanceRatio))
		
		if approachSpeed < 0.0001 { approachSpeed = 0.0001 }
	
		if horizontalOffset > 0 { capsule.at.y -= approachSpeed }
		if horizontalOffset < 0 { capsule.at.y += approachSpeed }
		if verticalOffset > 0 { capsule.at.y -= approachSpeed }
		if verticalOffset < 0 { capsule.at.y += approachSpeed }
		
		if abs(horizontalOffset) < 2 && abs(verticalOffset) < 2 { docked() }
	}
	
	func docked()
	{
		isDocked = true
		capsule.at = dock.at
		dock.docked()
		ui.addPassive("Docked at \(dock.name!)")
	}
	
	func dock(newDock:Location)
	{
		print("init dock")
		dock = newDock
		thruster.disable()
		
		ui.addPassive("docking \(dock.name!)")
	}
	
	func undock()
	{
		print("quit dock")
		isDocked = false
		dock = nil
		thruster.enable()
		
		ui.addPassive("in flight")
	}
	
	// MARK: Custom -
	
	func nodeSetup()
	{
		var scale:Float = 0.25
		var height:Float = -3.35
		
		scale = 1
		height = 1.5
		
		var highNode = [SCNVector3(x: 2 * scale, y: height, z: -4 * scale),SCNVector3(x: 4 * scale, y: height, z: -2 * scale),SCNVector3(x: 4 * scale, y: height, z: 2 * scale),SCNVector3(x: 2 * scale, y: height, z: 4 * scale),SCNVector3(x: -2 * scale, y: height, z: 4 * scale),SCNVector3(x: -4 * scale, y: height, z: 2 * scale),SCNVector3(x: -4 * scale, y: height, z: -2 * scale),SCNVector3(x: -2 * scale, y: height, z: -4 * scale)]
		
		templates.left = highNode[7].x
		templates.right = highNode[0].x
		templates.top = highNode[0].y
		templates.bottom = -highNode[0].y
		templates.leftMargin = highNode[7].x * 0.8
		templates.rightMargin = highNode[0].x * 0.8
		templates.topMargin = highNode[0].y * 0.8
		templates.bottomMargin = -highNode[0].y * 0.8
		templates.radius = highNode[0].z
		
		mesh = SCNNode()
		mesh.position = SCNVector3(0,0,0)
		addChildNode(mesh)
		
		var i = 0
		while i < 90 {
			let line = SCNLine(nodeA: SCNVector3(-0.1,-3,templates.radius), nodeB: SCNVector3(0.1,-3,templates.radius), color: grey)
			line.eulerAngles.y += Float(degToRad(CGFloat(i) * 4))
			mesh.addChildNode(line)
			let line3 = SCNLine(nodeA: SCNVector3(-0.05,4,templates.radius/2.5), nodeB: SCNVector3(0.05,4,templates.radius/2.5), color: grey)
			line3.eulerAngles.y += Float(degToRad(CGFloat(i) * 4))
			mesh.addChildNode(line3)
			i += 1
		}
	}
	
	func systems()
	{
		if battery.oxygenPort.origin != nil {
			if battery.oxygenPort.origin.event.type == eventTypes.cell && capsule.oxygen < 100 { capsule.oxygen += 0.5 }
		}
		if battery.shieldPort.origin != nil {
			if battery.shieldPort.origin.event.type == eventTypes.cell && capsule.shield < 100 { capsule.shield += 0.5 }
		}
	}
	
	func service()
	{
		if dock == nil { return }
		if dock.service == services.electricity && battery.value < 100 { battery.recharge() }
		if dock.service == services.hull && capsule.hull < 100 { capsule.hull += 0.5 }
	}
	
	func panelSetup()
	{
		addChildNode(battery)
		addChildNode(hatch)
		addChildNode(console)
		addChildNode(cargo)
		addChildNode(mission)
		addChildNode(pilot)
		addChildNode(radar)
		addChildNode(thruster)
		
		hatch.eulerAngles.y = Float(degToRad(45))
		console.eulerAngles.y = Float(degToRad(90))
		cargo.eulerAngles.y = Float(degToRad(135))
		mission.eulerAngles.y = Float(degToRad(180))
		pilot.eulerAngles.y = Float(degToRad(225))
		radar.eulerAngles.y = Float(degToRad(270))
		thruster.eulerAngles.y = Float(degToRad(315))
		
		battery.addChildNode(PanelHandle(destination: SCNVector3(0,0,-1.5)))
		console.addChildNode(PanelHandle(destination: SCNVector3(-1.5,0,0)))
		mission.addChildNode(PanelHandle(destination: SCNVector3(0,0,1.5)))
		radar.addChildNode(PanelHandle(destination: SCNVector3(1.5,0,0)))	
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}