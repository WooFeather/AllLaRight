//
//  MarketView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/6/25.
//

import UIKit
import SnapKit

final class MarketView: BaseView {
    private let headerView = UIView()
    private let coinNameLabel = UILabel()
    let currentPriceButton = UIButton()
    let compareToPreviousDayButton = UIButton()
    let transactionPriceButton = UIButton()
    let marketTableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(marketTableView)
        addSubview(headerView)
        [coinNameLabel, currentPriceButton, compareToPreviousDayButton, transactionPriceButton].forEach {
            headerView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        coinNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(21)
        }
        
        transactionPriceButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(21)
        }
        
        compareToPreviousDayButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(transactionPriceButton.snp.leading).offset(-20)
            make.height.equalTo(21)
        }
        
        currentPriceButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(compareToPreviousDayButton.snp.leading).offset(-20)
            make.height.equalTo(21)
        }
        
        marketTableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        headerView.backgroundColor = .themeTertiary
        
        coinNameLabel.text = "코인"
        coinNameLabel.font = .boldSystemFont(ofSize: 17)
        coinNameLabel.textColor = .themePrimary
        
        // TODO: 아래 버튼들 커스텀 및 configuration으로 이미지 설정 및 사이즈 조정
        currentPriceButton.setTitle("현재가", for: .normal)
        currentPriceButton.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .normal)
        currentPriceButton.setTitleColor(.themePrimary, for: .normal)
        currentPriceButton.tintColor = .themePrimary
        
        compareToPreviousDayButton.setTitle("전일대비", for: .normal)
        compareToPreviousDayButton.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .normal)
        compareToPreviousDayButton.setTitleColor(.themePrimary, for: .normal)
        compareToPreviousDayButton.tintColor = .themePrimary
        
        transactionPriceButton.setTitle("거래대금", for: .normal)
        transactionPriceButton.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .normal)
        transactionPriceButton.setTitleColor(.themePrimary, for: .normal)
        transactionPriceButton.tintColor = .themePrimary
        
        marketTableView.backgroundColor = .lightGray
    }
}
