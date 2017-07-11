class Item extends Event
{
  constructor(name = "", type = ItemTypes.generic, location = null, details = "", isQuest = false, code = null)
  {
    assertArgs(arguments, 6);
    super(name, new THREE.Vector2(), details, verreciel.grey, false);
    
    this.name = name;
    this.type = type;
    this.details = details;
    this.isQuest = isQuest;
    this.location = location;
    this.code = code;
  }
  
  payload()
  {
    assertArgs(arguments, 0);
    return new ConsolePayload([
      new ConsoleData("Item", this.type),
      new ConsoleData(this.details),
    ]);
  }
}

Item.like = function(other)
{
  assertArgs(arguments, 1);
  return new Item(other.name, other.type, null, other.details, other.isQuest, null);
}
