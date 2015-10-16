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

class PanelRadar : Panel
{
	var x:Float = 0
	var z:Float = 0
	
	var eventPivot = SCNNode()
	var eventView = universe
	var shipCursor:SCNNode!
	
	var target:Location!
	var targetter:SCNNode!
	var targetterFar:SCNNode!
	
	var panelHead:SCNNode!
	var input:SCNPort!
	var output:SCNPort!
	var outputLabel:SCNLabel!
	
	override func setup()
	{
		name = "radar"
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		panelHead = SCNNode()
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: -0.2, y: 0.4, z: templates.radius)
		output = SCNPort(host: self,polarity: true)
		output.position = SCNVector3(x: 0.2, y: 0.4, z: templates.radius)
		outputLabel = SCNLabel(text: name!, scale: 0.1, align: alignment.center)
		outputLabel.position = SCNVector3(x: 0.01, y: 0, z: templates.radius)
		panelHead.addChildNode(input)
		panelHead.addChildNode(output)
		panelHead.addChildNode(outputLabel)
		addChildNode(panelHead)
		panelHead.eulerAngles.x += Float(degToRad(templates.titlesAngle))
		
		interface.addChildNode(eventPivot)
		eventPivot.addChildNode(eventView)
		
		// Ship
		
		shipCursor = SCNNode()
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: 0.2, y: 0, z: 0),color:white))
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: -0.2, y: 0, z: 0),color:white))
		interface.addChildNode(shipCursor)
		
		targetterFar = SCNNode()
		targetterFar.addChildNode(SCNLine(nodeA: SCNVector3(0.8,0,0), nodeB: SCNVector3(1,0,0), color: red))
		targetterFar.opacity = 0
		interface.addChildNode(targetterFar)
		
		// Decals
		
		decals.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.bottom,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.bottom,0), color: grey))
		
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left,templates.bottom + 0.2,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right,templates.bottom + 0.2,0), color: grey))
		
		// Targetter
		
		targetter = SCNNode()
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0), nodeB: SCNVector3(x: 0.2, y: 0, z: 0), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.2, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: -0.2, z: 0), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -0.2, z: 0), nodeB: SCNVector3(x: -0.2, y: 0, z: 0), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.2, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0.2, z: 0), color: red))
		targetter.opacity = 0
		interface.addChildNode(targetter)
	}
	
	override func fixedUpdate()
	{
		if target != nil {
			outputLabel.updateWithColor(target.name!, color: white)
		}
		else{
			outputLabel.updateWithColor("\(closestLocation(eventDetails.star).name!) system", color: white)
		}

		eventView.position = SCNVector3(capsule.at.x * -1,capsule.at.y * -1,0)
		
		let directionNormal = Double(Float(capsule.direction)/180) * -1
		shipCursor.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * directionNormal))
		
		updateTarget()
	}
	
	func updateTarget()
	{		
		if target != nil {
			
			let shipNodePosition = CGPoint(x: CGFloat(capsule.at.x), y: CGFloat(capsule.at.y))
			let eventNodePosition = CGPoint(x: CGFloat(target.at.x), y: CGFloat(target.at.y))
			let distanceFromShip = Float(distanceBetweenTwoPoints(shipNodePosition,point2: eventNodePosition))
			
			if distanceFromShip > 2 {
				let angleTest = angleBetweenTwoPoints(capsule.at, point2: target.at, center: capsule.at)
				let targetDirectionNormal = Double(Float(angleTest)/180) * 1
				targetterFar.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * targetDirectionNormal))
				targetterFar.opacity = 1
			}
			else{
				targetter.position = SCNVector3(target.at.x - capsule.at.x,target.at.y - capsule.at.y,0)
				targetterFar.opacity = 0
			}
			
			if targetter.opacity == 1 { targetter.opacity = 0 }
			else{ targetter.opacity = 1 }
			
		}
	}

	func addTarget(event:Location)
	{
		target = event
		updateTarget()
		bang()
	}
	
	override func bang()
	{
		if output.connection == nil { return }
		if target == nil { return }
		output.connection.host.listen(target)
	}
	
	func removeTarget()
	{
		target = nil
	}
	
	func closestLocation(type:eventDetails) -> Location
	{
		var closestEvent:Location!
		for newEvent in universe.childNodes {
			let event = newEvent as! Location
			if closestEvent == nil { closestEvent = event }
			if event.details != type { continue }
			if event.distance > closestEvent.distance { continue }
			closestEvent = event
		}
		return closestEvent
	}
	
	override func listen(event: Event)
	{
		if event.type == eventTypes.map {
			for location in event.content {
				universe.addChildNode(location)
			}
			event.size = 0
			cargo.bang()
		}
		update()
	}
}