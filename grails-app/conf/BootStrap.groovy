import org.vertx.java.platform.PlatformLocator

class BootStrap {
    def platformManager
    def vertxUtilsService
    def moveBallService
    def eventBusBridgeService

    def init = { servletContext ->
        initGrailsVerticles()
    }
    def destroy = {
    }

    void initGrailsVerticles() {
        platformManager = PlatformLocator.factory.createPlatformManager();
        vertxUtilsService.createVertxInsatance(platformManager.vertx())

        eventBusBridgeService.start()
        moveBallService.moveBallToRight()
        moveBallService.moveBallToLeft()
    }
}
