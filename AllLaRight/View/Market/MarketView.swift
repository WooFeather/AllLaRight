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
    private let navigationView = NavigationTitleView(title: "거래소")
    let currentPriceView = MarketSortingView(title: "현재가")
    let compareToPreviousDayView = MarketSortingView(title: "전일대비")
    let tradePriceView = MarketSortingView(title: "거래대금")
    let marketTableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(navigationView)
        addSubview(marketTableView)
        addSubview(headerView)
        [coinNameLabel, currentPriceView, compareToPreviousDayView, tradePriceView].forEach {
            headerView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(30)
        }
        
        coinNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(15)
        }
        
        tradePriceView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(15)
        }
        
        compareToPreviousDayView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(tradePriceView.snp.leading).offset(-60)
            make.height.equalTo(15)
        }
        
        currentPriceView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(compareToPreviousDayView.snp.leading).offset(-24)
            make.height.equalTo(15)
        }
        
        marketTableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        headerView.backgroundColor = .themeTertiary
        
        coinNameLabel.text = "코인"
        coinNameLabel.font = ALRFont.headlineBold.font
        coinNameLabel.textColor = .themePrimary
        
        marketTableView.separatorStyle = .none
    }
}
