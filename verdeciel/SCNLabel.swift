//
//  displayNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNLabel : SCNNode
{
	var activeText = String()
	var activeScale:Float = 0.2
	var activeAlignment:alignment!
	
	var nodeOffset:SCNNode!
	
	init(text:String,scale:Float,align:alignment)
	{
		super.init()
		
		activeText = text
		activeScale = scale
		activeAlignment = align
		nodeOffset = SCNNode()
		
		addLetters(activeText,scale:activeScale)
		adjustAlignment()
		
		self.addChildNode(nodeOffset)
	}
	
	func adjustAlignment()
	{
		if activeAlignment == alignment.center {
			let wordLength = Float(Array(activeText).count) * (activeScale * 1.5) * -1
			nodeOffset.position = SCNVector3(x: wordLength/2, y: 0, z: 0)
		}
		else if activeAlignment == alignment.right {
			let wordLength = Float(Array(activeText).count) * (activeScale * 1.5) * -1
			nodeOffset.position = SCNVector3(x: wordLength, y: 0, z: 0)
		}
	}
	
	func addLetters(text:String,scale:Float)
	{
		let characters = Array(text)
		
		var letterPos = 0
		for letterCur in characters
		{
			var letterNode = letter(String(letterCur),scale:scale)
			letterNode.position = SCNVector3(x: (scale * 1.5) * Float(letterPos), y: 0, z: 0)
			nodeOffset.addChildNode(letterNode)
			
			letterPos += 1
		}
	}
	
	func removeLetters()
	{		
		activeText = ""
		for letterCur in nodeOffset.childNodes {
			letterCur.removeFromParentNode()
		}
	}
	
	func update(text:String)
	{
		if text == activeText { return }
		removeLetters()
		activeText = text
		addLetters(activeText, scale: activeScale)
		adjustAlignment()
	}
	
	func letter(letter:String,scale:Float) -> SCNNode
	{		
		let letterPivot = SCNNode()
		
		var letter = letter.lowercaseString
		
		if letter == "a"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "b"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "c"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "d"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "e"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
		}
		else if letter == "f"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
		}
		else if letter == "f"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
		}
		else if letter == "g"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
		}
		else if letter == "h"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "i"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:white))
		}
		else if letter == "j"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: -scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
		}
		else if letter == "k"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "l"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "m"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: 0, z: 0),color:white))
		}
		else if letter == "n"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "o"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: -scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: 0, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
		}
		else if letter == "p"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:white))
		}
		else if letter == "r"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			
		}
		else if letter == "s"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			
		}
		else if letter == "t"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:white))
		}
		else if letter == "u"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
		}
		else if letter == "v"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
		}
		else if letter == "w"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: 0, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:white))
		}
		else if letter == "x"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			
		}
		else if letter == "y"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: 0, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:white))
			
		}
		else if letter == "1"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:white))
			
		}
		else if letter == "2"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "3"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			
		}
		else if letter == "4"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "5"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "6"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:white))
		}
		else if letter == "7"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "8"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == "9"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
		}
		else if letter == "0"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
		}
		else if letter == " "{
			
		}
		else if letter == "-"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
		}
		else if letter == ">"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:white))
		}
		else if letter == ","{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: 0, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:white))
		}
		else if letter == "."{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: 0, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:white))
		}
		else if letter == "'"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: 0, z: 0),color:white))
		}
		else if letter == "%"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
		}
		else{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:white))
			
		}

		return letterPivot
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}