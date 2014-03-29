import org.vertx.java.platform.PlatformLocator

class BootStrap {
    def platformManager
    def vertxUtilsService

    def init = { servletContext ->
    }
    def destroy = {
    }

    void initVerticles() {
        platformManager = PlatformLocator.factory.createPlatformManager();
        vertxUtilsService.createVertxInsatance(platformManager.vertx())
    }
}
