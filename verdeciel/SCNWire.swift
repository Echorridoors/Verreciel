//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNWire : SCNNode
{
	var nodeA:SCNVector3!
	var nodeB:SCNVector3!
	var color:UIColor!
	
	var segment1 = SCNLine()
	var segment2 = SCNLine()
	var segment3 = SCNLine()
	var segment4 = SCNLine()
	var segment5 = SCNLine()
	
	var vertex1 = SCNVector3()
	var vertex2 = SCNVector3()
	var vertex3 = SCNVector3()
	var vertex4 = SCNVector3()
	
	var isEnabled:Bool = true
	var isActive:Bool = false
	
	init(nodeA: SCNVector3 = SCNVector3(), nodeB: SCNVector3 = SCNVector3())
	{
		super.init()
		
		self.nodeA = nodeA
		self.nodeB = nodeB
		
		addChildNode(segment1)
		addChildNode(segment2)
		addChildNode(segment3)
		addChildNode(segment4)
		addChildNode(segment5)
		
		color = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
		
		vertex1 = SCNVector3(nodeB.x * 0.2,nodeB.y * 0.2,nodeB.z * 0.2)
		vertex2 = SCNVector3(nodeB.x * 0.4,nodeB.y * 0.4,nodeB.z * 0.4)
		vertex3 = SCNVector3(nodeB.x * 0.6,nodeB.y * 0.6,nodeB.z * 0.6)
		vertex4 = SCNVector3(nodeB.x * 0.8,nodeB.y * 0.8,nodeB.z * 0.8)
		
		segment1.draw( nodeA, nodeB: vertex1, color: white)
		segment2.draw( vertex1, nodeB: vertex2, color: red)
		segment3.draw( vertex2, nodeB: vertex3, color: red)
		segment4.draw( vertex3, nodeB: vertex4, color: red)
		segment5.draw( vertex4, nodeB: nodeB, color: red)
	}
	
	override func fixedUpdate()
	{
		if isEnabled == false || nodeB == nil { return }
		if nodeA.x == nodeB.x && nodeA.y == nodeB.y && nodeA.z == nodeB.z { return }
		
		vertex1 = SCNVector3(nodeB.x * 0.2,nodeB.y * 0.2,nodeB.z * 0.2)
		vertex2 = SCNVector3(nodeB.x * 0.4,nodeB.y * 0.4,nodeB.z * 0.4)
		vertex3 = SCNVector3(nodeB.x * 0.6,nodeB.y * 0.6,nodeB.z * 0.6)
		vertex4 = SCNVector3(nodeB.x * 0.8,nodeB.y * 0.8,nodeB.z * 0.8)
		
		vertex1.y += sin((time.elapsed + vertex1.x + vertex1.y + vertex1.z)/20) * 0.05
		vertex2.y += sin((time.elapsed + vertex2.x + vertex2.y + vertex2.z)/20) * 0.08
		vertex3.y += sin((time.elapsed + vertex3.x + vertex3.y + vertex3.z)/20) * 0.08
		vertex4.y += sin((time.elapsed + vertex4.x + vertex4.y + vertex4.z)/20) * 0.05
		
		if isActive == true {
			segment1.draw( nodeA, nodeB: vertex1, color: cyan)
			segment2.draw( vertex1, nodeB: vertex2, color: white)
			segment3.draw( vertex2, nodeB: vertex3, color: white)
			segment4.draw( vertex3, nodeB: vertex4, color: white)
			segment5.draw( vertex4, nodeB: nodeB, color: red)
		}
		else{
			segment1.draw( nodeA, nodeB: vertex1, color: grey)
			segment2.draw( vertex1, nodeB: vertex2, color: grey)
			segment3.draw( vertex2, nodeB: vertex3, color: grey)
			segment4.draw( vertex3, nodeB: vertex4, color: grey)
			segment5.draw( vertex4, nodeB: nodeB, color: grey)
		}
	}
	
	func update(nodeA: SCNVector3 = SCNVector3(), nodeB: SCNVector3 = SCNVector3())
	{
		self.nodeA = nodeA
		self.nodeB = nodeB
		
		vertex1 = SCNVector3(nodeB.x * 0.2,nodeB.y * 0.2,nodeB.z * 0.2)
		vertex2 = SCNVector3(nodeB.x * 0.4,nodeB.y * 0.4,nodeB.z * 0.4)
		vertex3 = SCNVector3(nodeB.x * 0.6,nodeB.y * 0.6,nodeB.z * 0.6)
		vertex4 = SCNVector3(nodeB.x * 0.8,nodeB.y * 0.8,nodeB.z * 0.8)
		
		segment1.draw( nodeA, nodeB: vertex1, color: white)
		segment2.draw( vertex1, nodeB: vertex2, color: red)
		segment3.draw( vertex2, nodeB: vertex3, color: red)
		segment4.draw( vertex3, nodeB: vertex4, color: red)
		segment5.draw( vertex4, nodeB: nodeB, color: red)
	}
	
	func enable()
	{
		isEnabled = true
	}
	
	func disable()
	{
		isEnabled = false
		segment1.reset()
		segment2.reset()
		segment3.reset()
		segment4.reset()
		segment5.reset()
	}
	
	override func color(color: UIColor)
	{
		
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}