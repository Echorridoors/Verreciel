//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class RecipesLibrary
{
	var horadric:Array<Recipe> = []
	
	init()
	{
		horadric.append( Recipe(name: "loiqe key", ingredients: [items.loiqeKeyFragment1, items.loiqeKeyFragment2], result: items.loiqeKey) )
	}
}