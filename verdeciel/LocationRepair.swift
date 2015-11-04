import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationRepair : Location
{
	init(name:String = "",at: CGPoint = CGPoint())
	{
		super.init(name: name, at: at)
		
		self.at = at
		self.size = size
		self.note = ""
		self.mesh = structures.placeholder
		icon.replace(icons.placeholder())
		
		self.interaction = "repairing"
	}
	
	override func panel() -> Panel
	{
		let newPanel = Panel()
		return newPanel
	}
	
	override func listen(event: Event)
	{
		
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}