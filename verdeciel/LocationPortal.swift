import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationPortal : Location
{
	let destination:CGPoint!
	let sector:sectors!
	
	init(name:String,at: CGPoint,destination: CGPoint,sector:sectors = sectors.normal,color:UIColor = white)
	{
		self.destination = destination
		self.sector = sector
		
		super.init(name:name, at:at)
		
		self.at = at
		self.size = 1
		self.note = ""
		self.color = color
		self.mesh = structures.portal
	}
	
	override func _sprite() -> SCNNode
	{
		var size:Float = 0.1
		
		let spriteNode = SCNNode()
		
		if isKnown == true {
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
			
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0.075,y:0,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:-0.075,y:0,z:0),color: color))
			
			size = 0.05
			
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
		}
		else{
			size = 0.05
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
		}
		
		return spriteNode
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}