//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Ghost extends Empty {
  constructor() {
    super();

    this.makeFuzz();
    this.makeFace();
    this.returnTimeout = null;

    this.goalPosition = new THREE.Vector3();
    this.faceRadius = 0.42;
    this.faceRads = degToRad(45);
    this.face.position.set(
      this.faceRadius * Math.cos(this.faceRads),
      0,
      this.faceRadius * Math.sin(this.faceRads)
    );

    // this.hide();
    this.triggersByName = {};
    this.allEntries = [];
    this.salientEntries = [];
    this.lastNonHit = null;

    this.openEyes.opacity = 1;
    this.closedEyes.opacity = 0;
  }

  wanderTo(target, seconds = 2, callback = null) {
    this.goalPosition
      .copy(target.convertPositionToNode(new THREE.Vector3(), verreciel.root))
      .multiply(new THREE.Vector3(0.7, 1, 0.7));
    this.wanderToGoal(
      seconds,
      function() {
        this.returnTimeout = setTimeout(this.returnToCenter.bind(this), 5000);
        if (callback != null) {
          callback();
        }
      }.bind(this)
    );
  }

  wanderToGoal(seconds, callback) {
    clearTimeout(this.returnTimeout);
    this.faceRads = Math.atan2(
      this.goalPosition.z - this.position.z,
      this.goalPosition.x - this.position.x
    );

    verreciel.animator.begin();
    verreciel.animator.animationDuration = Math.max(0.5, seconds / 4);
    verreciel.animator.ease = Penner.easeInOutCubic;
    this.face.position.set(
      this.faceRadius * Math.cos(this.faceRads),
      0,
      this.faceRadius * Math.sin(this.faceRads)
    );
    verreciel.animator.commit();

    verreciel.animator.begin();
    verreciel.animator.animationDuration = seconds;
    verreciel.animator.ease = Penner.easeInOutCubic;
    this.position.set(
      this.goalPosition.x,
      this.goalPosition.y,
      this.goalPosition.z
    );
    verreciel.animator.completionBlock = callback;
    verreciel.animator.commit();
  }

  returnToCenter() {
    this.goalPosition.set(0, 0, 0);
    this.wanderToGoal(1.5, this.idle.bind(this));
  }

  idle() {
    this.faceRads = degToRad(45);
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 2;
    verreciel.animator.delay = 0.25;
    verreciel.animator.ease = Penner.easeInOutCubic;
    this.face.position.set(
      this.faceRadius * Math.cos(this.faceRads),
      0,
      this.faceRadius * Math.sin(this.faceRads)
    );
    verreciel.animator.commit();
  }

  whenStart() {
    super.whenStart();
    setTimeout(this.blink.bind(this), 1000 * (Math.random() * 4 + 6));
    setTimeout(this.waver.bind(this), 200);
  }

  waver() {
    setTimeout(this.waver.bind(this), 200);
    for (let i = 0; i < this.fuzzVertices.length; i++) {
      this.fuzzVertices[i].copy(this.fuzzBaseVertices[i]);
      this.fuzzVertices[i].x += (Math.random() - 0.5) * 0.015;
      this.fuzzVertices[i].z += (Math.random() - 0.5) * 0.015;
    }
    this.fuzz.updateVertices(this.fuzzVertices);
  }

  blink() {
    this.openEyes.opacity = 0;
    this.closedEyes.opacity = 1;
    setTimeout(
      function() {
        this.openEyes.opacity = 1;
        this.closedEyes.opacity = 0;

        let nextTime = Math.random() > 0.8 ? 0.2 : Math.random() * 4 + 6;
        setTimeout(this.blink.bind(this), 1000 * nextTime);
      }.bind(this),
      0.15 * 1000
    );
  }

  makeFuzz() {
    this.fuzzBaseVertices = [];
    this.fuzzVertices = [];
    let size1 = 0.84;
    let size2 = 0.76;
    let numLines = 80;
    for (let i = 0; i < numLines; i++) {
      let angle = degToRad(i * 360 / numLines);
      this.fuzzBaseVertices.push(
        new THREE.Vector3(Math.cos(angle) * size2, 0, Math.sin(angle) * size2)
      );
      this.fuzzBaseVertices.push(
        new THREE.Vector3(Math.cos(angle) * size1, 0, Math.sin(angle) * size1)
      );
      this.fuzzVertices.push(new THREE.Vector3());
      this.fuzzVertices.push(new THREE.Vector3());
    }
    this.fuzz = new SceneLine(this.fuzzVertices, verreciel.white);
    this.add(this.fuzz);
  }

  makeFace() {
    let center = new THREE.Vector3(0, 0, -0.14);
    let faceVertices = [];
    let openEyesVertices = [];
    let closedEyesVertices = [];

    faceVertices = faceVertices.concat(
      this.makeCircle(9, 0.008, new THREE.Vector3(0.21, 0, 0.3).add(center))
    );
    faceVertices = faceVertices.concat(
      this.makeCircle(9, 0.008, new THREE.Vector3(-0.21, 0, 0.3).add(center))
    );
    openEyesVertices = openEyesVertices.concat(
      this.makeCircle(9, 0.03, new THREE.Vector3(0.21, 0, 0.2).add(center))
    );
    openEyesVertices = openEyesVertices.concat(
      this.makeCircle(9, 0.03, new THREE.Vector3(-0.21, 0, 0.2).add(center))
    );
    closedEyesVertices.push(
      new THREE.Vector3(-0.21 - 0.04, 0, 0.208).add(center),
      new THREE.Vector3(-0.21 + 0.04, 0, 0.2).add(center)
    );
    closedEyesVertices.push(
      new THREE.Vector3(0.21 - 0.04, 0, 0.2).add(center),
      new THREE.Vector3(0.21 + 0.04, 0, 0.208).add(center)
    );

    let mouth1 = new THREE.Vector3(-1.0, 0.0, 0.0 * -0.6)
      .multiplyScalar(0.03)
      .add(center);
    let mouth2 = new THREE.Vector3(-0.7, 0.0, -0.7 * -0.6)
      .multiplyScalar(0.03)
      .add(center);
    let mouth3 = new THREE.Vector3(0.0, 0.0, -1.0 * -0.6)
      .multiplyScalar(0.03)
      .add(center);
    let mouth4 = new THREE.Vector3(0.7, 0.0, -0.7 * -0.6)
      .multiplyScalar(0.03)
      .add(center);
    let mouth5 = new THREE.Vector3(1.0, 0.0, 0.0 * -0.6)
      .multiplyScalar(0.03)
      .add(center);

    let mouth = [
      mouth1,
      mouth2,
      mouth2,
      mouth3,
      mouth3,
      mouth4,
      mouth4,
      mouth5
    ];
    faceVertices = faceVertices.concat(mouth);

    this.face = new SceneLine(faceVertices, verreciel.white);
    this.add(this.face);
    this.openEyes = new SceneLine(openEyesVertices, verreciel.white);
    this.face.add(this.openEyes);
    this.closedEyes = new SceneLine(closedEyesVertices, verreciel.white);
    this.face.add(this.closedEyes);
  }

  makeCircle(numLines, radius, offset) {
    let vertices = [];
    let rads = degToRad(360 / numLines);

    let angle = 0;
    let axis = new THREE.Vector3(0, 1, 0);
    let stylus = new THREE.Vector3(radius, 0, 0);
    for (let i = 0; i < numLines; i++) {
      vertices.push(stylus.clone().add(offset));
      stylus.applyAxisAngle(axis, rads);
      vertices.push(stylus.clone().add(offset));
    }
    return vertices;
  }

  whenRenderer() {
    // assertArgs(arguments, 0);
    super.whenRenderer();

    let rotY = this.face.rotation.y;

    let diffRotationY = sanitizeDiffAngle(verreciel.player.rotation.y, rotY);
    if (Math.abs(diffRotationY) > 0.001) {
      rotY += diffRotationY * 0.3;
    }

    let scale =
      this.fuzz.element.scale.z * 0.5 +
      (1 + verreciel.music.magnitude * 4) * 0.5;
    this.fuzz.element.scale.x = scale;
    this.fuzz.element.scale.z = scale;

    this.face.rotation.setNow(this.face.rotation.x, rotY, this.face.rotation.z);
  }

  report(entry) {
    if (this.isPlaying) {
      // TODO: autopilot
    } else if (DEBUG_LOG_GHOST == true) {
      this.allEntries.push(entry);
      if (entry.type == LogType.hit) {
        if (this.lastNonHit != null) {
          this.salientEntries.push(this.lastNonHit);
          this.lastNonHit = null;
        }
        this.salientEntries.push(entry);
      } else {
        this.lastNonHit = entry;
      }
    }
  }

  tapTrigger(name) {
    this.triggersByName[name].tap();
  }
}

class LogType {}
setEnumValues(LogType, [
  "hit",
  "install",
  "upload",
  "combination",
  "docked",
  "thrusterUnlock",
  "playerUnlock",
  "pilotAligned",
  "mission",
  "quest"
]);

class LogEntry {
  constructor(type, data = null) {
    this.type = type;
    this.data = data;
  }
}
