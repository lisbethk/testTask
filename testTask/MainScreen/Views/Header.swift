import Foundation
import UIKit

final class Header: UICollectionReusableView {
    
    static let reuseId = "Header"
    private var titleLabel = UILabel()
    private let stackView = UIStackView()
    private let button = UIButton()
    private var tapHandler: (() -> Void)?
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(button)
        stackView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
        
        var configuration = UIButton.Configuration.borderless()
        configuration.title = "Добавить ребенка"
        configuration.baseForegroundColor = UIColor.systemBlue
        configuration.contentInsets = .init(top: 0, leading: 30, bottom: 0, trailing: 30)
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 22
        button.configuration = configuration
        titleLabel.font = UIFont(name: "Arial", size: 20)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, isButtonHidden: Bool, didTap: @escaping () -> Void) {
        titleLabel.text = text
        button.isHidden = isButtonHidden
        tapHandler = didTap
    }
    
    @objc private func didTap(sender: UIButton) {
        tapHandler?()
    }
}
