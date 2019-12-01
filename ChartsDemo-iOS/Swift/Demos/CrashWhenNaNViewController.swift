//
//  ScatterChartViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif
import Charts

class CrashWhenNaNViewController: UIViewController {
    
    var chartView: ScatterChartView!
    
    @objc func valueChanged(_ sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.setDataCount(50, range: 100)
        case 1:
            self.setDataCount(0, range: 100)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Crash When NaN"
        self.navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        chartView = ScatterChartView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight * 3 / 4))
        view.addSubview(chartView)
        
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.maxVisibleCount = 200
        chartView.pinchZoomEnabled = true
        chartView.viewPortHandler.setMinMaxScaleX(minScaleX: 0.5, maxScaleX: 5.0)
        chartView.viewPortHandler.setMinMaxScaleY(minScaleY: 0.2, maxScaleY: 2.0)
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        l.font = .systemFont(ofSize: 10, weight: .light)
        l.xOffset = 5
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 100
        chartView.rightAxis.enabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.axisMaximum = 100
        xAxis.axisMinimum = 0
        
        
        let segmentedControl = UISegmentedControl(items: ["Show Data", "No Data and zoom"])
        view.addSubview(segmentedControl)
        segmentedControl.frame = CGRect(x: 0, y: chartView.frame.maxY, width: screenWidth, height: 40)
        segmentedControl.addTarget(self, action: #selector(valueChanged(_:)), for: UIControl.Event.valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        valueChanged(segmentedControl)
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let values1 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let values2 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i) + 0.33, y: val)
        }
        let values3 = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i) + 0.66, y: val)
        }

        
        let set1 = ScatterChartDataSet(entries: values1, label: "DS 1")
        set1.setScatterShape(.square)
        set1.setColor(ChartColorTemplates.colorful()[0])
        set1.scatterShapeSize = 8
        
        let set2 = ScatterChartDataSet(entries: values2, label: "DS 2")
        set2.setScatterShape(.circle)
        set2.scatterShapeHoleColor = ChartColorTemplates.colorful()[3]
        set2.scatterShapeHoleRadius = 3.5
        set2.setColor(ChartColorTemplates.colorful()[1])
        set2.scatterShapeSize = 8
        
        let set3 = ScatterChartDataSet(entries: values3, label: "DS 3")
        set3.setScatterShape(.cross)
        set3.setColor(ChartColorTemplates.colorful()[2])
        set3.scatterShapeSize = 8
        
        let data = ScatterChartData(dataSets: [set1, set2, set3])
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))

        chartView.data = data
    }
}
