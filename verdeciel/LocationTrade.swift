import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationTrade : Location
{
	var wantPort:SCNPort!
	var wantLabel:SCNLabel!
	
	var givePort:SCNPort!
	var giveLabel:SCNLabel!
	
	var want:Event!
	var give:Event!
	
	var unlocked:Bool = false
	
	init(name:String = "",at: CGPoint = CGPoint(), want:Event,give:Event)
	{
		super.init(name: name, at: at)
		
		self.at = at
		self.size = size
		self.note = ""
		
		self.want = want
		self.give = give
		
		self.interaction = "trading"
		
		self.interface = panel()
	}
	
	override func _sprite() -> SCNNode
	{
		let size:Float = 0.1
		var spriteColor:UIColor = grey
		
		let spriteNode = SCNNode()
		
		if isKnown == true { spriteColor = white }
		else if isSeen == true { spriteColor = cyan }
		
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: spriteColor))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: spriteColor))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: spriteColor))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: spriteColor))
		
		return spriteNode
	}
	
	// MARK: Panels -
	
	override func update()
	{
		if givePort.event == nil {
			wantLabel.update("--", color:grey)
			giveLabel.update("--", color:grey)
			givePort.disable()
			wantPort.disable()
			return
		}
		if wantPort.origin != nil && wantPort.origin.event == wantPort.requirement {
			wantLabel.updateColor(white)
			giveLabel.updateColor(white)
			givePort.enable()
		}
		else{
			wantLabel.updateColor(grey)
			giveLabel.updateColor(grey)
			givePort.disable()
		}
	}
	
	override func panel() -> SCNNode
	{
		let newPanel = SCNNode()
		
		// Want
		let tradeWantLabel = SCNLabel(text: "Trade", color:grey)
		tradeWantLabel.position = SCNVector3(x: -1.5 + 0.3, y: 0.6, z: 0)
		newPanel.addChildNode(tradeWantLabel)
		
		wantPort = SCNPort(host: self)
		wantPort.position = SCNVector3(x: -1.5, y: 0.3, z: 0)
		wantPort.addRequirement(want)
		wantPort.enable()
		wantPort.input = eventTypes.item
		newPanel.addChildNode(wantPort)
		
		wantLabel = SCNLabel(text: want.name!, color:white)
		wantLabel.position = SCNVector3(x: -1.5 + 0.3, y: 0.3, z: 0)
		wantPort.output = eventTypes.item
		newPanel.addChildNode(wantLabel)
		
		// Give
		let tradeGiveLabel = SCNLabel(text: "for", color:grey)
		tradeGiveLabel.position = SCNVector3(x: -1.5 + 0.3, y: -0.2, z: 0)
		newPanel.addChildNode(tradeGiveLabel)
		
		givePort = SCNPort(host: self)
		givePort.position = SCNVector3(x: -1.5, y: -0.5, z: 0)
		givePort.event = give
		newPanel.addChildNode(givePort)
		
		giveLabel = SCNLabel(text: give.name!, color:grey)
		giveLabel.position = SCNVector3(x: -1.5 + 0.3, y: -0.5, z: 0)
		newPanel.addChildNode(giveLabel)
		
		givePort.disable()
		
		return newPanel
	}
	
	
	override func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		let radius:Float = 5
		let color:UIColor = red
		let sides:Int = 72
		let verticalOffset:Float = 8
		
		var i = 0
		while i < sides {
			let root = SCNNode()
			
			root.addChildNode(SCNLine(nodeA: SCNVector3(-radius,verticalOffset,0), nodeB: SCNVector3(0,verticalOffset/2,radius), color: color))
			
			let test = CGFloat(i * (360/sides))
			
			mesh.addChildNode(root)
			
			root.eulerAngles.y = Float(degToRad(test))
			
			i += 1
		}
		
		return mesh
	}
	
	override func animateMesh(mesh:SCNNode)
	{
		mesh.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.25)))
	}
	
	override func listen(event: Event)
	{
		if wantPort.origin == nil { return }
		update()
	}
	
	override func bang()
	{
		if givePort.connection == nil { print("No connection") ; return }
		if givePort.connection.host != cargo { print("Not routed to cargo") ; return }
		if givePort.event == nil { completeTrade() ; return }
		
		givePort.connection.host.listen(givePort.event)
		
		update()
	}

	func completeTrade()
	{
		if wantPort.origin != nil { wantPort.syphon() }
		if givePort.connection != nil {	givePort.disconnect() }
		
		givePort.event = nil
		update()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}