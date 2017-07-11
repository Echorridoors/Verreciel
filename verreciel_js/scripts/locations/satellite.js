class LocationSatellite extends Location
{
  constructor(name, system, at = new THREE.Vector2(), message, item, mapRequirement = null)
  {
    super(name, system, at, new IconSatellite(), (name == "spawn" ? new Structure() : new StructureSatellite()));
    
    this.details = item.name;
    this.isComplete = false;
    this.mapRequirement = mapRequirement;
    this.message = message;
    
    this.port = new ScenePortSlot(this, Alignment.center, true);
    this.port.position.set(0,-0.4,0);
    this.port.addEvent(item);
    this.port.enable();
    
    this.update();
  }
  
  // MARK: Panel
  
  panel()
  {
    if (this.isComplete == true)
    {
      return null;
    }
    
    let newPanel = new Panel();
    
    let text = new SceneLabel(this.message, Alignment.left);
    text.position.set(-1.5,1,0);
    newPanel.add(text);
    
    newPanel.add(this.port);
  
    return newPanel;
  }
  
  onDock()
  {
    super.onDock();
    this.port.refresh();
  }
  
  update()
  {
    super.update();
    
    if (this.port.event == null)
    {
      this.onComplete();
    }
  }
  
  onUploadComplete()
  {
    this.onComplete();
    this.structure.update();
  }
}

class IconSatellite extends Icon
{
  constructor()
  {
    super();
    
    this.mesh.add(new SceneLine([
      new THREE.Vector3(0,this.size,0),  
      new THREE.Vector3(this.size,0,0), 
      new THREE.Vector3(-this.size,0,0),  
      new THREE.Vector3(0,-this.size,0), 
      new THREE.Vector3(0,this.size,0),  
      new THREE.Vector3(-this.size,0,0), 
      new THREE.Vector3(this.size,0,0),  
      new THREE.Vector3(0,-this.size,0),
    ], this.color));
  }
}

class StructureSatellite extends Structure
{
  constructor()
  {
    super();

    let nodes = Math.floor(Math.random() * 2) + 3;
    
    this.root.position.set(0,5,0);
    
    var i = 0;
    while (i < nodes)
    {
      
      let axis = new Empty()
      axis.rotation.y = (degToRad(i * (360/nodes)));
      
      this.root.add(axis);
      
      let shape = new ShapeHexagon(3, verreciel.red);
      shape.position.x = 0;
      axis.add(shape);
      
      let shape2 = new ShapeHexagon(3, verreciel.red);
      shape2.rotation.z = degToRad(90);
      shape.add(shape2);
      
      let shape3 = new ShapeHexagon(3, verreciel.red);
      shape3.rotation.y = degToRad(90);
      shape.add(shape3);
      
      let shape4 = new ShapeHexagon(3, verreciel.red);
      shape4.rotation.x = degToRad(90);
      shape.add(shape4);
      
      i += 1;
    }
  }
  
  onSight()
  {
    super.onSight();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // for (let node of this.root.children)
    // {
    //   for (let subnode of node.children)
    //   {
    //     subnode.position.x = 3;
    //   }
    // }
    
    // SCNTransaction.commit()
  }
  
  onUndock()
  {
    super.onUndock();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // for (let node of this.root.children)
    // {
    //   for (let subnode of node.children)
    //   {
    //     subnode.position.x = 3;
    //   }
    // }
    
    // SCNTransaction.commit()
  }
  
  onDock()
  {
    super.onDock();
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // for (let node of this.root.children)
    // {
    //   for (let subnode of node.children)
    //   {
    //     subnode.position.x = 0;
    //   }
    // }
    
    // SCNTransaction.commit()
  }
  
  onComplete()
  {
    super.onComplete();
  
    this.root.updateChildrenColors(verreciel.cyan);
  }
  
  sightUpdate()
  {
    this.root.rotation.y += degToRad(0.1);
  }
  
  dockUpdate()
  {
    for (let node of this.root.children)
    {
      for (let subnode of node.children)
      {
        subnode.rotation.z += degToRad(0.25);
      }
    }
  }
}
