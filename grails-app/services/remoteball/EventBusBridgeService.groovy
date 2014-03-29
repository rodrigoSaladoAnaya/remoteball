package remoteball

import org.vertx.java.core.Handler
import org.vertx.java.core.Vertx
import org.vertx.java.core.http.HttpServer
import org.vertx.java.core.http.HttpServerRequest
import org.vertx.java.core.json.JsonArray
import org.vertx.java.core.json.JsonObject
import org.vertx.java.core.sockjs.SockJSServer

class EventBusBridgeService {
    def vertxUtilsService

    void start() {
        Vertx vertx = vertxUtilsService.vertx
        HttpServer server = vertx.createHttpServer();

        server.requestHandler(new Handler<HttpServerRequest>() {
            public void handle(HttpServerRequest req) {
            }
        });

        JsonArray permitted = new JsonArray();
        permitted.add(new JsonObject()); //TODO: set a firewall

        SockJSServer sockJSServer = vertx.createSockJSServer(server);
        sockJSServer.bridge(new JsonObject().putString("prefix", "/eventbus").putNumber("session_timeout", 30), permitted, permitted);

        server.listen(5439);
        log.info "[vertx] Se cargo el eventBus para JavaScript"
    }
}
