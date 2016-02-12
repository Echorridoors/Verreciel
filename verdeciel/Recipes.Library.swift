//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class RecipesLibrary
{
	var horadric:Array<Recipe> = []
	
	init()
	{
		horadric.append( Recipe(name: "valen key", ingredients: [items.valenPortalFragment1, items.valenPortalFragment2], result: items.valenPortalKey) )
		horadric.append( Recipe(name: "senni key", ingredients: [items.senniPortalFragment1, items.senniPortalFragment2], result: items.senniPortalKey) )
		horadric.append( Recipe(name: "usul key", ingredients: [items.usulPortalFragment1, items.usulPortalFragment2], result: items.usulPortalKey) )
		
		// Battery
		horadric.append( Recipe(name: "array", ingredients: [items.cell1, items.cell2, items.cell3], result: items.array1) )
		horadric.append( Recipe(name: "grid", ingredients: [items.array1, items.array2, items.array3], result: items.grid1) )
		horadric.append( Recipe(name: "matrix", ingredients: [items.grid1, items.grid2, items.grid3], result: items.matrix1) )
		
		// Currencies
		horadric.append( Recipe(name: "alta", ingredients: [items.materia, items.materia], result: Item(name: "alta", type: .currency, note:"trading currency")) )
		horadric.append( Recipe(name: "ingot", ingredients: [items.credits, items.credits], result: Item(name: "ingot", type: .currency, note:"trading currency")) )
		horadric.append( Recipe(name: "mynir", ingredients: [items.materia, items.credits], result: Item(name: "mynir", type: .currency, note:"trading currency")) )
		horadric.append( Recipe(name: "uli", ingredients: [items.alta, items.ingot, items.mynir], result: Item(name: "uli", type: .currency, note:"trading currency")) )
	}
}