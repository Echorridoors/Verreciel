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
	var color:UIColor = UIColor.whiteColor()
	
	init(text:String,scale:Float = 0.1,align:alignment = alignment.left, color:UIColor = white)
	{
		super.init()
		
		self.color = color
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
			let wordLength = Float(activeText.characters.count) * (activeScale * 1.5) * -1
			nodeOffset.position = SCNVector3(x: wordLength/2, y: 0, z: 0)
		}
		else if activeAlignment == alignment.right {
			let wordLength = Float(activeText.characters.count) * (activeScale * 1.5) * -1
			nodeOffset.position = SCNVector3(x: wordLength, y: 0, z: 0)
		}
	}
	
	func addLetters(text:String,scale:Float)
	{
		var letterPos = 0
		for letterCur in text.characters
		{
			let letterNode = letter(String(letterCur),scale:scale)
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
	
	func update(text:String, force:Bool = false)
	{
		if text == activeText && force == false { return }
		removeLetters()
		activeText = text
		addLetters(activeText, scale: activeScale)
		adjustAlignment()
	}
	
	func updateWithColor(text:String,color:UIColor)
	{
		self.color = color
		update(text)
	}
	
	func updateColor(color:UIColor)
	{
		if self.color == color { return }
		self.color = color
		update(activeText,force:true)
	}
	
	func letter(letter:String,scale:Float) -> SCNNode
	{		
		let letterPivot = SCNNode()
		
		let letter = letter.lowercaseString
		
		if letter == "a"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "b"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "c"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "d"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "e"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
		}
		else if letter == "f"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
		}
		else if letter == "g"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
		}
		else if letter == "h"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "i"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:self.color))
		}
		else if letter == "j"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: -scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
		}
		else if letter == "k"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "l"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "m"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: 0, z: 0),color:self.color))
		}
		else if letter == "n"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "o"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: -scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: 0, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
		}
		else if letter == "p"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:self.color))
		}
		else if letter == "q"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: -scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: 0, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "r"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			
		}
		else if letter == "s"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			
		}
		else if letter == "t"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:self.color))
		}
		else if letter == "u"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
		}
		else if letter == "v"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
		}
		else if letter == "w"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: 0, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:self.color))
		}
		else if letter == "x"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			
		}
		else if letter == "y"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: 0, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:self.color))
			
		}
		else if letter == "z"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))

		}
		else if letter == "1"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:self.color))
			
		}
		else if letter == "2"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "3"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			
		}
		else if letter == "4"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "5"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "6"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:self.color))
		}
		else if letter == "7"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "8"
		{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == "9"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
		}
		else if letter == "0"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
		}
		else if letter == " "{
			
		}
		else if letter == "~"{
			
		}
		else if letter == "-"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
		}
		else if letter == "+"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:self.color))
		}
		else if letter == ">"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:red))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: 0, z: 0),color:red))
		}
		else if letter == "<"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:red))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: -scale, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:red))
		}
		else if letter == ","{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: 0, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:self.color))
		}
		else if letter == "."{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: 0, z: 0), nodeB: SCNVector3(x: scale/2, y: -scale, z: 0),color:self.color))
		}
		else if letter == "'"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale/2, y: scale, z: 0), nodeB: SCNVector3(x: scale/2, y: 0, z: 0),color:self.color))
		}
		else if letter == "%"{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
		}
		else{
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: 0, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			letterPivot.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: scale, z: 0), nodeB: SCNVector3(x: scale, y: -scale, z: 0),color:self.color))
			
		}

		return letterPivot
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}