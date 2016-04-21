//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

extension SCNNode
{
	func touch(id:Int = 0)
	{
		print("! This node has no touch action")
	}
	
	func update()
	{
	}
	
	func empty()
	{
		for node in childNodes {
			node.removeFromParentNode()
		}
	}
	
	func blink()
	{
		if game.time % 3 == 0 { opacity = 1 }
		else { opacity = 0 }
	}
	
	func show()
	{
		opacity = 1
	}
	
	func hide()
	{
		opacity = 0
	}
	
	func updateChildrenColors(color:UIColor)
	{
		for node in self.childNodes {
			node.color(color)
			node.updateChildrenColors(color)
		}
	}
	
	func color(color:UIColor)
	{
		if geometry == nil { return }
		if (self is SCNLine) == false { return }
		
		(self as! SCNLine).update(color)
	}
	
	// MARK: Events -
	
	func whenStart()
	{
		for node in childNodes {
			node.whenStart()
		}
	}
	
	func whenTime()
	{
		for node in childNodes {
			node.whenTime()
		}
	}
	
	func whenRenderer()
	{
		for node in childNodes {
			node.whenRenderer()
		}
	}
	
	// MARK: Triggers -
	
	func onConnect()
	{
		update()
	}
	
	func onDisconnect()
	{
		update()
	}
	
	func onUploadComplete()
	{
		
	}
	
	func onMissionComplete()
	{
	
	}
}