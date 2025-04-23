//
//  NavigationSearchView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/9/25.
//

import UIKit
import SnapKit

final class NavigationSearchView: BaseView {

    private let separatorView = UIView()
    let backButton = UIButton()
    let searchTextField = UITextField()
    
    override func configureHierarchy() {
        addSubview(backButton)
        addSubview(searchTextField)
        addSubview(separatorView)
    }
    
    override func configureLayout() {
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(searchTextField.snp.centerY)
            make.size.equalTo(26)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(12)
            make.top.equalToSuperview()
            make.height.equalTo(44)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    override func configureView() {
        let backIcon = UIImage(systemName: "arrow.left")
        backButton.setImage(backIcon, for: .normal)
        backButton.tintColor = .textPrimary
        
        searchTextField.tintColor = .themeSecondary
        searchTextField.textColor = .textPrimary
        
        separatorView.backgroundColor = .black
    }
}
