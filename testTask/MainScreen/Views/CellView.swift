import Foundation
import UIKit

final class CellView: UIView {
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .lightGray
        return nameLabel
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    private lazy var frameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        addSubview(frameView)
        frameView.addSubview(textField)
        frameView.addSubview(nameLabel)
        
        frameView.snp.makeConstraints { make in
            make.width.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(7)
            make.left.equalToSuperview().offset(10)
            make.bottom.right.equalToSuperview().inset(10)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
        }
    }
    
    func configure(text: String) {
        nameLabel.text = text
    }
    
    func reset() {
        textField.text = .none
    }
}
