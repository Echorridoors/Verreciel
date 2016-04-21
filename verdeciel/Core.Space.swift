//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreSpace: SCNNode
{
	var structuresRoot = SCNNode()
	var starsRoot = SCNNode()
	
	override init()
	{
		super.init()
		
		addChildNode(structuresRoot)
		addChildNode(starsRoot)
		
		starsRoot.position = SCNVector3(0,40,0)
	}
	
	// Space Color
	
	var targetSpaceColor:Array<CGFloat>!
	var currentSpaceColor:Array<CGFloat> = [0,0,0]
	var stars_color:UIColor = white
	
	func onSystemEnter(system:Systems)
	{
		print("Entering \(system)")
		capsule.system = system
		
		white = true_white
		black = true_black
		cyan = true_cyan
		red = true_red
		grey = true_grey
		
		switch system {
		case .valen  : targetSpaceColor = [0.2,0.2,0.2] ; stars_color = white
		case .nevic : targetSpaceColor = [0.0,0.0,0.0] ; stars_color = white
		case .senni  : targetSpaceColor = [0.0,0.0,0.0] ; stars_color = true_cyan
		case .usul   : targetSpaceColor = [0.3,0.3,0.3] ; stars_color = true_red
		default      : targetSpaceColor = [0.0,0.0,0.0] ; stars_color = white
		}
	}
	
	// Instances
	
	func startInstance(location:Location)
	{
		structuresRoot.addChildNode(location.structure)
	}
	
	var lastStarAddedTime:Float = 0
	
	override func whenTime()
	{
		super.whenTime()
		
		if starsRoot.childNodes.count < 100 && journey.distance > lastStarAddedTime + 0.5  {
			let randX = Float(Int(arc4random_uniform(40)) - 20)
			let randZ = Float(Int(arc4random_uniform(40)) - 20)
			starsRoot.addChildNode(star(SCNVector3(x:randX,y:0,z:randZ)))
			lastStarAddedTime = journey.distance
		}
		
		var starSpeed = thruster.actualSpeed
		if capsule.isDocked == false && capsule.dock != nil { starSpeed = 0.3 }
		else{ starSpeed = thruster.actualSpeed }
		
		starSpeed *= 0.25
		
		for star in starsRoot.childNodes as! [SCNLine] {
			star.update([star.vertices.first!,SCNVector3(star.vertices.first!.x,star.vertices.first!.y + starSpeed + 0.1,star.vertices.first!.z)])
		}
		
		// Background
		
		if currentSpaceColor[0] < targetSpaceColor[0] { currentSpaceColor[0] += 0.01 }
		if currentSpaceColor[0] > targetSpaceColor[0] { currentSpaceColor[0] -= 0.01 }
		if currentSpaceColor[1] < targetSpaceColor[1] { currentSpaceColor[1] += 0.01 }
		if currentSpaceColor[1] > targetSpaceColor[1] { currentSpaceColor[1] -= 0.01 }
		if currentSpaceColor[2] < targetSpaceColor[2] { currentSpaceColor[2] += 0.01 }
		if currentSpaceColor[2] > targetSpaceColor[2] { currentSpaceColor[2] -= 0.01 }
		
		sceneView.backgroundColor = UIColor(red: currentSpaceColor[0], green: currentSpaceColor[1], blue: currentSpaceColor[2], alpha: 1)
	}
	
	// Other
	
	override func whenRenderer()
	{
		super.whenRenderer()
		
		starsRoot.rotation = SCNVector4Make(0, 1, 0, (degToRad(capsule.direction)))
		
		// Update stars
		
		var starSpeed = thruster.actualSpeed
		if capsule.isDocked == false && capsule.dock != nil { starSpeed = 0.3 }
		else{ starSpeed = thruster.actualSpeed }
		
		starSpeed *= 0.25
		
		for star in starsRoot.childNodes as! [SCNLine] {
			star.position = SCNVector3(x: star.position.x, y: star.position.y - starSpeed, z: star.position.z)
			if star.position.y < -80 { star.removeFromParentNode() }
		}
	}
	
	func star(position:SCNVector3) -> SCNLine
	{
		return SCNLine(vertices: [position, SCNVector3(position.x,position.y + 1,position.z)], color: stars_color)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}