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

    var cuerpo_shape = new THREE.CubeGeometry(150, 220, 220);
    var cuerpo_cover = new THREE.MeshNormalMaterial();
    var cuerpo = new THREE.Mesh(cuerpo_shape, cuerpo_cover);
    cuerpo.rotation.y = 0.3;
    scene.add(cuerpo);

    renderer.render(scene, camera);

    /** Vertx */
    var eventBus = new vertx.EventBus("http://localhost:5439/eventbus");
    eventBus.onopen = function () {
        console.info("EventBus ready...");
        document.addEventListener('keydown', function (event) {
            var code = event.keyCode;
            var pow = 0.15;
            if (code == 37) { // left
                cuerpo.rotation.y -= pow;
            }
            if (code == 38) { // up
                cuerpo.rotation.x -= pow;
            }
            if (code == 39) { // right
                cuerpo.rotation.y += pow;
            }
            if (code == 40) { // down
                cuerpo.rotation.x += pow;
            }
            eventBus.publish('move-ball', {
                code: code,
                px: pow
            });

            renderer.render(scene, camera);
        });
    }
    eventBus.onclose = function () {
        eventBus = null;
        console.error("EventBus down...");
    }
</script>
</html>
