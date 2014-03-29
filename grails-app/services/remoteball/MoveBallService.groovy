package remoteball

class MoveBallService {
    def vertxUtilsService

    def moveBallToRight() {
        vertxUtilsService.registerHandler('move-ball', { msg ->
            log.info "test right: ${msg.body()}"
            msg.reply("reply right")
        })
    }

    def moveBallToLeft() {
        vertxUtilsService.registerHandler('move-ball', { msg ->
            log.info "test left: ${msg.body()}"
            msg.reply("reply left")
        })
    }
}
