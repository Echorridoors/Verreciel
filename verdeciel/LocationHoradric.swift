import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationHoradric : Location
{
	var inPort1:SCNPort!
	var inPort2:SCNPort!
	var inPort3:SCNPort!
	var inPort4:SCNPort!
	
	var outPort:SCNPort!
	var outLabel:SCNLabel!
	
	init(name:String = "",at: CGPoint = CGPoint())
	{
		super.init(name: name, at: at)
		
		self.at = at
		self.size = size
		self.note = ""
		self.mesh = structures.horadric()
		icon.replace(icons.unseen())
		
		self.interaction = "trading"
	}
	
	override func panel() -> SCNNode
	{
		let newPanel = SCNNode()
		let distance:CGFloat = 0.7
		
		inPort1 = SCNPort(host: self, input: eventTypes.item, output: eventTypes.none)
		inPort2 = SCNPort(host: self, input: eventTypes.item, output: eventTypes.none)
		inPort3 = SCNPort(host: self, input: eventTypes.item, output: eventTypes.none)
		inPort4 = SCNPort(host: self, input: eventTypes.item, output: eventTypes.none)
		
		inPort1.enable()
		inPort2.enable()
		inPort3.enable()
		inPort4.enable()
		
		inPort1.position = SCNVector3(0,distance,0)
		inPort2.position = SCNVector3(0,-distance,0)
		inPort3.position = SCNVector3(distance,0,0)
		inPort4.position = SCNVector3(-distance,0,0)
		
		outPort = SCNPort(host: self, input: eventTypes.item, output: eventTypes.generic)
		
		newPanel.addChildNode(inPort1)
		newPanel.addChildNode(inPort2)
		newPanel.addChildNode(inPort3)
		newPanel.addChildNode(inPort4)
		newPanel.addChildNode(outPort)
		
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0,0.125,0), nodeB: SCNVector3(0,distance - 0.125,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0,-0.125,0), nodeB: SCNVector3(0,-distance + 0.125,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0.125,0,0), nodeB: SCNVector3(distance - 0.125,0,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(-0.125,0,0), nodeB: SCNVector3(-distance + 0.125,0,0), color: grey))
		
		label = SCNLabel(text: "--", scale: 0.1, align: alignment.center, color: grey)
		label.position = SCNVector3(0,1.2,0)
		newPanel.addChildNode(label)
		
		return newPanel
	}
	
	override func listen(event: Event)
	{
		var ingredients:Array<Event> = []
		
		if inPort1.origin != nil && inPort1.origin.event != nil { ingredients.append(inPort1.origin.event) }
		if inPort2.origin != nil && inPort2.origin.event != nil { ingredients.append(inPort2.origin.event) }
		if inPort3.origin != nil && inPort3.origin.event != nil { ingredients.append(inPort3.origin.event) }
		if inPort4.origin != nil && inPort4.origin.event != nil { ingredients.append(inPort4.origin.event) }
		
		if ingredients.count < 2 { label.update("incompatible", color: grey) ; return }
		
		// Check for recipies
		
		for recipe in recipes.horadric {
			if recipe.isValid(ingredients) == true {
				label.update(recipe.name, color: white)
				outPort.event = recipe.result
				outPort.enable()
			}
		}
	}
	
	func iconUpdate()
	{
		if isKnown == false {
			icon.replace(icons.trade(grey))
		}
		else {
			icon.replace(icons.trade(white))
		}
	}
	
	override func bang()
	{
		if outPort.connection == nil { print("No connection") ; return }
		if outPort.event == nil { return }
		
		if inPort1.origin != nil { inPort1.addEvent(inPort1.syphon()) ; inPort1.removeEvent() }
		if inPort2.origin != nil { inPort2.addEvent(inPort2.syphon()) ; inPort2.removeEvent() }
		if inPort3.origin != nil { inPort3.addEvent(inPort3.syphon()) ; inPort3.removeEvent() }
		if inPort4.origin != nil { inPort4.addEvent(inPort4.syphon()) ; inPort4.removeEvent() }
		
		outPort.connection.host.listen(outPort.event)
	}
	
	// MARK: Icon -
	
	override func updateIcon()
	{
		if isSeen == false			{ icon.replace(icons.horadric(grey)) }
		else if isKnown == false	{ icon.replace(icons.horadric(white)) }
	}
	
	// MARK: Mesh -
	
	override func animateMesh(mesh:SCNNode)
	{
		for node in (mesh.childNodes.first?.childNodes)! {
			node.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.1)))
		}
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}