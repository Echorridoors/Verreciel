class SceneTransaction
{
  constructor()
  {
    assertArgs(arguments, 0, true);
    this.begun = false;
    this.properties = [];
  }

  begin()
  {
    assertArgs(arguments, 0, true);
    this.begun = true;
    this.properties.splice(0, this.properties.length);
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
  constructor(sceneTransaction, target, property)
  {
    assertArgs(arguments, 3, true);
    var xyz = target[property];
    var xProperty = new SceneProperty(sceneTransaction, xyz, "x");
    var yProperty = new SceneProperty(sceneTransaction, xyz, "y");
    var zProperty = new SceneProperty(sceneTransaction, xyz, "z");
    
    Object.defineProperties( this, {
      x:
      {
        enumerable: true,
        get: function() { return xProperty.value; },
        set: function(value) { xProperty.value = value; }
      },
      y:
      {
        enumerable: true,
        get: function() { return yProperty.value; },
        set: function(value) { yProperty.value = value; }
      },
      z:
      {
        enumerable: true,
        get: function() { return zProperty.value; },
        set: function(value) { zProperty.value = value; }
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

  render()
  {
    assertArgs(arguments, 0, true);
    this.x.render();
    this.y.render();
    this.z.render();
  }
}

class SceneProperty
{
  constructor(sceneTransaction, target, property)
  {
    assertArgs(arguments, 3, true);
    this.sceneTransaction = sceneTransaction;
    this.target = target;
    this.property = property;

    var value = this.target[this.property];

    Object.defineProperties( this, {
      value:
      {
        enumerable: false,
        get: function() { return value; },
        set: function(newValue) {

          value = newValue;
          if (sceneTransaction.begun)
          {
            this.sceneTransaction.registerProperty(this);
          }
          else
          {
            this.target[this.property] = value;
          }
        }
      }
    });
  }

  commit()
  {
    assertArgs(arguments, 0, true);

    var duration = this.sceneTransaction.animationDuration;
    var oldValue = this.target[this.property];
    var newValue = this.value;

    // console.log("~~~", oldValue, newValue, duration);

    var percent = 0;
    var target = this.target;
    var property = this.property;

    function tick(millisecondsElapsed)
    {
      var percentElapsed = (millisecondsElapsed / 1000) / duration;
      percent += percentElapsed;

      if (percent > 1)
      {
        percent = 1;
      }

      target[property] = newValue * percent + oldValue * (1 - percent);

      if (percent == 1)
      {
        cancelAnimationFrame(frameID);
      }
    }

    var frameID = requestAnimationFrame(tick);
  }
}
