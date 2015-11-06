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
	
	var isRadioQuest:Bool = false
	
	var isTargetted:Bool = false
	var isKnown:Bool = false
	var isSeen:Bool = false
	var isSelected:Bool = false
	var isComplete:Bool = false
	
	var interface = SCNNode()
	
	var label = SCNLabel()
	
	var trigger = SCNNode()
	var wire:SCNLine!
	var connection:Event!
	
	var mesh:SCNNode!
	var icon = SCNNode()
	
	init(name:String = "", at: CGPoint! = nil)
	{
		super.init(newName:name, at:at, type:eventTypes.location)

		self.at = at
		
		geometry = SCNPlane(width: 0.5, height: 0.5)
		geometry?.firstMaterial?.diffuse.contents = clear
		
		addChildNode(trigger)
		addChildNode(icon)
		
//		icon.geometry = SCNPlane(width: 0.5, height: 0.5)
//		icon.geometry?.firstMaterial?.diffuse.contents = red
		
		label = SCNLabel(text: "", scale: 0.06, align: alignment.center, color: grey)
		label.position = SCNVector3(0,-0.3,-0.35)
		self.addChildNode(label)
		
		wire = SCNLine()
		wire.position = SCNVector3(0,0,-0.01)
		wire.opacity = 0
		self.addChildNode(wire)
	}
	
	// MARK: System -
	
	override func start()
	{		
		position = SCNVector3(at.x,at.y,0)
		distance = distanceBetweenTwoPoints(capsule.at, point2: at)
		angle = calculateAngle()
		align = calculateAlignment()
	}
	
	func setup()
	{
	
	}
	
	override func fixedUpdate()
	{
		position = SCNVector3(at.x,at.y,0)
		distance = distanceBetweenTwoPoints(capsule.at, point2: at)
		angle = calculateAngle()
		align = calculateAlignment()
		
		if distance <= settings.sight { if inSight == false { onSight() ; inSight = true ; isSeen = true } ; sightUpdate() }
		else{ inSight = false }
		
		if distance <= settings.approach { if inApproach == false { inApproach = true ; onApproach() } ; approachUpdate() }
		else{ inApproach = false }
		
		if distance <= settings.collision { if inCollision == false {  inCollision = true ; onCollision() } ; collisionUpdate() }
		else{ inCollision = false }
		
		if capsule.isDocked == true && capsule.dock == self { dockedUpdate() }
		
		radarCulling()
		clean()
	}
	
	override func lateUpdate()
	{
		
	}
	
	func updateIcon()
	{
	
	}
	
	func onSight()
	{
		print("* EVENT    | Sighted \(self.name!)")
		isSeen = true
		update()
		updateIcon()
		label.update(name!)
	}
	
	func onApproach()
	{
		print("* EVENT    | Approached \(self.name!)")
		space.startInstance(self)
		capsule.dock(self)
		update()
	}
	
	func onCollision()
	{
		print("* EVENT    | Collided \(self.name!)")
		update()
	}
	
	func onDock()
	{
		print("* EVENT    | Docked at \(self.name!)")
		isKnown = true
		update()
	}
	
	func sightUpdate()
	{
		
	}
	
	func approachUpdate()
	{
		
	}
	
	func collisionUpdate()
	{
		
	}
	
	func dockedUpdate()
	{
		
	}
	
	func animateMesh(mesh:SCNNode)
	{
		
	}
	
	func radarCulling()
	{
		let verticalDistance = abs(capsule.at.y - at.y)
		let horizontalDistance = abs(capsule.at.x - at.x)
		
		if Float(verticalDistance) > templates.topMargin {
			self.opacity = 0
		}
		else if Float(horizontalDistance) > templates.right {
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
		
		if isRadioQuest == true {
			opacity = 0
			if radar.port.origin != nil && radar.port.origin.event != nil && radar.port.origin.event == self { opacity = 1 }
		}
		
		if player.isConnectedToRadar == true {
			self.opacity = 1
			wire.opacity = 1
		}
	}
	
	func connect(event:Event)
	{
		connection = event
		self.wire.draw(SCNVector3(0,0,0), nodeB: SCNVector3( (connection.at.x - self.at.x),(connection.at.y - self.at.y),0), color: grey)
	}

	// MARK: Events -
	
	override func touch(id:Int)
	{
		if isSeen == false { return }
		
		if radar.port.event == nil {
			radar.addTarget(self)
		}
		else if radar.port.event == self {
			radar.removeTarget()
		}
		else{
			radar.addTarget(self)
		}
	}

	func disconnectPanel()
	{
		
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
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}