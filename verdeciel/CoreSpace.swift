//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreSpace: SCNNode
{
	var structuresRoot:SCNNode!
	var starsRoot:SCNNode!
	var starTimer:Float = 0
	
	override init()
	{
		super.init()
		
		structuresRoot = SCNNode()
		addChildNode(structuresRoot)
		
		starsRoot = SCNNode()
		addChildNode(starsRoot)
	}
	
	override func fixedUpdate()
	{
		if capsule.closestKnownLocation().system == Systems.cyanine { sceneView.backgroundColor = whiteTone }
		else { sceneView.backgroundColor = black }
		
		while starTimer > 2 {
			addStar()
			starTimer -= 2
		}
		
		// Orientation
		let targetDirectionNormal = Double(Float(capsule.direction)/180) * 1
		self.rotation = SCNVector4Make(0, 1, 0, Float(M_PI * targetDirectionNormal))
		
		// Stars
		
		var starSpeed = thruster.actualSpeed
		if capsule.isDocked == false && capsule.dock != nil { starSpeed = 0.3 }
		else{ starSpeed = thruster.actualSpeed }
		
		let lineSpeed = Float(starSpeed) / 6
		for node in starsRoot.childNodes
		{
			let line = node as! SCNLine
			line.position = SCNVector3(x: line.position.x, y: line.position.y - lineSpeed, z: line.position.z)
			line.updateHeight(starSpeed + 0.1)
			let distanceRatio = (50-line.position.distance(SCNVector3(0,0,0)))/50
			line.updateColor(UIColor(white: CGFloat(distanceRatio), alpha: 1))

			if line.position.y < -20 { line.removeFromParentNode() }
		}
		
		// Structures
		for instance in structuresRoot.childNodes{
			instance.update()
		}
	}
	
	func startInstance(location:Location)
	{
		print(location)
		print(location.mesh)
		structuresRoot.addChildNode(Instance(event: location))
	}
	
	func addStar()
	{
		if starsRoot.childNodes.count > 50 { return }
		
		var randX = Int(arc4random_uniform(40)) - 20
		var randZ = Int(arc4random_uniform(40)) - 20
		
		while( distanceBetweenTwoPoints(CGPoint(x: CGFloat(randX), y: CGFloat(randZ)), point2: CGPoint(x: 0, y: 0)) < 6 ){
			randX = Int(arc4random_uniform(40)) - 20
			randZ = Int(arc4random_uniform(40)) - 20
		}
		
		var color = white
		if capsule.sector == sectors.cyanine { color = black }
		if capsule.sector == sectors.vermiles { color = black }
		if capsule.sector == sectors.opal { color = black }
		if capsule.sector == sectors.void { color = grey }
		
		let newLine = SCNLine(nodeA: SCNVector3(x: Float(randX), y: 0, z: Float(randZ)), nodeB: SCNVector3(x: Float(randX), y: 1, z: Float(randZ)), color: color)
		newLine.position = SCNVector3(x: newLine.position.x, y: 45, z: newLine.position.z)
		starsRoot.addChildNode(newLine)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}