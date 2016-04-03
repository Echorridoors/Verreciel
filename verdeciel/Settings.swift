
//  Created by Devine Lu Linvega on 2015-10-09.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

// Panels
let battery = PanelBattery()
let pilot = PanelPilot()
let hatch = PanelHatch()
let mission = PanelMission()
let cargo = PanelCargo()
let thruster = PanelThruster()
let console = PanelConsole()
let radar = PanelRadar()
let above = PanelAbove()
let below = PanelBelow()

// Monitors
let journey = MonitorJourney()
let exploration = MonitorExploration()
let progress = MonitorProgress()
let complete = MonitorComplete()
let radio = WidgetRadio()
let map = WidgetMap()
let shield = WidgetShield()
let enigma = WidgetEnigma()

// Generic
var universe:CoreUniverse!
var capsule:CoreCapsule!
var player:CorePlayer!
var space:CoreSpace!
var helmet:Helmet!
var game:CoreGame!
var time:CoreTime!

// Collections
var quests = MissionLibrary()
var items = ItemLibrary()
var locations = LocationLibrary()
var recipes = RecipesLibrary()
var structures = StructuresLibrary()
var icons = IconsLibrary()

var templates = Templates()
var settings = Settings()
var debug = Debug()

// Colors

let true_black = UIColor(white: 0, alpha: 1)
let true_grey = UIColor(white: 0.5, alpha: 1)
let true_red = UIColor.redColor()
let true_cyan = UIColor(red: 0.44, green: 0.87, blue: 0.76, alpha: 1)
let true_white = UIColor(white: 1, alpha: 1)

var black:UIColor = true_black
var grey:UIColor = true_grey
var white:UIColor = true_white
var red:UIColor = true_red
var cyan:UIColor = true_cyan

var clear:UIColor = UIColor(white: 0, alpha: 0)

enum alignment
{
	case left
	case center
	case right
}

enum sectors
{
	case opal
	case cyanine
	case vermiles
	case normal
	case void
}

enum Systems
{
	case loiqe
	case valen
	case senni
	case usul
	case nevic
	
	case unknown
}

enum Chapters
{
	case primary
	case secondary
	case tertiary
}

enum ItemTypes
{
	case generic
	
	case fragment
	case battery
	case star
	case quest
	case waste

	case panel
	case key
	case currency
	
	case drive
	case cargo
	
	case shield
	case map
	case record
	case cypher
}

enum services
{
	case none
	case electricity
	case hull
	case neutralize
}

struct Templates
{
	var left:Float = 0
	var right:Float = 0
	var top:Float = 0
	var bottom:Float = 0
	
	var radius:Float = 0
	
	var margin:Float = 0
	var leftMargin:Float = 0
	var rightMargin:Float = 0
	var topMargin:Float = 0
	var bottomMargin:Float = 0
	
	var titlesAngle:CGFloat = 22
	var monitorsAngle:CGFloat = 47
	var warningsAngle:CGFloat = 44
	
	var lineSpacing:Float = 0.42
}

struct Settings
{
	var applicationIsReady:Bool = false
	var sight:CGFloat = 2.0
	var approach:CGFloat = 0.5
	var collision:CGFloat = 0.5
}

struct Debug
{
	var isActive:Bool = false
	var fixedUpdatedCount:Int = 0
}