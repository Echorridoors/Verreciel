class Demo extends THREE.Group
{
  constructor()
  {
    super();
  }

  update()
  {
    var time = Date.now() * 0.0001;
    for ( var i = 0; i < this.children.length; i ++ ) {
      var object = this.children[ i ];
      if ( object instanceof THREE.Line ) {
        object.rotation.y = time * (i + 1);
      }
    }
  }

  whenStart()
  {
    var vertex1;
    var vertex2;
    var material;
    
    var geometry = new THREE.Geometry();
    for ( var i = 0; i < 500; i ++ ) {

      var vertex1 = new THREE.Vector3(Math.random() * 2 - 1, Math.random() * 2 - 1, Math.random() * 2 - 1);
      vertex1.normalize();
      vertex1.multiplyScalar( 450 );

      var vertex2 = new THREE.Vector3();
      vertex2.x = vertex1.y;
      vertex2.y = vertex1.z;
      vertex2.z = vertex1.x;

      geometry.vertices.push( vertex1 );
      geometry.vertices.push( vertex2 );

      var color = new THREE.Color( Math.random(), Math.random(), Math.random() );

      geometry.colors.push(color);
      geometry.colors.push(color);
    }

    for( i = 0; i < 3; i++ ) {
      var line = new Empty();
      line.geometry = geometry;
      line.scale.x = line.scale.y = line.scale.z = 0.125 * (i + 1);
      line.rotation.y = Math.random() * Math.PI;
      line.updateMatrix();
      this.add( line );
    }
  }
}
