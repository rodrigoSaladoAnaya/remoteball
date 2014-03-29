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
                log.info "move to right ${body.px} px"
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
                log.info "move to left ${body.px} px"
            }
        })
    }
}
