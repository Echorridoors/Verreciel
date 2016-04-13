
//  Created by Devine Lu Linvega on 2016-02-17.
//  Copyright © 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationConstellation : Location
{
	override init(name:String = "", system:Systems, at:CGPoint = CGPoint(x: 0,y: 0))
	{
		super.init(name:name, system:system, at:at)
		
		self.note = ""
		self.structure = ConstellationTunnel(host:self)
		icon = IconConstellation()
		
		label.opacity = 0
	}
	
	override func onApproach()
	{
		print("* EVENT    | Approached \(self.name!)")
		space.startInstance(self)
		update()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconConstellation : Icon
{
	override init()
	{
		super.init()
		
		addChildNode(SCNLine(positions: [SCNVector3(x:0,y:size,z:0),  SCNVector3(x:size,y:0,z:0)],color: color))
		addChildNode(SCNLine(positions: [SCNVector3(x:size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0)],color: color))
		addChildNode(SCNLine(positions: [SCNVector3(x:0,y:-size,z:0),  SCNVector3(x:-size,y:0,z:0)],color: color))
		addChildNode(SCNLine(positions: [SCNVector3(x:-size,y:0,z:0),  SCNVector3(x:0,y:size,z:0)],color: color))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class ConstellationTunnel : Structure
{
	override init(host:Location)
	{
		super.init(host: host)
		
		let hex1 = SCNHexa(size: 6, color: grey)
		hex1.position = SCNVector3(0,0,2)
		root.addChildNode(hex1)
		let hex2 = SCNHexa(size: 6, color: grey)
		hex2.position = SCNVector3(0,0,0)
		root.addChildNode(hex2)
		let hex3 = SCNHexa(size: 6, color: grey)
		hex3.position = SCNVector3(0,0,-2)
		root.addChildNode(hex3)
		let hex4 = SCNHexa(size: 6, color: grey)
		hex4.position = SCNVector3(0,0,4)
		root.addChildNode(hex4)
		let hex5 = SCNHexa(size: 6, color: grey)
		hex5.position = SCNVector3(0,0,-4)
		root.addChildNode(hex5)
		
		root.eulerAngles.x = degToRad(90)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}