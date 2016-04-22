//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CorePlayer : SCNNode
{
	var canAlign:Bool = true
	
	var port:SCNPort!
	var event:Event!
	
	var trigger:SCNTrigger!
	var triggerLabel:SCNLabel!
	
	var isLocked:Bool = false
	
	override init()
	{
		super.init()
		
		self.camera = SCNCamera()
		self.camera?.xFov = 75
		self.name = "helmet"
		self.position = SCNVector3(x: 0, y: 0, z: 0)
		self.camera?.aperture = 100
		self.camera?.automaticallyAdjustsZRange = true
		
		port = SCNPort(host: self)
		port.enable()
		
		addInterface()
	}
	
	func addInterface()
	{
		trigger = SCNTrigger(host: self, size: CGSize(width: 2,height: 0.75))
		trigger.position = SCNVector3(x: 0, y: 0.9, z: -1.01)
		trigger.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0))
		trigger.hide()
		addChildNode(trigger)
		
		triggerLabel = SCNLabel(text: "return to capsule", scale: 0.03, align: alignment.center, color: red)
		triggerLabel.position = SCNVector3(0,0,0)
		trigger.addChildNode(triggerLabel)
	}
	
	func activateEvent(event:Event)
	{
		self.event = event
	}
	
	var accelX:Float = 0
	var accelY:Float = 0
	
	override func whenRenderer()
	{
		super.whenRenderer()
        
        if !isLocked {
            player.eulerAngles.x += accelX
            player.eulerAngles.y += accelY

            //should keep the values within 2pi rads
            player.eulerAngles.x = Float(Double(player.eulerAngles.x))
            player.eulerAngles.y = Float(Double(player.eulerAngles.y))

            //dampening
            // closer to 1 for more 'momentum'
            accelX *= 0.75
            accelY *= 0.75
            if abs(accelX) < 0.005 {
                accelX = 0; //if it gets too small just drop to zero
            }
            if abs(accelY) < 0.005 {
                accelY = 0; //if it gets too small just drop to zero
            }
        }
	}
	
	func lookAt(position:SCNVector3 = SCNVector3(0,0,0),deg:CGFloat)
	{
		let normalizedDeg = radToDeg(CGFloat(player.eulerAngles.y)) % 360
		player.eulerAngles.y = (degToRad(normalizedDeg))
		helmet.eulerAngles.y = (degToRad(normalizedDeg))
		
		print("+ PLAYER   | LookAt(from:\(radToDeg(CGFloat(player.eulerAngles.y))),to:\(deg))")
		
		player.isLocked = true
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		
		player.position = position
		player.eulerAngles.y = (degToRad(deg))
		helmet.position = position
		helmet.eulerAngles.y = (degToRad(deg))
		
		SCNTransaction.setCompletionBlock({ player.isLocked = false })
		SCNTransaction.commit()
		
		releaseHandle()
	}
	
	// MARK: Left Hand -
	
	var activePort:SCNPort!
	
	func holdPort(port:SCNPort)
	{
		if port.host != nil && port.host.name != nil { helmet.leftHandLabel.update("\(port.host!.name!)", color: white) }
		
		activePort = port
		port.activate()
	}
	
	func connectPorts(from:SCNPort,to:SCNPort)
	{
		helmet.leftHandLabel.update("--", color: grey)
		
		activePort = nil
		from.connect(to)
		from.desactivate()
		to.desactivate()
		from.update()
		to.update()
	}
	
	func releasePort()
	{
		helmet.leftHandLabel.update("--", color: grey)
		
		activePort.desactivate()
		activePort.disconnect()
		activePort = nil
	}
	
	// MARK: Right Hand -

	var activeHandle:SCNHandle!
	var handleTimer:NSTimer!
	
	func holdHandle(handle:SCNHandle)
	{
		releaseHandle()
		
		helmet.rightHandLabel.update(handle.host.name!, color: white)
		
		activeHandle = handle
		activeHandle.disable()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		player.position = activeHandle.destination
		helmet.position = activeHandle.destination
		SCNTransaction.commit()
		
		player.handleTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.releaseHandleAuto), userInfo: nil, repeats: false)
	}
	
	func releaseHandle()
	{
		helmet.rightHandLabel.update("--", color: grey)
		
		if activeHandle == nil { return }
		activeHandle.enable()
		activeHandle = nil
		
		if player.handleTimer != nil { player.handleTimer.invalidate() }
	}
	
	func releaseHandleAuto()
	{
		helmet.rightHandLabel.update("--", color: grey)
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		player.position = SCNVector3(0,0,0)
		helmet.position = SCNVector3(0,0,0)
		SCNTransaction.commit()
		
		activeHandle.enable()
		activeHandle = nil
	}
	
	override func onConnect()
	{
		if port.isReceivingFromPanel(map) == true { radar.modeOverview() }
	}
	
	override func onDisconnect()
	{
		if port.isReceivingFromPanel(map) != true { radar.modeNormal() }
	}
	
	// MARK: Default -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}