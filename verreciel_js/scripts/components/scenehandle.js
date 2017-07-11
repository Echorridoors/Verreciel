class SceneHandle extends Empty
{
  constructor(destination = new THREE.Vector3(), host)
  {
    super();
    this.isEnabled = true;
    this.destination = destination;
    this.host = host;
    this.setup();
  }
  
  setup()
  {
    let width = 0.4;
    let spacing = 0.15;
    let height = 0.2;
    this.position.set(0, 0, Templates.radius);
    
    this.add(new SceneLine([
      new THREE.Vector3(-width, 0, height),  
      new THREE.Vector3(-width + spacing, 0, height), 
      new THREE.Vector3(width, 0, height),  
      new THREE.Vector3(width - spacing, 0, height), 
      new THREE.Vector3(-width, 0, 0),  
      new THREE.Vector3(-width, 0, height), 
      new THREE.Vector3(width, 0, 0),  
      new THREE.Vector3(width, 0, height),
    ], verreciel.grey) );
    
    this.selectionLine = new SceneLine([
      new THREE.Vector3(-width + spacing, 0, height),
      new THREE.Vector3(width - spacing, 0, height),
    ], verreciel.cyan);
    this.add(this.selectionLine);
    
    this.trigger = new SceneTrigger(this, new THREE.Vector2(2, 0.5), 0);
    this.trigger.updateChildrenColors(verreciel.red); // Implies this was never used?
    this.add(this.trigger);
  }
  
  enable()
  {
    this.isEnabled = true;
    this.selectionLine.updateColor(verreciel.cyan);
  }
  
  disable()
  {
    this.isEnabled = false;
    this.selectionLine.updateColor(verreciel.grey);
  }
  
  touch(id = 0)
  {
    verreciel.player.holdHandle(this);
    verreciel.music.playEffect("click4");
    return true;
  }
}
