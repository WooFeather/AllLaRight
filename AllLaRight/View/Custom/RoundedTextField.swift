//
//  RoundedTextField.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import UIKit
import SnapKit

final class RoundedTextField: BaseView {
    private let roundedBackground = UIView()
    private let magnifyingGlassImageView = UIImageView()
    let textField = UITextField()

    override func configureHierarchy() {
        addSubview(roundedBackground)
        roundedBackground.addSubview(magnifyingGlassImageView)
        roundedBackground.addSubview(textField)
    }
    
    override func configureLayout() {
        roundedBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        magnifyingGlassImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(20)
        }
        
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(magnifyingGlassImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        roundedBackground.layer.cornerRadius = 22
        roundedBackground.layer.borderWidth = 1
        roundedBackground.layer.borderColor = UIColor.themeSecondary.cgColor
        
        magnifyingGlassImageView.image = UIImage(systemName: "magnifyingglass")
        magnifyingGlassImageView.contentMode = .scaleAspectFill
        magnifyingGlassImageView.tintColor = .themeSecondary
        
        textField.placeholder = "검색어를 입력해주세요."
        textField.tintColor = .themeSecondary
        textField.textColor = .textPrimary
    }
}
