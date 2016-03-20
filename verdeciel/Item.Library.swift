
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class ItemLibrary
{
	// Capsule
	let playerCargo = Item(name: "player cargo", type: .cargo, note:"need description", isQuest:true)
	let starmap = Item(name: "starmap", type: .map, note:"route to helmet", isQuest:true)

	// Batteries
	let cell1  = Item(name: "cell", type: .battery, note:"gives little power", isQuest:true)
	let cell2  = Item(name: "cell", type: .battery, note:"gives little power", isQuest:true)
	let array1 = Item(name: "array", type: .battery, note:"gives medium power", isQuest:true)
	let array2 = Item(name: "array", type: .battery, note:"gives medium power", isQuest:true)
	let grid1 = Item(name: "grid", type: .battery, note:"gives large power", isQuest:true)
	let grid2 = Item(name: "grid", type: .battery, note:"gives large power", isQuest:true)
	let matrix1 = Item(name: "matrix I", type: .battery, note:"gives large power", isQuest:true)
	let matrix2 = Item(name: "matrix II", type: .battery, note:"gives large power", isQuest:true)
	
	// Misc
	let waste = Item(name: "waste", type: .waste, note:"useless junk")
	
	// Keys
	
	let loiqePortalKey = Item(name: "loiqe key", type: .key, note:"complete key", isQuest:true)
	
	let valenPortalKey = Item(name: "valen key", type: .key, note:"complete key", isQuest:true)
	let valenPortalFragment1 = Item(name: "valen key I", type: .fragment, note:"half a Portal key", isQuest:true)
	let valenPortalFragment2 = Item(name: "valen key II", type: .fragment, note:"half a Portal key", isQuest:true)
	
	let senniPortalKey = Item(name: "senni key", type: .key, note:"complete key", isQuest:true)
	let senniPortalFragment1 = Item(name: "senni key I", type: .fragment, note:"half a Portal key", isQuest:true)
	let senniPortalFragment2 = Item(name: "senni key II", type: .fragment, note:"half a Portal key", isQuest:true)
	
	let usulPortalKey = Item(name: "usul key", type: .key, note:"complete key", isQuest:true)
	let usulPortalFragment1 = Item(name: "Usul Key I", type: .fragment, note:"half a Portal key", isQuest:true)
	let usulPortalFragment2 = Item(name: "Usul Key II", type: .fragment, note:"half a Portal key", isQuest:true)
	
	let masterRedKey = Item(name: "Red Key", type: .key, note: "[missing]", isQuest: true)
	let masterCyanKey = Item(name: "Cyan Key", type: .key, note: "[missing]", isQuest: true)
	let masterWhiteKey = Item(name: "White Key", type: .key, note: "[missing]", isQuest: true)
	
	// Etc..
	
	let warpDrive = Item(name: "warpdrive", type: .drive, note:"local warpdrive", isQuest:true)
	
	// Records
	let record1 = Item(name: "record", type: .record, note:"an old audio tape", isQuest:true)
	let record2 = Item(name: "record", type: .record, note:"an old audio tape", isQuest:true)
	
	// Maps
	let map1 = Item(name: "Fog Map", type: .map, note: "[missing]", isQuest: true)
	let map2 = Item(name: "Ghost Map", type: .map, note: "[missing]", isQuest: true)
	
	// Enigma
	let cypher1 = Item(name: "cypher 1", type: .cypher, note:"[missing]", isQuest:true)
	let cypher2 = Item(name: "cypher 2", type: .cypher, note:"[missing]", isQuest:true)
	
	// Harvest
	let alta = Item(name: "alta", type: .currency, note:"trading currency")
	let credit = Item(name: "credit", type: .currency, note:"trading currency")
	let materia = Item(name: "materia", type: .currency, note:"trading currency")
	let mynir = Item(name: "mynir", type: .currency, note:"trading currency")
	let uli = Item(name: "uli", type: .currency, note:"trading currency")
	let natal = Item(name: "natal", type: .currency, note:"trading currency")
}