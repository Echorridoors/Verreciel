//
//  LocationLibrary.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit

class LocationLibrary
{
	func loiqe(at:CGPoint) -> LocationStar
	{
		let location = LocationStar(name:"Loiqe")
		location.at = at
		return location
	}
	
	func loiqeCity(at:CGPoint) -> LocationTrade
	{
		let location = LocationTrade(name: "Loiqe City", want:itemLibrary.loiqeLicense, give:itemLibrary.smallBattery)
		location.at = at
		return location
	}
	
	func loiqeRepair(at:CGPoint) -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = at
		return location
	}
	
	func loiqeBeacon(at:CGPoint) -> LocationBeacon
	{
		let location = LocationBeacon(name:"loiqe beacon",message:"Are you absolutely sure that you are ~in space ...")
		location.at = at
		return location
	}
}