//
//  CoreUniverse.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-18.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreUniverse : SCNNode
{
	override init()
	{
		super.init()
		
		print("@ UNIVERSE | Init")
		
		self.addChildNode(eventPortal(location: CGPoint(x: 0.5,y: 0.5)))
		self.addChildNode(eventCargo(location: CGPoint(x: -0.25, y: 0.75)))
		
//		radar.addEvent(SCNEvent(newName: "tl", location: CGPoint(x: 0.5,y: 0.5), size: 0.5, type: eventTypes.location))
//		radar.addEvent(SCNEvent(newName: "tr", location: CGPoint(x: -0.5,y: 0.5), size: 0.5, type: eventTypes.location))
		
		//
		
		
//		radar.addEvent(SCNEvent(newName: "star", location: CGPoint(x: 4,y: 4), size: 1, type: eventTypes.location))
//		radar.addEvent(SCNEventNPC(newName: "test", location: CGPoint(x: 6,y: 0.5), size: 1.5,details:"test",note:"nothing"))
//		radar.addEvent(SCNEvent(newName: "a teapot", location: CGPoint(x: -0.5,y: -0.5), size: 1, type: eventTypes.item, details:"misc"))
		
//		radar.addEvent(SCNEvent(newName: "to cyanine", location: CGPoint(x: 0.5,y: -0.5), size: 1, type: eventTypes.portal, details:"portal", note:"universe warp"))
	}
	
	override func update()
	{
		for newEvent in self.childNodes {
			newEvent.update()
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}