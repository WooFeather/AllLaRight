//
//  CoinInfoView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/7/25.
//

import UIKit
import SnapKit

final class CoinInfoView: BaseView {
    
    let searchTextField = RoundedTextField()
    
    override func configureHierarchy() {
        addSubview(searchTextField)
    }
    
    override func configureLayout() {
        searchTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        
    }
}
