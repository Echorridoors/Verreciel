//  Created by Devine Lu Linvega on 2015-07-17.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNOcta : SCNNode
{
	var line1:SCNLine!
	var line2:SCNLine!
	var line3:SCNLine!
	var line4:SCNLine!
	var line5:SCNLine!
	var line6:SCNLine!
	var line7:SCNLine!
	var line8:SCNLine!
	
	init(size:CGFloat, color:UIColor = white)
	{
		super.init()
		
		line1 = SCNLine(nodeA: SCNVector3(0,size,0), nodeB: SCNVector3(-size,0,size), color: color)
		self.addChildNode(line1)
		line2 = SCNLine(nodeA: SCNVector3(0,size,0), nodeB: SCNVector3(size,0,size), color: color)
		self.addChildNode(line2)
		line3 = SCNLine(nodeA: SCNVector3(0,size,0), nodeB: SCNVector3(-size,0,-size), color: color)
		self.addChildNode(line3)
		line4 = SCNLine(nodeA: SCNVector3(0,size,0), nodeB: SCNVector3(size,0,-size), color: color)
		self.addChildNode(line4)
		
		line5 = SCNLine(nodeA: SCNVector3(0,-size,0), nodeB: SCNVector3(-size,0,size), color: color)
		self.addChildNode(line5)
		line6 = SCNLine(nodeA: SCNVector3(0,-size,0), nodeB: SCNVector3(size,0,size), color: color)
		self.addChildNode(line6)
		line7 = SCNLine(nodeA: SCNVector3(0,-size,0), nodeB: SCNVector3(-size,0,-size), color: color)
		self.addChildNode(line7)
		line8 = SCNLine(nodeA: SCNVector3(0,-size,0), nodeB: SCNVector3(size,0,-size), color: color)
		self.addChildNode(line8)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}