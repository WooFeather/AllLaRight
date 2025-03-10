//
//  CoinDetailView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/9/25.
//

import UIKit
import SnapKit

class CoinDetailView: BaseView {
    let navigationView = NavigationDetailView()
    let detailTableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(navigationView)
        addSubview(detailTableView)
    }
    
    override func configureLayout() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        detailTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        detailTableView.backgroundColor = .lightGray
    }
}
