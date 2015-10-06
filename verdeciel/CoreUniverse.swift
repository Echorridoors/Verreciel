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
	var falvetToSenni = eventPath()
	var falvetTovalen = eventPath()
	var falvetToUsul = eventPath()
	
	var valenToVenic = eventPath()
	
	var entryToSenni = eventStation()
	var entryTovalen = eventStation()
	var entryToUsul = eventStation()
	var entryToVenic = eventStation()
	
	override init()
	{
		super.init()
		
		print("@ UNIVERSE | Init")
	
		// Starting zone
		falvetSystem(CGPoint(x: 0,y: 0))
		senniSystem(CGPoint(x: 0,y: 4))
		valenSystem(CGPoint(x: 4,y: 0))
		usulSystem(CGPoint(x: -4,y: 0))
		
		venicSystem(CGPoint(x: 4,y: -4))
		
		connectPaths()
	}
	
	func falvetSystem(offset:CGPoint)
	{
		let star = eventStar(name:"Falvet",location: CGPoint(x:offset.x,y:offset.y),color:red)
		
		falvetToUsul = eventPath(name:"landing",location: CGPoint(x:offset.x - 1.5,y:offset.y))
		falvetToSenni = eventPath(name:"landing",location: CGPoint(x:offset.x,y:offset.y + 1.5))
		falvetTovalen = eventPath(name:"landing",location: CGPoint(x:offset.x + 1.5,y:offset.y))
		let city4 = eventStation(name:"landing",location: CGPoint(x:offset.x,y:offset.y - 1.5), size: 0.5)
		
		let city5 = eventStation(name:"landing",location: CGPoint(x:offset.x - 1,y:offset.y + 1), size: 0.5)
		let city6 = eventStation(name:"landing",location: CGPoint(x:offset.x + 1,y:offset.y + 1), size: 0.5)
		let city7 = eventStation(name:"landing",location: CGPoint(x:offset.x + 1,y:offset.y - 1), size: 0.5)
		let city8 = eventStation(name:"landing",location: CGPoint(x:offset.x - 1,y:offset.y - 1), size: 0.5)
		
		self.addChildNode(falvetToUsul)
		self.addChildNode(falvetToSenni)
		self.addChildNode(falvetTovalen)
		self.addChildNode(city4)
		
		self.addChildNode(city5)
		self.addChildNode(city6)
		self.addChildNode(city7)
		self.addChildNode(city8)
		
		city5.connect(city6)
		city6.connect(city7)
		city7.connect(city8)
		city8.connect(city5)
		
		let beacon = eventBeacon(name: "beacon", location: CGPoint(x:offset.x,y:offset.y - 2))
		
		self.addChildNode(star)
		self.addChildNode(beacon)
	}
	
	
	func venicSystem(offset:CGPoint)
	{
		let star = eventStar(name:"venic",location: CGPoint(x:offset.x,y:offset.y))
		
		entryToVenic = eventStation(name:"Repair",location: CGPoint(x:offset.x,y:offset.y + 1), size: 0.5)
		
		let portal = eventPortal(name: "Portal", location: CGPoint(x:offset.x - 1,y:offset.y), destination:CGPoint(x:offset.x,y:offset.y))
		
		let beacon = eventBeacon(name: "beacon", location: CGPoint(x:offset.x + 1,y:offset.y))
		
		portal.connect(entryToVenic)
		beacon.connect(entryToVenic)
		
		self.addChildNode(entryToVenic)
		self.addChildNode(star)
		self.addChildNode(portal)
		self.addChildNode(beacon)
	}
	
	func usulSystem(offset:CGPoint)
	{
		let star = eventStar(name:"Usul",location: CGPoint(x:offset.x,y:offset.y))
		
		entryToUsul = eventStation(name:"Repair",location: CGPoint(x:offset.x + 1,y:offset.y), size: 0.5)
		
		let portal = eventPortal(name: "Portal", location: CGPoint(x:offset.x,y:offset.y - 1), destination:CGPoint(x:offset.x,y:offset.y))
		
		let beacon = eventBeacon(name: "beacon", location: CGPoint(x:offset.x,y:offset.y - 2))
		
		portal.connect(beacon)
		
		self.addChildNode(entryToUsul)
		self.addChildNode(star)
		self.addChildNode(portal)
		self.addChildNode(beacon)
	}
	
	func valenSystem(offset:CGPoint)
	{
		let star = eventStar(name:"valen",location: CGPoint(x:offset.x,y:offset.y))
		
		entryTovalen = eventStation(name:"Repair",location: CGPoint(x:offset.x - 1,y:offset.y), size: 0.5)
		valenToVenic = eventPath(name:"landing",location: CGPoint(x:offset.x,y:offset.y - 1))
		
		let city2 = eventStation(name:"landing",location: CGPoint(x:offset.x,y:offset.y + 1), size: 0.5)
		
		city2.connect(entryTovalen)
		
		self.addChildNode(entryTovalen)
		self.addChildNode(star)
		self.addChildNode(valenToVenic)
		self.addChildNode(city2)
	}

	func senniSystem(offset:CGPoint)
	{
		let star = eventStar(name:"Senni",location: CGPoint(x:offset.x,y:offset.y))
		let landing = eventStation(name:"landing",location: CGPoint(x:offset.x - 1,y:offset.y), size: 0.5)
		let repair = eventStation(name:"Repair",location: CGPoint(x:offset.x,y:offset.y + 1), size: 0.5)
		let portal = eventPortal(name: "Portal", location: CGPoint(x:offset.x + 1,y:offset.y), destination:CGPoint(x:offset.x,y:offset.y))
		let cargo2 = eventCargo(name: "cargo", location: CGPoint(x:offset.x + 1.5,y:offset.y))
		let gate = eventPortal(name: "Portal", location: CGPoint(x:offset.x,y:offset.y + 2), destination:CGPoint(x:offset.x,y:offset.y), sector: sectors.cyanine)
		
		let beacon = eventBeacon(name: "beacon", location: CGPoint(x:offset.x + 0.75,y:offset.y + 0.75))
		
		entryToSenni = eventStation(name: "cargo", location: CGPoint(x:offset.x,y:offset.y - 1), size:1)
		
		landing.connect(repair)
		repair.connect(portal)
		portal.connect(entryToSenni)
		entryToSenni.connect(landing)
		cargo2.connect(portal)
		
		gate.connect(repair)
		
		self.addChildNode(star)
		self.addChildNode(landing)
		self.addChildNode(repair)
		self.addChildNode(portal)
		self.addChildNode(cargo2)
		
		self.addChildNode(beacon)
		self.addChildNode(gate)
	}
	
	func connectPaths()
	{
		falvetToSenni.connect(entryToSenni)
		falvetTovalen.connect(entryTovalen)
		falvetToUsul.connect(entryToUsul)
		valenToVenic.connect(entryToVenic)
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