class SceneTransaction
{
  constructor()
  {
    assertArgs(arguments, 0, true);
    this.begun = false;
    this.properties = [];
    this.ease = Penner.easeOutQuart;
  }

  begin()
  {
    assertArgs(arguments, 0, true);
    this.begun = true;
    this.properties.splice(0, this.properties.length);
    this.ease = Penner.easeOutQuart;
  }

  registerProperty(property)
  {
    assertArgs(arguments, 1, true);
    if (!property.registered)
    {
      this.properties.push(property);
    }
  }

  commit()
  {
    assertArgs(arguments, 0, true);
    for (let property of this.properties)
    {
      property.registered = false;
      property.commit();
    }
    this.properties.splice(0, this.properties.length);

    this.begun = false;

    var animationDuration = this.animationDuration;
    this.animationDuration = 0;
    var completionBlock = this.completionBlock;
    this.completionBlock = null;
    delay(animationDuration, completionBlock);
  }
}

class ScenePropertyXYZ
{
  constructor(sceneTransaction, target, property, angles = false, interrupt = false)
  {
    assertArgs(arguments, 3);
    this.interrupt = interrupt;
    var xyz = target[property];
    this.__xProperty = new SceneProperty(sceneTransaction, xyz, "x", angles, interrupt);
    this.__yProperty = new SceneProperty(sceneTransaction, xyz, "y", angles, interrupt);
    this.__zProperty = new SceneProperty(sceneTransaction, xyz, "z", angles, interrupt);
    
    Object.defineProperties( this, {
      x:
      {
        get: function() { return this.__xProperty.value; },
        set: function(value)
        {
          let wasRunning = this.__xProperty.running;
          this.__xProperty.value = value;
          if (this.interrupt && wasRunning && !this.__xProperty.running)
          {
            this.fastForwardXYZ();
          }
        }
      },
      y:
      {
        get: function() { return this.__yProperty.value; },
        set: function(value)
        {
          let wasRunning = this.__yProperty.running;
          this.__yProperty.value = value;
          if (this.interrupt && wasRunning && !this.__yProperty.running)
          {
            this.fastForwardXYZ();
          }
        }
      },
      z:
      {
        get: function() { return this.__zProperty.value; },
        set: function(value)
        {
          let wasRunning = this.__zProperty.running;
          this.__zProperty.value = value;
          if (wasRunning && !this.__zProperty.running)
          {
            this.fastForwardXYZ();
          }
        }
      }
    });
  }

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

  fastForwardXYZ()
  {
    this.setNow(this.__xProperty.value, this.__yProperty.value, this.__zProperty.value);
  }
}

class SceneProperty
{
  constructor(sceneTransaction, target, property, isAngle = false, interrupt = false)
  {
    assertArgs(arguments, 3);
    this.sceneTransaction = sceneTransaction;
    this.target = target;
    this.property = property;
    this.isAngle = isAngle;
    this.interrupt = interrupt;

    this.__value = this.target[this.property];
    if (this.isAngle) { this.__value = sanitizeAngle(this.__value); }

    Object.defineProperties( this, {
      value:
      {
        get: function() { return this.__value; },
        set: function(newValue) {
          if (this.running)
          {
            this.running = false;
            if (this.interrupt)
            {
              this.target[this.property] = this.__value;
            }
          }
          if (this.isAngle) { newValue = sanitizeAngle(newValue); }
          if (this.__value == newValue) { return; }
          this.__value = newValue;
          if (sceneTransaction.begun)
          {
            this.sceneTransaction.registerProperty(this);
          }
          else
          {
            this.target[this.property] = this.__value;
          }
        }
      }
    });
  }

  setNow(newValue)
  {
    if (this.isAngle) { newValue = sanitizeAngle(newValue); }
    if (this.__value == newValue) { return; }
    this.__value = newValue;
    this.target[this.property] = this.__value;
    this.running = false;
  }

  commit()
  {
    assertArgs(arguments, 0, true);

    let oldValue = this.target[this.property];
    if (this.isAngle) { oldValue = sanitizeAngle(oldValue); }
    let newValue = this.value;

    if (oldValue == newValue)
    {
      return;
    }

    if (this.isAngle)
    {
      oldValue = newValue - sanitizeDiffAngle(newValue, oldValue);
    }

    let duration = this.sceneTransaction.animationDuration;
    let target = this.target;
    let property = this.property;
    let owner = this;
    let ease = this.sceneTransaction.ease;
    
    var percent = 0;
    var lastFrameTime = Date.now();
    function tick()
    {
      if (!owner.running) { return; }
      let frameTime = Date.now();
      let secondsElapsed = (frameTime - lastFrameTime) / 1000;
      lastFrameTime = frameTime;

      var percentElapsed = secondsElapsed / duration;
      percent += percentElapsed;

      // console.log("~~~", property, ":", oldValue, "-", newValue, "/", duration, "s", secondsElapsed, "@", percent);

      if (percent > 1)
      {
        percent = 1;
      }

      let easedPercent = ease(percent, 0, 1, 1);

      target[property] = newValue * easedPercent + oldValue * (1 - easedPercent);

      if (percent < 1)
      {
        requestAnimationFrame(tick);
      }
      else
      {
        owner.running = false;
      }
    }

    this.running = true;
    requestAnimationFrame(tick);
  }
}
