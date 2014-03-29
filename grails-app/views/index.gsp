<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Grails</title>
</head>

<body />
<script type="text/javascript" src="${resource(dir: 'js', file: 'three.js')}"></script>
<script>
    if (window.innerWidth === 0) {
        window.innerWidth = parent.innerWidth;
        window.innerHeight = parent.innerHeight;
    }
    var scene = new THREE.Scene();
    var aspect_ratio = window.innerWidth / window.innerHeight;
    var camera = new THREE.PerspectiveCamera(75, aspect_ratio, 1, 10000);
    camera.position.z = 500;
    scene.add(camera);

    var renderer = new THREE.CanvasRenderer();
    renderer.setSize(window.innerWidth, window.innerHeight);
    document.body.appendChild(renderer.domElement);

    var cuerpo_shape = new THREE.SphereGeometry(50, 20, 30);
    var cuerpo_cover = new THREE.MeshNormalMaterial();
    var cuerpo = new THREE.Mesh(cuerpo_shape, cuerpo_cover);
    scene.add(cuerpo);

    var brazo_izq_shape = new THREE.CylinderGeometry(20, 20, 70, 7);
    var brazo_izq_cover = new THREE.MeshNormalMaterial();
    var brazo_izq = new THREE.Mesh(brazo_izq_shape, brazo_izq_cover);
    cuerpo.add(brazo_izq);
    brazo_izq.position.set(-72, 0, 0);
    brazo_izq.rotation.set(0, 0, 0);

    var brazo_der_shape = new THREE.CylinderGeometry(20, 20, 70, 7);
    var brazo_der_cover = new THREE.MeshNormalMaterial();
    var brazo_der = new THREE.Mesh(brazo_izq_shape, brazo_izq_cover);
    cuerpo.add(brazo_der);
    brazo_der.position.set(72, 0, 0);
    brazo_der.rotation.set(0, 0, 0);

    renderer.render(scene, camera);

    document.addEventListener('keydown', function (event) {
        var code = event.keyCode;
        var pow = 0.15;
        if (code == 37) { // izq
            cuerpo.rotation.y -= pow;
        }
        if (code == 38) { // ari
            cuerpo.rotation.x -= pow;
        }
        if (code == 39) { // der
            cuerpo.rotation.y += pow;
        }
        if (code == 40) { // abj
            cuerpo.rotation.x += pow;
        }
        renderer.render(scene, camera);
    });
</script>
</html>
