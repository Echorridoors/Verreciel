//
//  GameViewController.swift
//  verdeciel
//
//  Created by Devine Lu Linvega on 2014-09-21.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

var scene = SCNScene()
var touchOrigin = CGPoint()

var heading = Double(0.0)
var attitude = Double(0.0)
var bank = 0.0
let scaleValue : Float = 0.01
var user = Dictionary<String, Any>()

class GameViewController: UIViewController
{
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		configSetup()
		userSetup()
		worldSetup()
    }
}
