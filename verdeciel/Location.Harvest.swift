import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationHarvest : Location
{
	var grows:Item!
	var port:SCNPortSlot!
	
	init(name:String = "",system:Systems,at:CGPoint = CGPoint(x: 0,y: 0), grows:Item, mapRequirement:Item! = nil)
	{
		super.init(name:name, system:system, at:at)
		
		self.mapRequirement = mapRequirement
		self.note = ""
		structure = StructureHarvest()
		icon = IconHarvest()
		
		self.grows = grows
		
		port = SCNPortSlot(host: self, hasDetails:true, align:.center)
		port.position = SCNVector3(0,-0.5,0)
		port.enable()
		
		generationTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.generate), userInfo: nil, repeats: true)
	}
	
	override func start()
	{
		super.start()
		port.addEvent(grows)
	}
	
	var generationTimer:NSTimer!
	var generationCountdown:Int = 0
	var generationRate:Int = 20
	
	func generate()
	{
		if port == nil { return }
		if panelLabel == nil { return }
		
		if progress != nil {
			progress.update(((CGFloat(generationCountdown)/CGFloat(generationRate)) * 100))
		}
		
		if generationCountdown < generationRate && port.hasEvent(grows) == false {
			generationCountdown += 1
			
		}
		else {
			refresh()
			generationCountdown = 0
			port.addEvent(grows)
		}
		
		if port.hasEvent(grows) == true {
			panelLabel.update("\(self.grows.name!) production$Ready")
		}
		else{
			panelLabel.update("\(self.grows.name!) production$Time Left \(generationRate-generationCountdown)")
		}
	}
	
	var progress:SCNProgressBar!
	var panelLabel:SCNLabel!
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		panelLabel = SCNLabel(text: "\(self.grows.name!) production$Time Left 543", align:.left)
		panelLabel.position = SCNVector3(-1.5,1,0)
		newPanel.addChildNode(panelLabel)
		
		progress = SCNProgressBar(width: 3, color: cyan)
		progress.position = SCNVector3(-1.5,0,0)
		progress.update(30)
		
		newPanel.addChildNode(progress)
		newPanel.addChildNode(port)
		
		return newPanel
	}
	
	override func onUploadComplete()
	{
		refresh()
	}

	override func refresh()
	{
		if port.hasEvent(grows) != true {
			structure.updateChildrenColors(grey)
			icon.updateChildrenColors(grey)
		}
		else{
			structure.updateChildrenColors(cyan)
			icon.updateChildrenColors(white)
		}
	}
	
	override func details() -> String
	{
		return "\(grows.name!)"
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}


class IconHarvest : Icon
{
	override init()
	{
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class StructureHarvest : Structure
{
	let nodes:Int = 45
	
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		let color:UIColor = cyan
		let value1:Float = 7
		
		var i = 0
		while i < nodes {
			let node = SCNNode()
			node.eulerAngles.y = (degToRad(CGFloat(i * (360/nodes))))
			node.addChildNode(SCNLine(nodeA: SCNVector3(0,0,value1), nodeB: SCNVector3(0,5,value1), color: color))
			node.addChildNode(SCNLine(nodeA: SCNVector3(0,5,value1), nodeB: SCNVector3(0.5,5.5,value1), color: color))
			node.addChildNode(SCNLine(nodeA: SCNVector3(0,5,value1), nodeB: SCNVector3(-0.5,5.5,value1), color: color))
			root.addChildNode(node)
			i += 1
		}
	}
	
	override func onSight()
	{
		super.onSight()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
	}
	
	override func onDock()
	{
		super.onDock()
	}
	
	override func onComplete()
	{
		super.onComplete()
	}
	
	override func sightUpdate()
	{
		root.eulerAngles.y += (degToRad(0.1))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}