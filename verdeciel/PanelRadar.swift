//
//  displayNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelRadar : SCNNode
{
	var x:Float = 0
	var z:Float = 0
	
	var labelPositionX:SCNLabel!
	var labelPositionZ:SCNLabel!
	var labelDistance:SCNLabel!
	
	var eventView:SCNNode!
	var shipCursor:SCNNode!
	
	var targetter:SCNNode!
	var targetterAway:SCNNode!
	
	var horizontalGrid:SCNLine!
	var verticalGrid:SCNLine!
	
	// Ports
	
	var inputLabel:SCNLabel!
	var outputLabel:SCNLabel!
	var input:SCNPort!
	var output:SCNPort!
	
	override init()
	{
		super.init()
		name = "radar"
		addInterface()
		
		eventView = SCNNode()
		self.addChildNode(eventView)
	
		targetter = createTargetter()
		eventView.addChildNode(targetter)
	}
	
	func createTargetter() -> SCNNode
	{
		let targetterNode = SCNNode()
		
		targetterNode.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0), nodeB: SCNVector3(x: 0.2, y: 0, z: 0), color: red))
		targetterNode.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.2, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: -0.2, z: 0), color: red))
		targetterNode.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -0.2, z: 0), nodeB: SCNVector3(x: -0.2, y: 0, z: 0), color: red))
		targetterNode.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.2, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0.2, z: 0), color: red))
		
		return targetterNode
	}
	
	func addEvent(event:SCNEvent)
	{
		eventView.addChildNode(event)
		update()
	}
	
	func addInterface()
	{
		// Draw the frame
		
		let scale:Float = 0.8
		
		// Draw Radar
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		
		// Ports
		
		input = SCNPort(host: self, polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.1, y: highNode[7].y * scale, z: 0)
		output = SCNPort(host: self, polarity: true)
		output.position = SCNVector3(x: lowNode[0].x * scale - 0.15, y: highNode[7].y * scale, z: 0)
		
		inputLabel = SCNLabel(text: "radar", scale: 0.1, align: alignment.left)
		inputLabel.position = SCNVector3(x: lowNode[7].x * scale + 0.3, y: highNode[7].y * scale, z: 0)
		
		outputLabel = SCNLabel(text: "", scale: 0.1, align: alignment.right)
		outputLabel.position = SCNVector3(x: lowNode[0].x * scale - 0.3, y: highNode[0].y * scale, z: 0)
		
		self.addChildNode(input)
		self.addChildNode(output)
		self.addChildNode(inputLabel)
		self.addChildNode(outputLabel)
		
		// Ship
		
		shipCursor = SCNNode()
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: 0.2, y: 0, z: 0),color:white))
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: -0.2, y: 0, z: 0),color:white))
		self.addChildNode(shipCursor)
		
		labelPositionX = SCNLabel(text: "x", scale: 0.1, align: alignment.left)
		labelPositionX.position = SCNVector3(x: lowNode[7].x * scale, y: lowNode[7].y * scale, z: 0)
		labelPositionX.name = "radar.x"
		self.addChildNode(labelPositionX)
		
		labelPositionZ = SCNLabel(text: "z", scale: 0.1, align: alignment.left)
		labelPositionZ.position = SCNVector3(x: highNode[7].x * scale, y: lowNode[7].y * scale + 0.3, z: 0)
		labelPositionZ.name = "radar.z"
		self.addChildNode(labelPositionZ)
		
		labelDistance = SCNLabel(text: "90.4", scale: 0.1, align: alignment.right)
		labelDistance.position = SCNVector3(x: lowNode[0].x * scale, y: lowNode[7].y * scale, z: 0)
		self.addChildNode(labelDistance)
		
		targetterAway = SCNNode()
		targetterAway.addChildNode(SCNLine(nodeA: SCNVector3(0.8,0,0), nodeB: SCNVector3(1,0,0), color: red))
		self.addChildNode(targetterAway)
		targetterAway.opacity = 0
		
		horizontalGrid = SCNLine(nodeA: SCNVector3(lowNode[7].x,0,0),nodeB: SCNVector3(lowNode[0].x,0,0),color:grey)
		self.addChildNode(horizontalGrid)
		
		verticalGrid = SCNLine(nodeA: SCNVector3(0,highNode[7].y,0),nodeB: SCNVector3(0,lowNode[0].y,0),color:grey)
		self.addChildNode(verticalGrid)
	}
	
	override func tic()
	{
		let directionNormal = Double(Float(capsule.direction)/180) * -1
		shipCursor.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * directionNormal))
		
		update()
	}
	
	override func update()
	{
		labelPositionX.update(String(Int(capsule.location.x)))
		labelPositionZ.update(String(Int(capsule.location.y)))
		
		updateEvents()
		updateTarget()
		
		horizontalGrid.position = SCNVector3(0,((capsule.location.y * -1) % 3) + 1.5,-0.001)
		verticalGrid.position = SCNVector3(((capsule.location.x * -1) % 4) + 2,0,-0.001)
	}
	
	func updateEvents()
	{		
		eventView.position = SCNVector3(capsule.location.x * -1,capsule.location.y * -1,0)
		for event in eventView.childNodes
		{
			event.update()
		}
	}
	
	func updateTarget()
	{		
		if output.event != nil {
			targetter.position = output.event.position
			targetter.opacity = 1
			
			let shipNodePosition = CGPoint(x: CGFloat(capsule.location.x), y: CGFloat(capsule.location.y))
			let eventNodePosition = CGPoint(x: CGFloat(output.event.location.x), y: CGFloat(output.event.location.y))
			let distanceFromShip = Float(distanceBetweenTwoPoints(shipNodePosition,point2: eventNodePosition))
			
			labelDistance.update(String(format: "%.1f",distanceFromShip))
			labelDistance.opacity = 1
			
			
			print("ShipAngle:\(capsule.direction) EventAngle:\(output.event.angleFromCapsule)")
			
			if output.event.isKnown == false && distanceFromShip < 0.2 {
				output.event.isKnown = true
				output.event.update()
			}
			
			if distanceFromShip > 1.4 {
				targetter.opacity = 0
				let angleTest = angleBetweenTwoPoints(capsule.location, point2: output.event.location, center: capsule.location)
				let targetDirectionNormal = Double(Float(angleTest)/180) * 1
				targetterAway.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * targetDirectionNormal))
				targetterAway.opacity = 1
			}
			else{
				targetterAway.opacity = 0
			}
		}
		else{
			targetter.opacity = 0
			labelDistance.opacity = 0
		}
		
	}

	func addTarget(event:SCNEvent)
	{
		output.addEvent(event)
		outputLabel.updateWithColor(event.name!, color: white)
		
		targetter.position = event.position
		targetter.opacity = 1
		
		self.bang()
		updateTarget()
	}
	
	func removeTarget()
	{
		output.disconnect()
		targetter.opacity = 0
		
		output.removeEvent()
		
		updateTarget()
	}
	
	override func listen(event: SCNEvent)
	{
		if event.type == eventTypes.map {
			radar.inputLabel.update("+\(event.content.count) new")
			for location in event.content {
				self.addEvent(location)
			}
			event.size = 0
			cargo.bang(true)
		}
		
		update()
	}
	
	override func bang(param:Bool = true)
	{
		if output.connection == nil { return }
		if output.event == nil { return }
		
		output.connection.host.listen(output.event)
		
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}