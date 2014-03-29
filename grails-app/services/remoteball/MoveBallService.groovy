package remoteball

import org.vertx.java.core.json.JsonObject

class MoveBallService {
    def vertxUtilsService

    def moveBallToRight() {
        vertxUtilsService.registerHandler('move-ball', { msg ->
            def body = msg.body().toMap()
            if (body.code == 39) {
                vertxUtilsService.publish('apply-move-to-right', [
                        px: body.px
                ] as JsonObject)
            }
        })
    }

    def moveBallToLeft() {
        vertxUtilsService.registerHandler('move-ball', { msg ->
            def body = msg.body().toMap()
            if (body.code == 37) {
                vertxUtilsService.publish('apply-move-to-left', [
                        px: body.px
                ] as JsonObject)
            }
        })
    }

    def moveBallToUp() {
        vertxUtilsService.registerHandler('move-ball', { msg ->
            def body = msg.body().toMap()
            if (body.code == 38) {
                vertxUtilsService.publish('apply-move-to-up', [
                        px: body.px
                ] as JsonObject)
            }
        })
    }

    def moveBallToDown() {
        vertxUtilsService.registerHandler('move-ball', { msg ->
            def body = msg.body().toMap()
            if (body.code == 40) {
                vertxUtilsService.publish('apply-move-to-down', [
                        px: body.px
                ] as JsonObject)
            }
        })
    }
}
