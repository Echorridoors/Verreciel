class Empty extends SceneNode
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();
    this.details = "unknown";
  }

  touch(id = 0)
  {
    assertArgs(arguments, 1);
    return false;
  }
  
  update()
  {
    assertArgs(arguments, 0, true);

  }

  // TODO: REMOVE
  add()
  {
    if (arguments[0] == null)
    {
      throw "NULL ADD";
    }
    if (!arguments[0] instanceof THREE.Object3D)
    {
      throw "ILLEGAL ADD";
    }
    super.add.apply(this, arguments);
  }
  
  empty()
  {
    assertArgs(arguments, 0);
    for (let node of this.children)
    {
      node.removeFromParentNode();
    }
  }
  
  blink()
  {
    assertArgs(arguments, 0);
    if (game.time % 3 == 0)
    {
      this.opacity = 1;
    }
    else
    {
      this.opacity = 0;
    }
  }
  
  show()
  {
    assertArgs(arguments, 0);
    this.opacity = 1;
  }
  
  hide()
  {
    assertArgs(arguments, 0);
    this.opacity = 0;
  }
  
  updateChildrenColors(color)
  {
    assertArgs(arguments, 1);
    for (let node of this.children)
    {
      node.applyColor(color);
      node.updateChildrenColors(color);
    }
  }
  
  applyColor(color)
  {
    assertArgs(arguments, 1);
    if (this.geometry.vertices.length == 0)
    {
      return;
    }

    if (!(this instanceof SceneLine))
    {
      return;
    }
    
    this.updateColor(color); // TODO: move to SceneLine
  }
  
  onConnect()
  {
    assertArgs(arguments, 0);
    update();
  }
  
  onDisconnect()
  {
    assertArgs(arguments, 0);
    update();
  }
  
  onUploadComplete()
  {
    assertArgs(arguments, 0);
    
  }
  
  onMissionComplete()
  {
    assertArgs(arguments, 0);
    
  }
  
  payload()
  {
    assertArgs(arguments, 0);
    return new ConsolePayload([new ConsoleData("unknown", "unknown")]);
  }
}
