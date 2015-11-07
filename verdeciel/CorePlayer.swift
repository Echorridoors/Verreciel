//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CorePlayer : SCNNode
{
	var canAlign:Bool = true
	
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
	var activePort:SCNPort!
	var event:Event!
	var handle:SCNHandle!
	
	var trigger:SCNTrigger!
	var triggerLabel:SCNLabel!
	
	var isLocked:Bool = false
	var isConnectedToRadar = false
    
    var accelX:Float = 0;
    var accelY:Float = 0;
	
	override init()
	{
		health = 99
		magic = 99
		
		super.init()
		
		self.camera = SCNCamera()
		self.camera?.xFov = 75
		self.name = "cameraNode"
		self.position = SCNVector3(x: 0, y: 0, z: 0)
		self.camera?.aperture = 100
		self.camera?.automaticallyAdjustsZRange = true
		
		port = SCNPort(host: self, input: eventTypes.map, output: eventTypes.generic)
		port.enable()
		
		addInterface()
	}
	
	func addInterface()
	{
		trigger = SCNTrigger(host: self, size: CGSize(width: 2,height: 0.75))
		trigger.position = SCNVector3(x: 0, y: 0.9, z: -1.01)
		trigger.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0))
		trigger.opacity = 0
		addChildNode(trigger)
		
		triggerLabel = SCNLabel(text: "return to capsule", scale: 0.03, align: alignment.center, color: red)
		triggerLabel.position = SCNVector3(0,0,0)
		trigger.addChildNode(triggerLabel)
		
		alertLabel = SCNLabel(text: "", scale: 0.03, align: alignment.center)
		alertLabel.position = SCNVector3(x: 0, y: 1, z: -1.01)
		alertLabel.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		addChildNode(alertLabel)
		
		messageLabel = SCNLabel(text: "", scale: 0.03, align: alignment.center)
		messageLabel.position = SCNVector3(x: 0, y: 1.1, z: -1.01)
		messageLabel.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		addChildNode(messageLabel)
	}
	
	func activateEvent(event:Event)
	{
		self.event = event
	}
	
	func activatePort(port:SCNPort)
	{
		if port.isEnabled == false { return }
		
		// Select origin
		if activePort == nil {
			activePort = port
			port.activate()
			return
		}
		
		// Remove origin
		if activePort == port {
			port.desactivate()
			port.disconnect()
			activePort = nil
			return
		}
		
		// Connect
		activePort.connect(port)
		port.update()
		activePort.update()
		activePort = nil
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

	override func fixedUpdate()
	{
		flickerAlert()
        
        if !isLocked {
            player.eulerAngles.x += accelX
            player.eulerAngles.y += accelY

            //should keep the values within 2pi rads
            player.eulerAngles.x = Float(Double(player.eulerAngles.x) % (2 * M_PI))
            player.eulerAngles.y = Float(Double(player.eulerAngles.y) % (2 * M_PI))

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
		
		// Check is starmap is still connected
		if port.origin == nil && isConnectedToRadar == true {
			hideStarmap()
		}
	}
	
	func flickerAlert()
	{
		if alertIsActive == false { return }
		if alertLabel.opacity == 0 { alertLabel.opacity = 1}
		else{ alertLabel.opacity = 0 }
	}
	
	func lookAt(position:SCNVector3 = SCNVector3(0,0,0),deg:CGFloat)
	{
        player.eulerAngles.y = Float(Double(player.eulerAngles.y) % (2 * M_PI))
        //if degrees is more than zero. convert it to -360 - 0)
        //doing -360 - 0 because all of this functions inputs seem to be -deg
        if player.eulerAngles.y > 0 {
            player.eulerAngles.y = player.eulerAngles.y - Float(2 * M_PI)
        }
        //if it's less than -180, add 360 degrees
        if player.eulerAngles.y < -Float(M_PI) {
            player.eulerAngles.y += Float(2 * M_PI)
        }
        
        ui.eulerAngles.y = Float(Double(player.eulerAngles.y) % (2 * M_PI))
        //if degrees is more than zero. convert it to -360 - 0)
        if ui.eulerAngles.y > 0 {
            ui.eulerAngles.y = ui.eulerAngles.y - Float(2 * M_PI)
        }
        //if it's less than -180, add 360 degrees
        if ui.eulerAngles.y < -Float(M_PI) {
            ui.eulerAngles.y += Float(2 * M_PI)
        }
        
		player.isLocked = true
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		
		player.position = position
		player.eulerAngles.y = Float(degToRad(deg))
		ui.position = position
		ui.eulerAngles.y = Float(degToRad(deg))
		
		SCNTransaction.setCompletionBlock({ player.isLocked = false })
		SCNTransaction.commit()
		
		if handle != nil {
			handle.enable()
			handle = nil
		}
	}
	
	override func listen(event: Event)
	{
		if event == items.starmap {
			showStarmap()
		}
	}
	
	func showStarmap()
	{
		capsule.mesh.opacity = 0
		radar.decals.opacity = 0
		radar.header.opacity = 0
		radar.handle.opacity = 0
		thruster.opacity = 0
		pilot.opacity = 0
		isConnectedToRadar = true
	}
	
	func hideStarmap()
	{
		capsule.mesh.opacity = 1
		radar.decals.opacity = 1
		radar.header.opacity = 1
		radar.handle.opacity = 1
		thruster.opacity = 1
		pilot.opacity = 1
		isConnectedToRadar = false
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}