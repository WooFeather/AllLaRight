//
//  NavigationTitleView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit
import SnapKit

final class NavigationTitleView: BaseView {
    
    private let titleLabel = UILabel()
    private let separatorView = UIView()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
    }
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(separatorView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(44)
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    override func configureView() {
        titleLabel.textColor = .themePrimary
        titleLabel.font = .boldSystemFont(ofSize: 21)
        
        separatorView.backgroundColor = .themeTertiary
    }
}
