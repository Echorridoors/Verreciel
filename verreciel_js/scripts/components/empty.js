class Empty extends SceneNode
{
  constructor()
  {
    super();
    this.details = "unknown";
  }

  touch(id = 0)
  {
    return false;
  }
  
  update()
  {

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
    for (let node of this.children)
    {
      node.removeFromParentNode();
    }
  }
  
  blink()
  {
    if (game.time % 3 == 0)
    {
      this.visible = true;
    }
    else
    {
      this.visible = false;
    }
  }
  
  show()
  {
    this.visible = true;
  }
  
  hide()
  {
    this.visible = false;
  }
  
  updateChildrenColors(color)
  {
    for (let node of this.children)
    {
      node.applyColor(color);
      node.updateChildrenColors(color);
    }
  }
  
  applyColor(color)
  {
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
    update()
  }
  
  onDisconnect()
  {
    update()
  }
  
  onUploadComplete()
  {
    
  }
  
  onMissionComplete()
  {
    
  }
  
  payload()
  {
    return new ConsolePayload([new ConsoleData("unknown", "unknown")]);
  }
}
