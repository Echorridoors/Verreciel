
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MonitorProgress : Monitor
{
	override init()
	{
		super.init()
		name = "progress"
		self.eulerAngles.x = Float(degToRad(templates.monitorsAngle))
		
		label.update("--")
		details.update(name!)
	}
	
	override func refresh()
	{
		label.update("4/39")
	}
	
	override func onInstallationBegin()
	{
//		player.lookAt(deg: -270)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}