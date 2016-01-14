
//  Created by Devine Lu Linvega on 2016-01-14.
//  Copyright © 2016 XXIIVV. All rights reserved.

import Foundation

class Mission
{
	var id:Int = 0
	var name:String = "Unknown"
	var isCompleted:Bool = false
	
	var quests:Array<Quest> = []
	var predicate:() -> Bool
	var result:() -> Void
	
	init(id:Int,name:String)
	{
		self.id = id
		self.name = name
	}
	
}