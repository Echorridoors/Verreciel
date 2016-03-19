import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationPortal : Location
{
	var rightKeyPort:SCNPort!
	var rightThrusterPort:SCNPort!
	var rightPilotPort:SCNPort!
	var rightKeyLabel:SCNLabel!
	var rightThrusterLabel:SCNLabel!
	var rightPilotLabel:SCNLabel!
	
	var leftKeyPort:SCNPort!
	var leftThrusterPort:SCNPort!
	var leftPilotPort:SCNPort!
	var leftKeyLabel:SCNLabel!
	var leftThrusterLabel:SCNLabel!
	var leftPilotLabel:SCNLabel!
	
	var right:LocationPortal!
	var left:LocationPortal!
	var rightName:String!
	var leftName:String!
	
	var leftKey:Event!
	var rightKey:Event!
	
	init(name:String, system:Systems, at: CGPoint, leftKey: Event!, rightKey: Event!, leftName:String, rightName:String)
	{
		super.init(name:name,system:system, at:at)
		
		self.name = name
		self.type = .portal
		self.system = system
		self.at = at
		self.note = ""
		self.color = color
		self.structure = structures.portal()
		icon.replace(icons.portal())
		
		self.leftKey = leftKey
		self.rightKey = rightKey
		self.rightName = rightName
		self.leftName = leftName
		
		rightPilotPort = SCNPort(host: self, input: Event.self, output: Location.self)
		leftKeyPort = SCNPort(host: self, input: Item.self, output: Event.self)
		rightThrusterPort = SCNPort(host: self, input: Event.self, output: Location.self)
		rightKeyPort = SCNPort(host: self, input: Item.self, output: Event.self)
		leftPilotPort = SCNPort(host: self, input: Event.self, output: Location.self)
		leftThrusterPort = SCNPort(host: self, input: Event.self, output: Location.self)
		
		leftThrusterLabel = SCNLabel(text: "> Thruster", color:grey)
		leftPilotLabel = SCNLabel(text: "> Pilot", color:grey)
		leftKeyLabel = SCNLabel(text: "\(leftName) key",color:red)
		rightThrusterLabel = SCNLabel(text: "> Thruster", color:white)
		rightPilotLabel = SCNLabel(text: "> Pilot", color:white)
		rightKeyLabel = SCNLabel(text: "\(rightName) key",color:red)
		
		rightThrusterPort.addEvent(items.warpDrive)
		leftThrusterPort.addEvent(items.warpDrive)
		
		leftKeyPort.enable()
		leftKeyPort.requirement = leftKey
		
		rightKeyPort.enable()
		rightKeyPort.requirement = rightKey
	}
	
	// MARK: Panel - 
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		// Right
		
		let right = SCNNode()
		
		rightKeyPort.position = SCNVector3(templates.leftMargin + 0.9,0.6,0)
		right.addChildNode(rightKeyPort)
		
		rightKeyLabel.position = SCNVector3(0.4,0,0)
		rightKeyPort.addChildNode(rightKeyLabel)
		
		rightPilotPort.position = SCNVector3(templates.leftMargin + 0.9,0.2,0)
		right.addChildNode(rightPilotPort)
		
		rightPilotLabel.position = SCNVector3(0.4,0,0)
		rightPilotPort.addChildNode(rightPilotLabel)
		
		rightThrusterPort.position = SCNVector3(templates.leftMargin + 0.9,-0.2,0)
		right.addChildNode(rightThrusterPort)
		
		rightThrusterLabel.position = SCNVector3(0.4,0,0)
		rightThrusterPort.addChildNode(rightThrusterLabel)
		
		
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0,0), nodeB: SCNVector3(templates.leftMargin,0.6,0), color: grey))
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4,0,0), color: grey))
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.2,0.2,0), color: grey))
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.2,-0.2,0), color: grey))
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4 + 0.2,-0.2,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,-0.2,0), color: grey))
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4 + 0.2,0.2,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,0.2,0), color: grey))
		right.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0.6,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,0.6,0), color: grey))
		
		// Left
		
		let left = SCNNode()
		
		leftKeyPort.position = SCNVector3(templates.leftMargin + 0.9,0.6,0)
		left.addChildNode(leftKeyPort)
		
		leftKeyLabel.position = SCNVector3(0.4,0,0)
		leftKeyPort.addChildNode(leftKeyLabel)
		
		leftPilotPort.position = SCNVector3(templates.leftMargin + 0.9,0.2,0)
		left.addChildNode(leftPilotPort)
		
		leftPilotLabel.position = SCNVector3(0.4,0,0)
		leftPilotPort.addChildNode(leftPilotLabel)
		
		leftThrusterPort.position = SCNVector3(templates.leftMargin + 0.9,-0.2,0)
		left.addChildNode(leftThrusterPort)
		
		leftThrusterLabel.position = SCNVector3(0.4,0,0)
		leftThrusterPort.addChildNode(leftThrusterLabel)
		
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0,0), nodeB: SCNVector3(templates.leftMargin,0.6,0), color: grey))
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4,0,0), color: grey))
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.2,0.2,0), color: grey))
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4,0,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.2,-0.2,0), color: grey))
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4 + 0.2,-0.2,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,-0.2,0), color: grey))
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin + 0.4 + 0.2,0.2,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,0.2,0), color: grey))
		left.addChildNode(SCNLine(nodeA: SCNVector3(templates.leftMargin,0.6,0), nodeB: SCNVector3(templates.leftMargin + 0.4 + 0.4,0.6,0), color: grey))
		
		right.position = SCNVector3(0,0.5,0)
		left.position = SCNVector3(0,-0.9,0)
		
		newPanel.addChildNode(right)
		newPanel.addChildNode(left)
		
		return newPanel
	}
	
	// MARK: I/O
	
	override func onConnect()
	{
		print("! \(leftKeyPort.requirement.name) - \(rightKeyPort.requirement.name)")
	}
	
	override func listen(event: Event)
	{
		if leftKeyPort.origin != nil && leftKeyPort.origin.event == leftKeyPort.requirement {
			structure.replace(structures.portal(color:cyan))
		}
		if rightKeyPort.origin != nil && rightKeyPort.origin.event == rightKeyPort.requirement {
			structure.replace(structures.portal(color:cyan))
		}
		update()
	}
	
	override func onDock()
	{
		super.onDock()
		
		if leftKeyPort.isReceiving(leftKeyPort.requirement) == true || rightKeyPort.isReceiving(rightKeyPort.requirement) == true {
			structure.replace(structures.portal(color:cyan))
		}
	}
	
	override func update()
	{
		if leftKeyPort.isReceiving(leftKeyPort.requirement) == true {
			leftPilotPort.enable()
			leftThrusterPort.enable()
			leftKeyLabel.updateColor(cyan)
			leftPilotLabel.updateColor(white)
			leftThrusterLabel.updateColor(white)
		}
		else{
			leftPilotPort.disable()
			leftThrusterPort.disable()
			leftKeyLabel.updateColor(red)
			leftPilotLabel.updateColor(grey)
			leftThrusterLabel.updateColor(grey)
		}
		
		if rightKeyPort.isReceiving(rightKeyPort.requirement) == true {
			rightPilotPort.enable()
			rightThrusterPort.enable()
			rightKeyLabel.updateColor(cyan)
			rightPilotLabel.updateColor(white)
			rightThrusterLabel.updateColor(white)
		}
		else{
			rightPilotPort.disable()
			rightThrusterPort.disable()
			rightKeyLabel.updateColor(red)
			rightPilotLabel.updateColor(grey)
			rightThrusterLabel.updateColor(grey)
		}
	}
	
	func addPortals(right:LocationPortal,left:LocationPortal)
	{
		self.right = right
		self.left = left
		rightPilotPort.addEvent(right)
		leftPilotPort.addEvent(left)
	}
	
	func addKeys(right:Event,left:Event)
	{
		self.rightKeyPort.requirement = right
		self.leftKeyPort.requirement = left
	}
	
	override func disconnectPanel()
	{
		leftThrusterPort.strip()
		leftPilotPort.strip()
		leftKeyPort.strip()
		
		rightThrusterPort.strip()
		rightPilotPort.strip()
		rightKeyPort.strip()
	}
	
	// MARK: Mesh -
	
	override func animateMesh(mesh:SCNNode)
	{
		if leftKeyPort.isReceiving(leftKeyPort.requirement) == true || rightKeyPort.isReceiving(rightKeyPort.requirement) == true {
			mesh.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.1)))
		}
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}