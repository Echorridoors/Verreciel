import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationTrade : Location
{
	var wantPort:SCNPortSlot!
	var givePort:SCNPortSlot!
	
	init(name:String = "", system:Systems, at: CGPoint = CGPoint(), want:Event,give:Event, mapRequirement:Item! = nil)
	{
		super.init(name: name,system:system, at: at)
		
		self.note = ""
		self.structure.addChildNode(structures.trade())
		self.isComplete = false
		self.mapRequirement = mapRequirement
		
		icon.replace(icons.trade())
		
		wantPort = SCNPortSlot(host: self, input:Item.self, output: Item.self)
		wantPort.addRequirement(want)
		wantPort.label.update("EMPTY", color:red)
		givePort = SCNPortSlot(host: self, input:Item.self, output: Item.self)
		givePort.addEvent(give)
	}
	
	// MARK: Panels -
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		let text = SCNLabel(text: "Trading \(wantPort.requirement.name!)$For \(givePort.event.name!)", align:.left)
		text.position = SCNVector3(-1.5,1,0)
		newPanel.addChildNode(text)
		
		// Want
		
		wantPort.position = SCNVector3(x: -1.2, y: -0.6, z: 0)
		wantPort.enable()
		wantPort.input = Item.self
		newPanel.addChildNode(wantPort)
		
		// Give
		givePort.position = SCNVector3(x:0, y: -0.5, z: 0)
		wantPort.addChildNode(givePort)
		
		wantPort.addChildNode(SCNLine(nodeA: SCNVector3(-0.125,0,0), nodeB: SCNVector3(-0.3,0,0), color: grey))
		wantPort.addChildNode(SCNLine(nodeA: SCNVector3(-0.3,0,0), nodeB: SCNVector3(-0.3,-0.5,0), color: grey))
		wantPort.addChildNode(SCNLine(nodeA: SCNVector3(-0.3,-0.5,0), nodeB: SCNVector3(-0.125,-0.5,0), color: grey))
		
		let wantLabel = SCNLabel(text: "Trade Table", color:grey)
		wantLabel.position = SCNVector3(x: -1.5, y: 0, z: 0)
		newPanel.addChildNode(wantLabel)
		
		givePort.disable()
		
		return newPanel
	}
	
	override func onUploadComplete()
	{
		refresh()
	}
	
	override func onDisconnect()
	{
		refresh()
	}
	
	override func refresh()
	{
		if wantPort.event != nil && wantPort.event.name == wantPort.requirement.name {
			wantPort.disable()
			wantPort.label.update("Accepted",color:cyan)
			givePort.enable()
			givePort.label.update(white)
		}
		else{
			wantPort.enable()
			wantPort.label.update("Refused",color:red)
			givePort.disable()
		}
		
		if givePort.event == nil {
			mission.complete()
			self.complete()
		}
		
		updateIcon()
	}
	
	override func complete()
	{
		super.complete()
		structure.empty()
		structure.add(structures.trade(color:cyan))
	}
	
	// MARK: Mesh -
	
	override func animateMesh()
	{
		super.animateMesh()
		
		structure.eulerAngles.y += Float(degToRad(0.1))
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}