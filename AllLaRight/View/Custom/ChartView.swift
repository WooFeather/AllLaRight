//
//  ChartView.swift
//  AllLaRight
//
//  Created by 조우현 on 3/11/25.
//

import UIKit
import DGCharts
import SnapKit

final class ChartView: BaseView {
    let lineChartView = LineChartView()
    let timeData = Array(1...160)
    var priceData = Array(1100...1800)
    
    override func configureHierarchy() {
        addSubview(lineChartView)
    }
    
    override func configureLayout() {
        lineChartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        setLineChart(timeData: timeData, values: priceData)
    }
    
    private func setLineChart(timeData: [Int], values: [Int]){
        var dataEntities : [ChartDataEntry] = []
        
        for i in 0..<values.count {
            let value = ChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntities.append(value)
        }
        
        let line = ChartDatasetFactory().makeChartDataset(colorAsset: .first, entries: dataEntities)
        
        let line2 = LineChartDataSet(entries: dataEntities, label: "Number")
        line.colors = [UIColor.green,UIColor.blue,UIColor.purple]
        
        line.drawValuesEnabled = false
        
        let lindata = LineChartData(dataSet: line)
        lineChartView.data = lindata
        // disable grid
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.drawGridBackgroundEnabled = false
        // disable axis annotations
        lineChartView.xAxis.drawLabelsEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false
        // disable legend
        lineChartView.legend.enabled = false
        // disable zoom
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        // remove artifacts around chart area
        lineChartView.xAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.drawBordersEnabled = false
        lineChartView.minOffset = 0
        // setting up delegate needed for touches handling
//        lineChartView.delegate = self
    }
}

/// Factory preparing dataset for a single chart
struct ChartDatasetFactory {
    func makeChartDataset(
        colorAsset: DataColor,
        entries: [ChartDataEntry]
    ) -> LineChartDataSet {
        var dataSet = LineChartDataSet(entries: entries, label: "")

        // chart main settings
        dataSet.setColor(colorAsset.color)
        dataSet.lineWidth = 3
        dataSet.mode = .cubicBezier // curve smoothing
        dataSet.drawValuesEnabled = false // disble values
        dataSet.drawCirclesEnabled = false // disable circles
        dataSet.drawFilledEnabled = true // gradient setting

        // settings for picking values on graph
        dataSet.drawHorizontalHighlightIndicatorEnabled = false // leave only vertical line
        dataSet.highlightLineWidth = 2 // vertical line width
        dataSet.highlightColor = colorAsset.color // vertical line color

        addGradient(to: &dataSet, colorAsset: colorAsset)

        return dataSet
    }
}

private extension ChartDatasetFactory {
    func addGradient(
        to dataSet: inout LineChartDataSet,
        colorAsset: DataColor
    ) {
        let mainColor = colorAsset.color.withAlphaComponent(0.5)
        let secondaryColor = colorAsset.color.withAlphaComponent(0)
        let colors = [
            mainColor.cgColor,
            secondaryColor.cgColor,
            secondaryColor.cgColor
        ] as CFArray
        let locations: [CGFloat] = [0, 0.79, 1]
        if let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: colors,
            locations: locations
        ) {
            dataSet.fill = LinearGradientFill(gradient: gradient, angle: 270)
        }
    }
}

enum DataColor {
    case first
    case second
    case third

    var color: UIColor {
        switch self {
        case .first: return UIColor(red: 56/255, green: 58/255, blue: 209/255, alpha: 1)
        case .second: return UIColor(red: 235/255, green: 113/255, blue: 52/255, alpha: 1)
        case .third: return UIColor(red: 52/255, green: 235/255, blue: 143/255, alpha: 1)
        }
    }
}
