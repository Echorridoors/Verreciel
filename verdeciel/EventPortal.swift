import UIKit
import QuartzCore
import SceneKit
import Foundation

class eventPortal : Event
{
	let destination:CGPoint!
	let sector:sectors!
	
	init(name:String,location: CGPoint,destination: CGPoint,sector:sectors = sectors.normal,color:UIColor = white)
	{
		self.destination = destination
		self.sector = sector
		
		super.init(newName:name, location:location, type:eventTypes.location)
		
		self.location = location
		self.size = 1
		self.details = ""
		self.note = ""
		self.color = color
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
	}
	
	override func collide()
	{
		thruster.warp(self.destination, sector:self.sector)
	}
	
	override func createSprite() -> SCNNode
	{
		var size:Float = 0.15
		
		let spriteNode = SCNNode()
		
		if isKnown == true {
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: color))
			
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0.075,y:0,z:0),color: color))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:-0.075,y:0,z:0),color: color))
			
			size = 0.075
			
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
	
	override func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		let color:UIColor = self.color
		
		var i = 0
		while i < 4 {
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(-3,i,0), nodeB: SCNVector3(0,i,3), color: color))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,i,3), nodeB: SCNVector3(3,i,0), color: color))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(3,i,0), nodeB: SCNVector3(0,i,-3), color: color))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,i,-3), nodeB: SCNVector3(-3,i,0), color: color))
			i += 1
		}
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,0,-3), nodeB: SCNVector3(0,1,-3), color: color))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,0,3), nodeB: SCNVector3(0,1,3), color: color))
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(3,1,0), nodeB: SCNVector3(3,2,0), color: color))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(-3,1,0), nodeB: SCNVector3(-3,2,0), color: color))
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,2,-3), nodeB: SCNVector3(0,3,-3), color: color))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,2,3), nodeB: SCNVector3(0,3,3), color: color))
		
		return mesh
	}
	
	override func sight()
	{
		updateSprite()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}