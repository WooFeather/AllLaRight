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
//    let segmentControl = UnderlineSegmentControl(items: ["코인", "NFT", "거래소"])
    let searchTableView = UITableView()
    let nftSearchView = UIView()
    let marketSearchView = UIView()
    
//    var showFirstView: Bool? {
//        didSet {
//            guard let showFirstView = self.showFirstView else { return }
//            searchTableView.isHidden = !showFirstView
//            nftSearchView.isHidden = showFirstView
//            marketSearchView.isHidden = showFirstView
//        }
//    }
//    
//    var showSecondView: Bool? {
//        didSet {
//            guard let showSecondView = self.showSecondView else { return }
//            searchTableView.isHidden = showSecondView
//            nftSearchView.isHidden = !showSecondView
//            marketSearchView.isHidden = showSecondView
//        }
//    }
//    
//    var showThirdView: Bool? {
//        didSet {
//            guard let showThirdView = self.showThirdView else { return }
//            searchTableView.isHidden = showThirdView
//            nftSearchView.isHidden = showThirdView
//            marketSearchView.isHidden = !showThirdView
//        }
//    }
    
    override func configureHierarchy() {
        [navigationView, searchTableView, nftSearchView, marketSearchView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
//        segmentControl.snp.makeConstraints { make in
//            make.top.equalTo(navigationView.snp.bottom)
//            make.horizontalEdges.equalToSuperview()
//            make.height.equalTo(44)
//        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.horizontalEdges.equalTo(navigationView.snp.horizontalEdges)
            make.bottom.equalToSuperview()
        }
        
//        nftSearchView.snp.makeConstraints { make in
//            make.edges.equalTo(searchTableView.snp.edges)
//        }
//        
//        marketSearchView.snp.makeConstraints { make in
//            make.edges.equalTo(searchTableView.snp.edges)
//        }
    }
    
    override func configureView() {
//        segmentControl.selectedSegmentIndex = 0
//        segmentControl.backgroundColor = .backgroundSecondary
        searchTableView.backgroundColor = .themeBackground
        searchTableView.separatorStyle = .none
        nftSearchView.backgroundColor = .chartFall
        marketSearchView.backgroundColor = .chartRise
    }
    
    func controlContentView(with segmentIndex: Int) {
        [searchTableView, nftSearchView, marketSearchView].enumerated().forEach { index, view in
            if segmentIndex == index {
                view.isHidden = false
            } else {
                view.isHidden = true
            }
        }
    }
}
