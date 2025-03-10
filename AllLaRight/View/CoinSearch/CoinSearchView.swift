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
    let searchTableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(navigationView)
        addSubview(searchTableView)
    }
    
    override func configureLayout() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        searchTableView.separatorStyle = .none
    }
}
