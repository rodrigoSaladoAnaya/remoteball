<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Grails</title>
</head>

<body/>
<script type="text/javascript" src="${resource(dir: 'js', file: 'three.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'sockjs.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js', file: 'vertxbus.js')}"></script>

<script>
    /** Vertx */
    var eventBus = new vertx.EventBus("http://localhost:5439/eventbus");
    eventBus.onopen = function () {
        console.info("EventBus ready...");
        eventBus.send('move-ball', {
            direcition: 'right',
            px: 0.15
        }, function (resp) {
            console.info(resp);
        });
    }
    eventBus.onclose = function () {
        eventBus = null;
        console.error("EventBus down...");
    }
    /** Donut */
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

    var cuerpo_shape = new THREE.TorusGeometry(70, 10, 20, 50);
    var cuerpo_cover = new THREE.MeshNormalMaterial();
    var cuerpo = new THREE.Mesh(cuerpo_shape, cuerpo_cover);
    cuerpo.rotation.set(1.5, 0, 0);
    scene.add(cuerpo);

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
