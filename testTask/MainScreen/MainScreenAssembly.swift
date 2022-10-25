import Foundation
import UIKit

final class MainScreenAssembly {
    
    func assemble() -> UIViewController {
        let presenter = MainScreenPresenter()
        let viewController = MainScreenViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
