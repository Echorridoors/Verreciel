
//  Created by Devine Lu Linvega on 2015-12-15.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class WidgetRadio : Widget
{
	var time:NSTimer!
	var seek:Int = 0
	
	override init()
	{
		super.init()
		
		name = "radio"
		details = "[missing text]"
		requirement = ItemTypes.record
		isPowered = { battery.isRadioPowered() }
		
		label.update(name!)
	}
	
	func isPlaying() -> Bool
	{
		if port.hasItemOfType(.record) { return true }
		return false
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		
		battery.installRadio()
		player.lookAt(deg: 0)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}