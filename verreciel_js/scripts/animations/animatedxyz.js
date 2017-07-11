class AnimatedXYZ
{
  constructor(animator, target, property, angles = false)
  {
    assertArgs(arguments, 3);
    var xyz = target[property];
    this.__xProperty = new AnimatedProperty(animator, xyz, "x", angles);
    this.__yProperty = new AnimatedProperty(animator, xyz, "y", angles);
    this.__zProperty = new AnimatedProperty(animator, xyz, "z", angles);
  }
  
  get x() { return this.__xProperty.value; }
  set x(value) { this.__xProperty.value = value; }

  get y() { return this.__yProperty.value; }
  set y(value) { this.__yProperty.value = value; }

  get z() { return this.__zProperty.value; }
  set z(value) { this.__zProperty.value = value; }

  set(x, y, z)
  {
    assertArgs(arguments, 3, true);
    this.x = x;
    this.y = y;
    this.z = z;
  }

  setNow(x, y, z)
  {
    assertArgs(arguments, 3, true);
    this.__xProperty.setNow(x);
    this.__yProperty.setNow(y);
    this.__zProperty.setNow(z);
  }

  copy(other)
  {
    assertArgs(arguments, 1, true);
    this.x = other.x;
    this.y = other.y;
    this.z = other.z;
  }
}
