import UIKit
import SnapKit

struct Item: Identifiable {
    var id = UUID()
}

enum Section: Int, CaseIterable {
    case person
    case kids
}

protocol MainScreenViewControllerProtocol {

    func showChildren(_ person: Item, _ children: [Item])
    func showAlert()
}

typealias MainScreenSnapshot = NSDiffableDataSourceSnapshot<Section, Item.ID>
typealias DataSource = UICollectionViewDiffableDataSource<Section, Item.ID>

final class MainScreenViewController: UIViewController, MainScreenViewControllerProtocol {
    
    let presenter: MainScreenPresenterProtocol
    
    func showChildren(_ person: Item, _ children: [Item]) {
        var snapshot = MainScreenSnapshot()
        snapshot.appendSections([.person, .kids])
        snapshot.appendItems([person.id], toSection: .person)
        snapshot.appendItems(children.map { $0.id }, toSection: .kids)
        dataSource.apply(snapshot)
    }
    
    func showAlert() {
        let allertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        allertController.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        allertController.addAction(UIAlertAction(title: "Сбросить данные", style: .destructive, handler:  {(action: UIAlertAction!) in
            self.presenter.didTapReset()
        } ))
        self.present(allertController, animated: true)
    }
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextInputCell.reuseId, for: indexPath)
            
            if let cell = cell as? TextInputCell {
                cell.configure(
                    topTitle: "Имя",
                    bottomTitle: "Возраст",
                    isButtonHidden: indexPath.section != 1,
                    touch: { [weak self] in self?.presenter.didTapDelete(id: itemIdentifier) }
                )
            }
            return cell
        }
        
        dataSource.supplementaryViewProvider = { collectionView, id, indexPath in
            
            if id == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: Header.reuseId,
                    for: indexPath
                )
                if let header = header as? Header {
                    let isButtonHidden: Bool
                    let text: String
                    if indexPath.section == 0 {
                        text = "Персональные данные"
                        isButtonHidden = true
                    } else {
                        text = "Дети(макс. 5)"
                        isButtonHidden = false
                    }
                    header.configure(
                        text: text,
                        isButtonHidden: isButtonHidden,
                        didTap: { [weak self] in self?.presenter.didTapAddChild() }
                    )
                }
                return header
            } else {
                let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: Footer.reuseId,
                    for: indexPath)
                if let footer = footer as? Footer {
                    footer.configure(didTap: { [weak self] in self?.showAlert() })
                }
                return footer
            }
        }
        return dataSource
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        var contentInsets = UIContentInsetsReference.automatic
        
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: { index, id in
                let size = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(50)
                )
            
                let item = NSCollectionLayoutItem(layoutSize: size)
                
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: size,
                    subitems: [item]
                )
                var section = NSCollectionLayoutSection(group: group)
                let headerFooterSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(55)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                let footer = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: UICollectionView.elementKindSectionFooter,
                    alignment: .bottom
                )
                
                // настройка по индексу, где показать header & footer
                if index == 0 {
                    section.boundarySupplementaryItems = [header]
                } else {
                    section.boundarySupplementaryItems = [header, footer]
                }
                return section
            }, configuration: configuration)
        
        let collectionView = UIButtonScrollView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            TextInputCell.self,
            forCellWithReuseIdentifier:TextInputCell.reuseId
        )
        collectionView.register(
            Header.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Header.reuseId
        )
        collectionView.register(
            Footer.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: Footer.reuseId
        )
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    //   MARK:  init
    init(presenter: MainScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// позволяет скроллить экран задевая вью кнопки удалить
final class UIButtonScrollView: UICollectionView {
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view.isKind(of: UIButton.self) {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
}
