//
//  NavigationSearchView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/9/25.
//

import UIKit
import SnapKit

final class NavigationSearchView: BaseView {

    let backButton = UIButton()
    let searchTextField = UITextField()
    
    override func configureHierarchy() {
        addSubview(backButton)
        addSubview(searchTextField)
    }
    
    override func configureLayout() {
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(26)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(12)
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    override func configureView() {
        let backIcon = UIImage(systemName: "arrow.left")
        backButton.setImage(backIcon, for: .normal)
        backButton.tintColor = .themePrimary
        
        searchTextField.tintColor = .themeSecondary
        searchTextField.textColor = .themePrimary
    }
}
