import Foundation

protocol MainScreenPresenterProtocol {
    func viewDidLoad()
    func didTapAddChild()
    func didTapReset()
    func didTapDelete(id: UUID)
}

final class MainScreenPresenter: MainScreenPresenterProtocol {
    
    weak var view: MainScreenViewController?
    
    private var person = Item()
    private var children = [Item()]

    func didTapAddChild() {
        if children.count < 5 {
            children.append(Item())
            self.view?.showChildren(person, children)
        }
    }
    
    func didTapReset() {
        children = [Item()]
        person = Item()
        self.view?.showChildren(person, children)
    }
    
    func didTapDelete(id: UUID) {
        let filtered = children.filter( { $0.id != id } )
        children = filtered
        self.view?.showChildren(person, children)
    }
    
    func viewDidLoad() {
        view?.showChildren(person, children)
    }
}
