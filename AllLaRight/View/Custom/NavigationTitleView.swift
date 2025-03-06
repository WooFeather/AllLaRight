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
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
    }
    
    override func configureHierarchy() {
        addSubview(titleLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        titleLabel.textColor = .themePrimary
        titleLabel.font = .boldSystemFont(ofSize: 21)
    }
}
