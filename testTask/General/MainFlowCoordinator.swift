import Foundation
import UIKit

final class MainFlowCoordinator {
    
    private lazy var mainScreenAssembly = MainScreenAssembly()
    private weak var rootViewController: UIViewController?
    
    func start(from window: UIWindow) {
        let rootViewController = mainScreenAssembly.assemble()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.rootViewController = rootViewController
    }
}
