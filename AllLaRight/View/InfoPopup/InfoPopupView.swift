//
//  InfoPopupView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/11/25.
//

import UIKit
import SnapKit

final class InfoPopupView: BaseView {

    private let backgroundView = UIView()
    private let dividerView = UIView()
    private let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let retryButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(backgroundView)
        [dividerView, titleLabel, descriptionLabel, retryButton].forEach {
            backgroundView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(260)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(dividerView.snp.top).offset(-16)
        }
        
        dividerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(retryButton.snp.top)
            make.height.equalTo(1)
        }
        
        retryButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        backgroundView.backgroundColor = .themeTertiary
        
        titleLabel.text = "안내"
        titleLabel.font = ALRFont.headlineBold.font
        titleLabel.textColor = .themePrimary
        
        descriptionLabel.text = "네트워크 연결이 일시적으로 원활하지 않습니다. 데이터 또는 Wi-Fi 연결 상태를 확인해주세요."
        descriptionLabel.font = ALRFont.headline.font
        descriptionLabel.textColor = .themePrimary
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        dividerView.backgroundColor = .themeSecondary
        
        retryButton.setTitle("다시 시도하기", for: .normal)
        retryButton.setTitleColor(.themePrimary, for: .normal)
        retryButton.titleLabel?.font = ALRFont.headlineBold.font
        retryButton.titleLabel?.textAlignment = .center
    }
}
