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

class SCNLabel : SCNNode
{
	init(text:String,scale:Float)
	{
		super.init()
		
		let textPivot = SCNNode()
		
		let characters = Array(text)
		
		var letterPos = 0
		for letterCur in characters
		{
			var letterNode = letter(String(letterCur),scale:scale)
			letterNode.position = SCNVector3(x: (scale * 1.5) * Float(letterPos), y: 0, z: 0)
			textPivot.addChildNode(letterNode)
			
			letterPos += 1
		}
		self.addChildNode(textPivot)
	}
	
	func letter(letter:String,scale:Float) -> SCNNode
	{		
		let letterPivot = SCNNode()
		letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: scale, z: 0)))
		
		if letter == "a"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "b"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "c"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "d"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "e"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
		}
		else if letter == "f"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
		}
		else if letter == "f"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
		}
		else if letter == "g"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
		}
		else if letter == "h"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "i"
		{
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)))
		}
		else if letter == "j"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
		}
		else if letter == "s"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			
		}
		else{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
//			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)))
			
		}

		return letterPivot
		
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}