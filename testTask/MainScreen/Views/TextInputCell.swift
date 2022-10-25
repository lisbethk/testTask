import Foundation
import UIKit

final class TextInputCell: UICollectionViewCell {
    static let reuseId = #file
    private let verticalStackView = UIStackView()
    private let horizontalStackView = UIStackView()
    private let deleteButton = UIButton(type: .system)
    private let topTextField = CellView()
    private let bottomTextField = CellView()
    private var tapHandler: (() -> Void)?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.titleLabel?.font = UIFont(name: "Arial", size: 17)
        deleteButton.addTarget(self, action: #selector(touch), for: .touchUpInside)
        
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(topTextField)
        verticalStackView.addArrangedSubview(bottomTextField)
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 4
        
        
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(deleteButton)
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    func configure(
        topTitle: String,
        bottomTitle: String,
        isButtonHidden: Bool,
        touch: @escaping () -> Void
    ) {
        topTextField.configure(text: topTitle)
        bottomTextField.configure(text: bottomTitle)
        deleteButton.isHidden = isButtonHidden
        tapHandler = touch
    }
    
    @objc private func touch() {
        tapHandler?()
    }
    
    override func prepareForReuse() {
        topTextField.reset()
        bottomTextField.reset()
    }
}
