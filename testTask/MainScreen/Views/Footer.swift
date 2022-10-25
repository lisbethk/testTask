import Foundation
import UIKit

final class Footer: UICollectionReusableView {
    static let reuseId = "Footer"
    private let deleteButton = UIButton()
    private var tapHandler: (() -> Void)?
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubview(deleteButton)
        deleteButton.setTitle("Очистить", for: .normal)
        deleteButton.layer.cornerRadius = 22
        deleteButton.setTitleColor(UIColor.systemRed, for: .normal)
        deleteButton.layer.borderColor = UIColor.systemRed.cgColor
        deleteButton.layer.borderWidth = 1
        
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        deleteButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private struct Model {
        let text: String
    }
    
    func configure(didTap: @escaping () -> Void) {
        tapHandler = didTap
    }
    
    @objc private func didTap(sender: UIButton) {
        tapHandler?()
    }
}
