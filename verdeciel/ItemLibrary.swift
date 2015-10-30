//
//  ItemLibrary.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import Foundation

class ItemLibrary
{
	// Ship events
	let playerCargo = Event(newName: "player cargo", size: 1, type: eventTypes.cargo, details: itemTypes.panel, note:"need description", isQuest:true)
	
	// Quest items
	let loiqeLicense = Event(newName: "pilot license", size: 1, type: eventTypes.item, details: itemTypes.card, note:"required to undock$from loiqe city", isQuest:true)
	let cyanineKey = Event(newName: "Cyanine Key", size: 1, type: eventTypes.item, details: itemTypes.key, note:"unlocks the portal to cyanine", isQuest:true)
	
	// Radio Quest
	let radio = Event(newName: "radio", size: 1, type: eventTypes.panel, details: itemTypes.panel, note:"complete radio", isQuest:true)
	let radioPart1 = Event(newName: "radio antena", size: 1, type: eventTypes.item, details: itemTypes.part, note:"piece of radio", isQuest:true)
	let radioPart2 = Event(newName: "radio speaker", size: 1, type: eventTypes.item, details: itemTypes.part, note:"piece of radio", isQuest:true)
	
	// Batteries
	let cell = Event(newName: "cell", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives little power")
	let rack = Event(newName: "rack", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives average power")
	
	// Misc
	let waste = Event(newName: "waste", size: 3, type: eventTypes.item, details: itemTypes.waste, note:"useless junk")
}