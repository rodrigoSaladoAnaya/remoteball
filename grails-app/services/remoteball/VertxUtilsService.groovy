package remoteball

import org.vertx.java.core.AsyncResult
import org.vertx.java.core.AsyncResultHandler
import org.vertx.java.core.Handler
import org.vertx.java.core.Vertx
import org.vertx.java.core.eventbus.EventBus
import org.vertx.java.core.eventbus.Message
import org.vertx.java.core.json.JsonObject

class VertxUtilsService {
    Vertx vertx
    EventBus eventBus

    void createVertxInsatance(Vertx _vertx) {
        vertx = _vertx
        eventBus = vertx.eventBus()
    }

    void registerHandler(String address, bodyHandler) {
        def resultHandler = new AsyncResultHandler<Void>() {
            @Override
            void handle(AsyncResult<Void> asyncResult) {
                if (asyncResult.succeeded()) {
                    log.info "The verticle '${address}' is loaded."
                } else {
                    log.error "Failure to load the verticle '${address}' for: ${asyncResult.cause()}."
                }
            }
        };
        def messageHandler = new Handler<Message<JsonObject>>() {
            void handle(Message<JsonObject> msg) {
                bodyHandler(msg)
            }
        }

        eventBus.registerHandler(address, messageHandler, resultHandler);
    }

    void send(String address, args, bodyHandler) {
        def messageHandler = new Handler<Message<JsonObject>>() {
            @Override
            void handle(Message<JsonObject> msg) {
                bodyHandler(msg)
            }
        }
        eventBus.send(address, args, messageHandler);
    }

    void sendWithTimeout(String address, args, timeout, bodyHandler) {
        def messageHandler = new Handler<AsyncResult<Message<JsonObject>>>() {
            @Override
            void handle(AsyncResult<Message<JsonObject>> result) {
                if (result.succeeded()) {
                    bodyHandler(result.result())
                } else {
                    log.error "The verticle '${address}' did not respond for: ${result.cause()}"
                }
            }
        }
        eventBus.sendWithTimeout(address, args, timeout, messageHandler);
    }
}
