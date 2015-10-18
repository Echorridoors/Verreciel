//
//  CameraNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//
import UIKit
import QuartzCore
import SceneKit
import Foundation

class CorePlayer : SCNNode
{
	var displayHealth:SCNLabel!
	var displayMagic:SCNLabel!
	
	var messageLabel:SCNLabel!
	var messageTimer:NSTimer!
	
	var alertLabel:SCNLabel!
	var alertTimer:NSTimer!
	var alertIsActive:Bool = false
	
	var health:Int
	var magic:Int
	
	var port:SCNPort!
	var event:Event!
	var handle:PanelHandle!
	
	var inRadar:Bool = false
	
	var trigger:SCNTrigger!
	var triggerLabel:SCNLabel!
	
	override init()
	{
		health = 99
		magic = 99
		
		super.init()
		
		// Camera
		self.camera = SCNCamera()
		self.camera?.xFov = 75
		self.name = "cameraNode"
		self.position = SCNVector3(x: 0, y: 0, z: 0)
		self.camera?.aperture = 100
		self.camera?.automaticallyAdjustsZRange = true
		
		addInterface()
		addHelmet()
	}
	
	override func bang()
	{
		leaveRadar()
	}
	
	func addHelmet()
	{
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: -0.8, y: -0.92, z: -1.01), nodeB: SCNVector3(x: -0.3, y: -1, z: -1.2), color: grey) )
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: 0.8, y: -0.92, z: -1.01), nodeB: SCNVector3(x: 0.3, y: -1, z: -1.2), color: grey) )
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: 0.25, y: -0.8, z: -1.01), nodeB: SCNVector3(x: 0.3, y: -1, z: -1.2), color: grey) )
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: -0.25, y: -0.8, z: -1.01), nodeB: SCNVector3(x: -0.3, y: -1, z: -1.2), color: grey) )
	}
	
	func addInterface()
	{
		displayHealth = SCNLabel(text: "99hp", scale: 0.05, align: alignment.left)
		displayHealth.position = SCNVector3(x: -0.7, y: -1, z: -1.01)
		displayHealth.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		addChildNode(displayHealth)
		
		displayMagic = SCNLabel(text: "34mp", scale: 0.05, align: alignment.right)
		displayMagic.position = SCNVector3(x: 0.7, y: -1, z: -1.01)
		displayMagic.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		addChildNode(displayMagic)
		
		alertLabel = SCNLabel(text: "", scale: 0.03, align: alignment.center)
		alertLabel.position = SCNVector3(x: 0, y: 1, z: -1.01)
		alertLabel.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		addChildNode(alertLabel)
		
		messageLabel = SCNLabel(text: "", scale: 0.03, align: alignment.center)
		messageLabel.position = SCNVector3(x: 0, y: 1.1, z: -1.01)
		messageLabel.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		addChildNode(messageLabel)
		
		// Button
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 2,height: 0.75))
		trigger.position = SCNVector3(x: 0, y: 0.9, z: -1.01)
		trigger.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0))
		trigger.opacity = 0
		addChildNode(trigger)
		
		triggerLabel = SCNLabel(text: "return to capsule", scale: 0.03, align: alignment.center, color: red)
		triggerLabel.position = SCNVector3(0,0,0)
		trigger.addChildNode(triggerLabel)
	}
	
	func activateEvent(event:Event)
	{
		self.event = event
	}
	
	func activatePort(port:SCNPort)
	{
		if self.port != nil {
			// Disconnect
			if self.port == port {
				self.port = nil
				port.disconnect()
				port.desactivate()
			}
			// New Connection
			else if self.port.polarity == true && port.polarity == false {
				self.port.connect(port)
				port.desactivate()
				self.port.desactivate()
				self.port = nil
				return
			}
		}
		else if port.polarity == true {
			// Select
			self.port = port
			self.port.activate()
		}
	}
	
	func desactivatePort()
	{
		self.port.desactivate()
	}
	
	func message(text:String)
	{
		messageLabel.update(text)
		messageTimer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: Selector("clearMessage"), userInfo: nil, repeats: false)
	}
	
	func clearMessage()
	{
		messageLabel.update("")
	}
	
	func alert(text:String)
	{
		alertIsActive = true
		alertLabel.update(text)
		alertTimer = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: Selector("clearAlert"), userInfo: nil, repeats: false)
	}
	
	func clearAlert()
	{
		alertIsActive = false
		alertTimer.invalidate()
		alertLabel.update("")
		alertLabel.opacity = 0
	}
	
	func enterRadar()
	{
		self.inRadar = true
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		
		player.position = SCNVector3(13,0,0)
		
		radar.eventPivot.position = SCNVector3(0,0,-14)
		radar.shipCursor.position = SCNVector3(0,0,-14)
		
		SCNTransaction.setCompletionBlock({ self.trigger.opacity = 1 })
		SCNTransaction.commit()
		
		for newEvent in universe.childNodes {
			let event = newEvent as! Event
			event.wire.opacity = 1
			event.opacity = 1
		}
	}
	
	func leaveRadar()
	{
		self.inRadar = false
		self.trigger.opacity = 0
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		
		player.position = SCNVector3(0,0,0)
		
		radar.eventPivot.position = SCNVector3(0,0,0)
		radar.shipCursor.position = SCNVector3(0,0,0)
		
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()

		for newEvent in universe.childNodes {
			let event = newEvent as! Event
			event.wire.opacity = 0
			event.opacity = 0
		}
	}
	
	override func fixedUpdate()
	{
		flickerAlert()
		
		player.eulerAngles.y += Float(degToRad(0.5))
	}
	
	func flickerAlert()
	{
		if alertIsActive == false { return }
		if alertLabel.opacity == 0 { alertLabel.opacity = 1}
		else{ alertLabel.opacity = 0 }
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}