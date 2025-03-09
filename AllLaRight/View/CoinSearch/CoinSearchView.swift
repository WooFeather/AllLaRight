//
//  CoinSearchView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/9/25.
//

import UIKit
import SnapKit

final class CoinSearchView: BaseView {
    let navigationView = NavigationSearchView()
    
    override func configureHierarchy() {
        addSubview(navigationView)
    }
    
    override func configureLayout() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
    }
}
