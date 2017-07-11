class Console extends MainPanel
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();
    
    this.lines = [
      new ConsoleLine(),
      new ConsoleLine(),
      new ConsoleLine(),
      new ConsoleLine(),
      new ConsoleLine(),
      new ConsoleLine(),
    ];

    this.name = "console";
    this.details = "inspects events"
    
    this.lines[0].position.set( Templates.leftMargin,  Templates.lineSpacing * 2.5,  0);
    this.lines[1].position.set( Templates.leftMargin,  Templates.lineSpacing * 1.5,  0);
    this.lines[2].position.set( Templates.leftMargin,  Templates.lineSpacing * 0.5,  0);
    this.lines[3].position.set( Templates.leftMargin,  -Templates.lineSpacing * 0.5,  0);
    this.lines[4].position.set( Templates.leftMargin,  -Templates.lineSpacing * 1.5,  0);
    this.lines[5].position.set( Templates.leftMargin,  -Templates.lineSpacing * 2.5,  0);
    
    for (let line of this.lines)
    {
      this.mainNode.add(line);
    }
    
    this.footer.add(new SceneHandle(new THREE.Vector3(-1,0,0), this));
  }
  
  onConnect()
  {
    assertArgs(arguments, 0);
    super.onDisconnect();
    
    this.nameLabel.updateText(this.port.origin.host.name + " > Port", verreciel.cyan);
    
    if (this.port.origin.event != null)
    {
      this.inject(this.port.origin.event.payload());
    }
    else if (this.port.origin.host != null)
    {
      this.inject(this.port.origin.host.payload());
    }
  }
  
  onDisconnect()
  {
    assertArgs(arguments, 0);
    super.onDisconnect();
    
    this.nameLabel.updateText("Console", verreciel.grey);
    this.inject(this.defaultPayload());
  }
  
  whenStart()
  {
    assertArgs(arguments, 0);
    super.whenStart();
    
    this.nameLabel.updateColor(verreciel.grey);
    this.inject(this.defaultPayload());
  }
  
  whenTime()
  {
    assertArgs(arguments, 0);
    super.whenTime();
    
    
  }
  
  clear()
  {
    assertArgs(arguments, 0);
    for (let line of this.lines) 
    {
      line.updateData(new ConsoleData());
    }
  }
  
  inject(payload)
  {
    assertArgs(arguments, 1);
    this.clear();
    
    var id = 0;
    for (let data of payload.data)
    {
      this.lines[id].updateData(data);
      id += 1;
    }
    
    // Animate
    
    var count = 0;
    for (let line of this.lines ) 
    {
      line.position.z = count * -0.1;
      line.opacity = 0;
      count += 1;
    }
    
    verreciel.sceneTransaction.begin();
    verreciel.sceneTransaction.animationDuration = 0.5;
    
    for (let line of this.lines) 
    {
      line.position.z = 0;
      line.opacity = 1;
    }
    
    verreciel.sceneTransaction.commit();
  }
  
  defaultPayload()
  {
    assertArgs(arguments, 0);
    return new ConsolePayload([
      new ConsoleData("nataniev os", "OK", null, verreciel.white),
      new ConsoleData("systems", verreciel.capsule.systemsInstalledCount() + "/" + verreciel.capsule.systemsCount() , null, verreciel.grey),
      new ConsoleData("", "", null, verreciel.grey),
      new ConsoleData("", "", null, verreciel.grey),
      new ConsoleData("", "", null, verreciel.grey),
      new ConsoleData("", "", null, verreciel.grey),
    ])
  }
  
  onInstallationBegin()
  {
    assertArgs(arguments, 0);
    super.onInstallationBegin();
    
    this.player.lookAt(-270);
  }
  
  onInstallationComplete()
  {
    assertArgs(arguments, 0);
    super.onInstallationComplete();
    
    this.inject(this.defaultPayload());
  }
}

class ConsoleLine extends Empty
{
  constructor(data = null)
  {
    assertArgs(arguments, 0);
    super();
    
    this.port = new ScenePortRedirect(this);
    this.port.position.set(0, 0, 0);
    this.port.hide();
    this.add(this.port);
    
    this.textLabel = new SceneLabel("", 0.1, Alignment.left);
    this.textLabel.position.set(0.3, 0, 0);
    this.add(this.textLabel);
    
    this.detailsLabel = new SceneLabel("", 0.075, Alignment.right, verreciel.grey);
    this.detailsLabel.position.set(3.2, 0, 0);
    this.add(this.detailsLabel);

    // Missing, but surely this is correct?
    if (data != null)
    {
      this.updateLine(data);
    }
  }
  
  updateData(data)
  {
    assertArgs(arguments, 1);
    this.detailsLabel.updateText(data.details);
    
    if (data.event != null)
    {
      this.textLabel.updateText(data.text, data.color);
      this.port.addEvent(data.event);
      this.port.enable();
      this.port.show();
      this.textLabel.position.set(0.3, 0, 0);
    }
    else
    {
      this.textLabel.updateText("> " + data.text, data.color);
      this.port.disable();
      this.port.hide();
      this.textLabel.position.set(0, 0, 0);
    }
  }
}

class ConsoleData
{
  constructor(text = "", details = "", event = null, color = verreciel.white)
  {
    assertArgs(arguments, 0);
    this.text = text;
    this.details = details;
    this.event = event;
    this.color = color;
  }
}

class ConsolePayload
{
  constructor(data)
  {
    assertArgs(arguments, 1);
    this.data = data;
  }
}

