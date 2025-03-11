//
//  DetailChartTableViewCell.swift
//  AllLaRight
//
//  Created by 조우현 on 3/10/25.
//

import UIKit
import DGCharts
import SnapKit

final class DetailChartTableViewCell: BaseTableViewCell {
    private let currentPriceLabel = UILabel()
    private let changePercentageView = ChangePercentageView()
    private let lineChartView = LineChartView()
    private let updateLabel = UILabel()
    
    override func configureHierarchy() {
        [currentPriceLabel, changePercentageView, lineChartView, updateLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        currentPriceLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.height.equalTo(24)
        }
        
        changePercentageView.snp.makeConstraints { make in
            make.top.equalTo(currentPriceLabel.snp.bottom).offset(4)
            make.leading.equalTo(currentPriceLabel.snp.leading)
            make.height.equalTo(12)
            make.trailing.equalTo(currentPriceLabel.snp.trailing)
        }
        
        lineChartView.snp.makeConstraints { make in
            make.top.equalTo(changePercentageView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(260)
        }
        
        updateLabel.snp.makeConstraints { make in
            make.top.equalTo(lineChartView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(12)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    override func configureView() {
        currentPriceLabel.font = .boldSystemFont(ofSize: 21)
        currentPriceLabel.textColor = .themePrimary
        
        updateLabel.font = ALRFont.body.font
        updateLabel.textColor = .themeSecondary
    }
    
    func configureData(data: DetailData) {
        setLineChart(values: data.sparklineIn7d?.price ?? [])
        
        currentPriceLabel.text = data.currentPrice.toWonString()
        
        updateLabel.text = data.lastUpdated.toDate()?.toString(dateFormat: "M/d HH:mm:ss 업데이트")
        
        // 등락뷰 세팅
        guard let changeRate = data.priceChangePercentage24h else {
            changePercentageView.iconImageView.image = UIImage()
            changePercentageView.changeRateLabel.text = ""
            return
        }
        
        let riseIcon = UIImage(systemName: "arrowtriangle.up.fill")
        let fallIcon = UIImage(systemName: "arrowtriangle.down.fill")
        
        changePercentageView.changeRateLabel.text = changeRate.toABSString()
        
        if changeRate > 0 {
            changePercentageView.iconImageView.image = riseIcon
            changePercentageView.iconImageView.tintColor = .chartRise
            changePercentageView.changeRateLabel.textColor = .chartRise
        } else if changeRate < 0 {
            changePercentageView.iconImageView.image = fallIcon
            changePercentageView.iconImageView.tintColor = .chartFall
            changePercentageView.changeRateLabel.textColor = .chartFall
        } else {
            changePercentageView.iconImageView.image = UIImage()
            changePercentageView.iconImageView.tintColor = .themePrimary
            changePercentageView.changeRateLabel.textColor = .themePrimary
        }
    }
    
    private func setLineChart(values: [Double]) {
        var dataEntities: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            let value = ChartDataEntry(x: Double(i), y: values[i])
            dataEntities.append(value)
        }
        
        let line = ChartDatasetFactory().makeChartDataset(colorAsset: .chartFall, entries: dataEntities)
        
        line.colors = [UIColor.chartFall]
        
        line.drawValuesEnabled = false
        
        let lindata = LineChartData(dataSet: line)
        lineChartView.data = lindata
        // grid 비활성화
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.drawGridBackgroundEnabled = false
        // 축 표시 비활성화
        lineChartView.xAxis.drawLabelsEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false
        // legend 비활성화
        lineChartView.legend.enabled = false
        // zoom 비활성화
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        // 기타 표시데이터 제거
        lineChartView.xAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.drawBordersEnabled = false
        lineChartView.minOffset = 0
        // 터치 이벤트 활성화 대비
        // lineChartView.delegate = self
    }
}

// MARK: - Chart Setting
struct ChartDatasetFactory {
    func makeChartDataset(
        colorAsset: UIColor,
        entries: [ChartDataEntry]
    ) -> LineChartDataSet {
        var dataSet = LineChartDataSet(entries: entries, label: "")
        
        // chart main settings
        dataSet.setColor(.chartFall)
        dataSet.lineWidth = 3
        dataSet.mode = .cubicBezier // 부드러운 곡선
        dataSet.drawValuesEnabled = false // 값 비활성화
        dataSet.drawCirclesEnabled = false // circles 비활성화
        dataSet.drawFilledEnabled = true // 그라데이션 세팅
        
        addGradient(to: &dataSet)
        
        return dataSet
    }
}

// 그라데이션 세팅
private extension ChartDatasetFactory {
    func addGradient(
        to dataSet: inout LineChartDataSet
    ) {
        let mainColor = UIColor.chartFall.withAlphaComponent(1)
        let secondaryColor = UIColor.chartFall.withAlphaComponent(0.7)
        let tertiaryColor = UIColor.chartFall.withAlphaComponent(0.3)
        let colors = [
            mainColor.cgColor,
            secondaryColor.cgColor,
            tertiaryColor.cgColor
        ] as CFArray
        let locations: [CGFloat] = [0, 0.7, 1]
        if let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: colors,
            locations: locations
        ) {
            dataSet.fill = LinearGradientFill(gradient: gradient, angle: 270)
        }
    }
}
