//
//  SCNCommand.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNInstance : SCNNode
{
	var event:SCNEvent!
	
	init(event:SCNEvent)
	{
		super.init()
		self.event = event
		
		self.geometry = SCNSphere(radius: 0.5)
		self.geometry?.firstMaterial?.doubleSided = true
		self.geometry?.firstMaterial?.diffuse.contents = red
		
		print("Begin instance : \(event.name!)")
	}
	
	override func update()
	{
		let distance = event.distanceFromCapsule * 15.0
		
		let newAngle = degToRad(abs(event.angleFromCapsule))
		
		let flattenedDistance = CGFloat(cos(newAngle)) * distance // important
		
		self.position = SCNVector3(0,flattenedDistance,0)
		
		
		
		if event.distanceFromCapsule > 1.5 {
			leaveInstance()
		}
	}
	
	func leaveInstance()
	{
		print("Leaving instance: \(self.event.name!)")
		capsule.instance = nil
		self.removeFromParentNode()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}