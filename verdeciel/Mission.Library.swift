
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MissionLibrary
{
	var active:Chapters = Chapters.discovery
	var questlog:Dictionary<Chapters,Array<Mission>> = [Chapters:Array]()
	var currentMission:Dictionary<Chapters,Mission> = [Chapters:Mission]()
	
	init()
	{
		questlog[Chapters.discovery] = []
		questlog[Chapters.capsule] = []
		questlog[Chapters.exploration] = []
		
		create_discoveryMissions()
		create_capsuleMissions()
		create_explorationMissions()
		
		currentMission[.discovery] = questlog[.discovery]?.first
		currentMission[.capsule] = questlog[.capsule]?.first
		currentMission[.exploration] = questlog[.exploration]?.first
	}
	
	func create_discoveryMissions()
	{
		let c:Chapters = .discovery
		var m:Mission!
		
		// Loiqe
		
		m = Mission(id:(questlog[c]?.count)!, name: "Flight Lesson")
		m.quests = [
			Quest(name:"Route cell to thruster", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { thruster.install() }),
			Quest(name:"Undock with thruster", predicate:{ capsule.dock != universe.loiqe_spawn && universe.loiqe_spawn.isKnown == true }, result: { mission.install() }),
			Quest(name:"Wait for arrival", predicate:{ universe.loiqe_landing.isKnown == true }, result: { cargo.install() }),
			Quest(name:"Route materia to cargo", predicate:{ cargo.contains(items.materia) }, result: { console.install() }),
			Quest(name:"Route cargo to console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }),
			Quest(name:"Undock from Landing", predicate:{ capsule.dock != universe.loiqe_landing && universe.loiqe_landing.isKnown == true }, result: { radar.install() }),
			Quest(name:"Dock at city", predicate:{ universe.loiqe_city.isKnown == true }, result: { })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Valen Portal Key")
		m.quests = [
			Quest(name:"Trade materia for fragment", location: universe.loiqe_city, predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { pilot.install() }),
			Quest(name:"Route radar to pilot", predicate:{ radar.port.connection != nil && radar.port.connection == pilot.port }, result: {  }),
			Quest(name:"Collect second fragment", location: universe.loiqe_satellite, predicate:{ cargo.contains(items.valenPortalFragment2) == true }, result: { }),
			Quest(name:"Combine fragments at Horadric", location: universe.loiqe_horadric,  predicate:{ (cargo.contains(items.valenPortalKey) == true) }, result: { })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Portal Lesson")
		m.quests = [
			Quest(name:"Unlock portal", location: universe.loiqe_portal, predicate:{ universe.loiqe_portal.rightKeyPort.isReceiving(items.valenPortalKey) == true }, result: { universe.unlock(.valen) }),
			Quest(name:"Align to portal", location: universe.loiqe_portal, predicate:{ pilot.port.isReceiving(universe.valen_portal) == true }, result: {  }),
			Quest(name:"Power Thruster", location: universe.loiqe_portal, predicate:{ thruster.port.isReceiving(items.warpDrive) == true }, result: {  }),
		]
		questlog[c]?.append(m)
		
		// Valen
		
		m = Mission(id:(questlog[c]?.count)!, name: "Reach Valen")
		m.quests = [
			Quest(name:"Warp to Valen system", location: universe.loiqe_portal, predicate:{ universe.valen_portal.isKnown == true }, result: { universe.unlock(.valen) })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Senni Portal Key")
		m.predicate = { cargo.contains(items.senniPortalKey) == true }
		m.quests = [
			Quest(name:"Route Radio to Radar", location: universe.valen_station, predicate:{ radar.port.origin != nil && radar.port.origin == radio.port }, result: {  }),
			Quest(name:"Collect portal fragment", location: universe.valen_port, predicate:{ cargo.contains(items.senniPortalFragment1) }, result: { }),
			Quest(name:"Find Alta recipe", location: universe.valen_beacon, predicate:{ universe.valen_beacon.isKnown == true }, result: { }),
			Quest(name:"Locate stealth port", location: universe.loiqe_city, predicate:{ universe.loiqe_port.isKnown == true }, result: { }),
			Quest(name:"Trade alta for fragment", location: universe.loiqe_port, predicate:{ cargo.contains(items.senniPortalFragment2) }, result: { }),
			Quest(name:"Combine fragments at horadric", location: universe.loiqe_horadric, predicate:{ cargo.contains(items.senniPortalKey) }, result: { }),
		]
		questlog[c]?.append(m)
	}
	
	func create_capsuleMissions()
	{
		let c:Chapters = .capsule
		var m:Mission!
		
		// Radio
		
		m = Mission(id:(questlog[c]?.count)!, name: "Install Radio")
		m.predicate = { radio.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
			Quest(name:"Collect credits", location: universe.valen_harvest, predicate:{ cargo.contains("credits", type: .currency) }, result: { }),
			Quest(name:"Install radio", location: universe.valen_station, predicate:{ m.predicate() }, result: { })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Radio Tutorial 1") // Input
		m.quests = [ Quest(name:"Power radio in battery panel", predicate:{ battery.isRadioPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route record to radio", predicate:{ radio.isPlaying == true }, result: {  }) ]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Radio Tutorial 2") // Output
		m.quests = [ Quest(name:"Power radio in battery panel", predicate:{ battery.isRadioPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route radio to radar", location: universe.valen_station, predicate:{ radar.port.origin != nil && radar.port.origin == radio.port }, result: {  }) ]
		questlog[c]?.append(m)
		
		// Map
		
		m = Mission(id:(questlog[c]?.count)!, name: "Install Map")
		m.predicate = { map.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
			Quest(name:"Collect credits", location: universe.valen_harvest, predicate:{ cargo.contains("credits", type: .currency) }, result: { }),
			Quest(name:"Install map", location: universe.senni_station, predicate:{ m.predicate() }, result: { })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Map Tutorial 1") // TODO: Add input tutorial
		m.quests = [ Quest(name:"Power map in battery panel", predicate:{ battery.isMapPowered() == true }, result: { }) ]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Map Tutorial 2") // Input
		m.quests = [ Quest(name:"Power map in battery panel", predicate:{ battery.isMapPowered() == true }, result: { }) ]
		m.quests = [ Quest(name:"Route map to helmet", predicate:{ player.port.origin != nil && player.port.origin == map.port }, result: {  }) ]
		questlog[c]?.append(m)
		
		// Shield
		
		m = Mission(id:(questlog[c]?.count)!, name: "Install Shield")
		m.predicate = { shield.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
			Quest(name:"Collect credits", location: universe.valen_harvest, predicate:{ cargo.contains("credits", type: .currency) }, result: { }),
			Quest(name:"Install shield", location: universe.usul_station, predicate:{ m.predicate() }, result: { }),
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Shield Tutorial 1") // Input
		m.quests = [ Quest(name:"Power shield in battery panel", predicate:{ battery.isShieldPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route shape to shield", predicate:{ shield.isActive == true }, result: { }) ]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Shield Tutorial 2") // TODO: Add output tutorial
		m.quests = [ Quest(name:"Power shield in battery panel", predicate:{ battery.isShieldPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route shape to shield", predicate:{ shield.isActive == true }, result: { }) ]
		questlog[c]?.append(m)
		
		// Enigma
		
		m = Mission(id:(questlog[c]?.count)!, name: "Install Enigma")
		m.predicate = { enigma.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.cypher1.name!)", location: universe.usul_satellite, predicate:{ cargo.contains(items.cypher1) }, result: {  }),
			Quest(name:"Collect \(items.uli.name!)", predicate:{ cargo.contains("uli", type: .currency) }, result: { }),
			Quest(name:"Install enigma", location: universe.usul_station, predicate:{ m.predicate() }, result: { }),
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Enigma Tutorial 1") // Input
		m.quests = [ Quest(name:"Power Enigma in battery panel", predicate:{ battery.isEnigmaPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route cypher to Enigma", predicate:{ enigma.isActive == true }, result: { }) ]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Enigma Tutorial 2") // TODO: Add output tutorial
		m.quests = [ Quest(name:"Power Enigma in battery panel", predicate:{ battery.isEnigmaPowered() == true }, result: {  }) ]
		questlog[c]?.append(m)
	}
	
	func create_explorationMissions()
	{
		let c:Chapters = .exploration
		var m:Mission!
		
		// Valen
		
		m = Mission(id:(questlog[c]?.count)!, name: "Valen Portal Key")
		m.predicate = { cargo.contains(items.valenPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire fragment I", location: universe.loiqe_city, predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { }),
			Quest(name:"Aquire fragment II", location: universe.loiqe_satellite, predicate:{ cargo.contains(items.valenPortalFragment2) == true }, result: {  }),
			Quest(name:"Combine fragments at Horadric", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Reach Valen")
		m.predicate = { universe.valen_portal.isKnown == true }
		m.quests = [ Quest(name:"Warp to Valen", location: universe.loiqe_portal, predicate:{ m.predicate() }, result: { }) ]
		questlog[c]?.append(m)
		
		// Senni
		
		m = Mission(id:(questlog[c]?.count)!, name: "Senni Portal Key")
		m.predicate = { cargo.contains(items.senniPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire fragment I", location: universe.valen_port, predicate:{ cargo.contains(items.senniPortalFragment1) == true }, result: { }),
			Quest(name:"Aquire fragment II", location: universe.loiqe_port, predicate:{ cargo.contains(items.senniPortalFragment2) == true }, result: {  }),
			Quest(name:"Combine fragments at Horadric", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Reach Senni")
		m.predicate = { universe.senni_portal.isKnown == true }
		m.quests = [ Quest(name:"Warp to Senni", location: universe.usul_portal, predicate:{ m.predicate() }, result: { }) ]
		questlog[c]?.append(m)
		
		// Usul
		
		m = Mission(id:(questlog[c]?.count)!, name: "Usul Portal Key")
		m.predicate = { cargo.contains(items.usulPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire fragment I", location: universe.senni_port, predicate:{ cargo.contains(items.usulPortalFragment1) == true }, result: { }),
			Quest(name:"Aquire fragment II", location: universe.venic_port, predicate:{ cargo.contains(items.usulPortalFragment2) == true }, result: {  }),
			Quest(name:"Combine fragments at Horadric", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Reach Usul")
		m.predicate = { universe.usul_portal.isKnown == true }
		m.quests = [ Quest(name:"Warp to Usul", location: universe.loiqe_portal, predicate:{ m.predicate() }, result: { }) ]
		questlog[c]?.append(m)
		
		// Trans Portal
		
		m = Mission(id:(questlog[c]?.count)!, name: "Trans Portal Key")
		m.predicate = { cargo.contains(items.transPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire Loiqe Key", predicate:{ cargo.contains(items.loiqePortalKey) == true }, result: { }),
			Quest(name:"Aquire Valen Key", predicate:{ cargo.contains(items.valenPortalKey) == true }, result: { }),
			Quest(name:"Aquire Senni Key", predicate:{ cargo.contains(items.senniPortalKey) == true }, result: { }),
			Quest(name:"Aquire Usul Key", predicate:{ cargo.contains(items.usulPortalKey) == true }, result: { }),
			Quest(name:"Combine all keys at Horadric", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[c]?.append(m)
	}
	
	func refresh()
	{
		currentMission[.discovery]?.validate()
		if currentMission[.discovery]?.isCompleted == true {
			let nextMissionId = currentMission[.discovery]!.id + 1
			currentMission[.discovery] = questlog[.discovery]![nextMissionId]
		}
		
		currentMission[.capsule]?.validate()
		if currentMission[.capsule]?.isCompleted == true {
			let nextMissionId = currentMission[.capsule]!.id + 1
			currentMission[.capsule] = questlog[.capsule]![nextMissionId]
		}
		
		currentMission[.exploration]?.validate()
		if currentMission[.exploration]?.isCompleted == true {
			let nextMissionId = currentMission[.exploration]!.id + 1
			currentMission[.exploration] = questlog[.exploration]![nextMissionId]
		}
		
		mission.update()
	}
	
	func setActive(chapter:Chapters)
	{
		active = chapter
	}
}




