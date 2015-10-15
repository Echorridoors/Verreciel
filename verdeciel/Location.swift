import UIKit
import QuartzCore
import SceneKit
import Foundation

class Location : Event
{
	var service = services.none
	var interaction = "connected"
	
	var angle:CGFloat!
	var align:CGFloat!
	var distance:CGFloat!
	
	var inCollision:Bool = false
	var inApproach:Bool = false
	var inDiscovery:Bool = false
	var inSight:Bool = false
	
	var isVisible:Bool = false
	var isKnown:Bool = false
	var isTargetted:Bool = false
	
	var interface = Panel()
	
	init(name:String = "", at: CGPoint! = nil, service:services = services.none)
	{
		super.init(newName:name, at:at, type:eventTypes.location)

		self.at = at
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		addChildNode(sprite)
		addChildNode(trigger)
	}
	
	// MARK: System -
	
	override func start()
	{
		position = SCNVector3(at.x,at.y,0)
		
		sprite.empty()
		sprite.add(_sprite())
		
		position = SCNVector3(at.x,at.y,0)
		distance = distanceBetweenTwoPoints(capsule.at, point2: at)
		angle = calculateAngle()
		align = calculateAlignment()
	}
	
	override func fixedUpdate()
	{
		position = SCNVector3(at.x,at.y,0)
		distance = distanceBetweenTwoPoints(capsule.at, point2: at)
		angle = calculateAngle()
		align = calculateAlignment()
		
		if distance <= 2 { if inSight == false { sight() ; inSight = true } }
		else{ inSight = false }
		
		if distance <= 0.6 { approach() ; inApproach = true }
		else{ inApproach = false }
		
		if distance <= 0.01 { if inCollision == false { collide() ; inCollision = true } }
		else{ inCollision = false }
		
		radarCulling()
		clean()
	}
	
	func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		let radius:Float = 3
		let distance:Float = 4
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius,distance,0), nodeB: SCNVector3(0,distance,radius), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,distance,radius), nodeB: SCNVector3(radius,distance,0), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,distance,0), nodeB: SCNVector3(0,distance,-radius), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,distance,-radius), nodeB: SCNVector3(-radius,distance,0), color: white))

		return mesh
	}
	
	func radarCulling()
	{
		let verticalDistance = abs(capsule.at.y - at.y)
		let horizontalDistance = abs(capsule.at.x - at.x)
		
		if player.inRadar == true {
			self.opacity = 1
		}
		else if Float(verticalDistance) > highNode[0].y {
			self.opacity = 0
		}
		else if Float(horizontalDistance) > highNode[0].x {
			self.opacity = 0
		}
		else {
			self.opacity = 1
		}
		
		if connection != nil {
			if connection.opacity == 1 {
				wire.opacity = 1
			}
			else{
				wire.opacity = 0
			}
		}
	}

	// MARK: Events -
	
	func sight()
	{
		print("* EVENT    | Sighted \(self.name!)")
	}
	
	func discover()
	{
		print("* EVENT    | Discovered \(self.name!)")
		sprite.empty()
		sprite.add(_sprite())
	}
	
	func approach()
	{
//		print("* EVENT    | Approached \(self.name!)")
//		capsule.instance = self
//		space.startInstance(self)
//		player.activateEvent(self)
	}
	
	func collide()
	{
		print("* EVENT    | Collided \(self.name!)")
		capsule.dock(self)
	}
	
	func addService(service:services)
	{
		self.service = service
	}
	
	override func touch(id:Int)
	{
		if isKnown == true {
			print("touched: \(self.name!)")
			radar.addTarget(self)
		}
		else{
			print("event is unknown")
		}
	}
	
	func _sprite() -> SCNNode
	{
		var size = self.size/10
		size = 0.05
		let spriteNode = SCNNode()
		
		if isKnown == true {
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
		}
		else{
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
		}
		
		return spriteNode
	}
	
	func calculateAngle() -> CGFloat
	{
		let p1 = capsule.at
		let p2 = self.at
		let center = capsule.at
		
		let v1 = CGVector(dx: p1.x - center.x, dy: p1.y - center.y)
		let v2 = CGVector(dx: p2.x - center.x, dy: p2.y - center.y)
		
		let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
		
		return (360 - (radToDeg(angle) - 90)) % 360
	}
	
	func calculateAlignment(direction:CGFloat = capsule.direction) -> CGFloat
	{
		var diff = max(direction, self.angle) - min(direction, self.angle)
		if (diff > 180){ diff = 360 - diff }
		
		return diff
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}