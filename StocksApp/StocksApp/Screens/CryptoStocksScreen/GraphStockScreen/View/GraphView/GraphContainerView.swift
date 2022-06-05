//
//  GraphContainerView.swift
//  StocksApp
//
//  Created by Arthur Lee on 05.06.2022.
//

import UIKit
import Charts

final class GraphContainerView: UIView {
    
    private var isHiddenAlphaValue: CGFloat = 0

    private lazy var weeklyGraphView: LineChartView = {
        
        let view = LineChartView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.xAxis.drawLabelsEnabled = false
        view.leftAxis.enabled = false
        view.leftAxis.drawGridLinesEnabled = false
        view.rightAxis.enabled = false
        view.rightAxis.drawGridLinesEnabled = false
        view.backgroundColor = .white
        view.alpha = isHiddenAlphaValue

        return view
    }()
    
    private lazy var monthlyGraphView: LineChartView = {
        
        let view = LineChartView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.xAxis.drawLabelsEnabled = false
        view.leftAxis.enabled = false
        view.leftAxis.drawGridLinesEnabled = false
        view.rightAxis.enabled = false
        view.rightAxis.drawGridLinesEnabled = false
        view.backgroundColor = .white
        view.alpha = isHiddenAlphaValue
        
        return view
    }()
    
    private lazy var halfYearGraphView: LineChartView = {
        
        let view = LineChartView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.xAxis.drawLabelsEnabled = false
        view.leftAxis.enabled = false
        view.leftAxis.drawGridLinesEnabled = false
        view.rightAxis.enabled = false
        view.rightAxis.drawGridLinesEnabled = false
        view.backgroundColor = .white
        view.alpha = isHiddenAlphaValue
        
        return view
    }()
    
    private lazy var oneYearGraphView: LineChartView = {
        
        let view = LineChartView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.xAxis.drawLabelsEnabled = false
        view.leftAxis.enabled = false
        view.leftAxis.drawGridLinesEnabled = false
        view.rightAxis.enabled = false
        view.rightAxis.drawGridLinesEnabled = false
        view.backgroundColor = .white
        view.alpha = 1
        view.noDataText = "Loading"
        
        return view
    }()
    
    private var buttonStackView: UIStackView = {
        
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with isLoading: Bool) {
        isLoading ? loader.startAnimating() : loader.stopAnimating()
        loader.isHidden = !isLoading
        buttonStackView.isHidden = isLoading
    }
    
    func configureGraph(with model: GraphModel) {
        addButtonsToStackView(for: model.periods.map { $0.name })
        setCharts(with: model.periods.first?.prices, chartView: weeklyGraphView)
        setCharts(with: model.periods[1].prices, chartView: monthlyGraphView)
        setCharts(with: model.periods[2].prices, chartView: halfYearGraphView)
        setCharts(with: model.periods.last?.prices, chartView: oneYearGraphView)
    }
    
    
    private func setUpSubViews() {
        oneYearGraphView.addSubview(loader)
        addSubview(weeklyGraphView)
        addSubview(monthlyGraphView)
        addSubview(halfYearGraphView)
        addSubview(oneYearGraphView)
        addSubview(buttonStackView)
        setUpConstraints()

    }
    
    private func setUpConstraints() {
        
        // graphic for week
        weeklyGraphView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        weeklyGraphView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        weeklyGraphView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        weeklyGraphView.heightAnchor.constraint(equalTo: weeklyGraphView.widthAnchor, multiplier: 26/36).isActive = true
        
        // graphic for month
        monthlyGraphView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        monthlyGraphView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        monthlyGraphView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthlyGraphView.heightAnchor.constraint(equalTo: monthlyGraphView.widthAnchor, multiplier: 26/36).isActive = true
        
        // graphic for 6 month
        halfYearGraphView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        halfYearGraphView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        halfYearGraphView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        halfYearGraphView.heightAnchor.constraint(equalTo: halfYearGraphView.widthAnchor, multiplier: 26/36).isActive = true
        
        // graphic for one year
        oneYearGraphView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        oneYearGraphView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        oneYearGraphView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        oneYearGraphView.heightAnchor.constraint(equalTo: halfYearGraphView.widthAnchor, multiplier: 26/36).isActive = true
        
        // button stackview
        buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        buttonStackView.topAnchor.constraint(equalTo: oneYearGraphView.bottomAnchor, constant: 40).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //loader
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: oneYearGraphView.centerYAnchor, constant: -20).isActive = true
    }
    
    private func addButtonsToStackView(for titles: [String]) {
        titles.enumerated().forEach { (index, title) in
            
            let button = UIButton()
            
            button.tag = index
            button.backgroundColor = UIColor(r: 240, g: 244, b: 247)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 12)
            button.layer.cornerRadius = 12
            button.layer.cornerCurve = .continuous
            button.addTarget(self, action: #selector(periodButtonTapped), for: .touchUpInside)
            
            switch button.tag {
            case 0:
                button.backgroundColor = UIColor(r: 240, g: 244, b: 247)
            case 1:
                button.backgroundColor = UIColor(r: 240, g: 244, b: 247)
            case 2:
                button.backgroundColor = UIColor(r: 240, g: 244, b: 247)
            case 3:
                button.backgroundColor = .black
                button.setTitleColor(.white, for: .normal)
            default:
                break
            }
            
            buttonStackView.addArrangedSubview(button)
        }
    }
    
    
    @objc private func periodButtonTapped(sender: UIButton) {
        
        buttonStackView.subviews.compactMap {
            $0 as? UIButton
        }.forEach { button in
            button.backgroundColor = UIColor(r: 240, g: 244, b: 247)
            button.setTitleColor(.black, for: .normal)
        }
        
        switch sender.tag {
        case 0:
            weeklyGraphView.alpha = 1
            monthlyGraphView.alpha = isHiddenAlphaValue
            halfYearGraphView.alpha = isHiddenAlphaValue
            oneYearGraphView.alpha = isHiddenAlphaValue
        case 1:
            weeklyGraphView.alpha = isHiddenAlphaValue
            monthlyGraphView.alpha = 1
            halfYearGraphView.alpha = isHiddenAlphaValue
            oneYearGraphView.alpha = isHiddenAlphaValue
        case 2:
            weeklyGraphView.alpha = isHiddenAlphaValue
            monthlyGraphView.alpha = isHiddenAlphaValue
            halfYearGraphView.alpha = 1
            oneYearGraphView.alpha = isHiddenAlphaValue
        case 3:
            weeklyGraphView.alpha = isHiddenAlphaValue
            monthlyGraphView.alpha = isHiddenAlphaValue
            halfYearGraphView.alpha = isHiddenAlphaValue
            oneYearGraphView.alpha = 1
        default:
            break
        }
        
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
        print("button tapped -", sender.tag)
    }
    
    private func setCharts(with prices: [Double]?, chartView: LineChartView) {
        guard let prices = prices else { return }
        var yValues = [ChartDataEntry]()
        for (index, value) in prices.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index + 1), y: value)
            yValues.append(dataEntry)
        }
        
        let lineDataSet = LineChartDataSet(entries: yValues, label: "$ USD")
        
        lineDataSet.valueFont = .boldSystemFont(ofSize: 10)
        lineDataSet.valueTextColor = .black
        lineDataSet.drawFilledEnabled = true
        lineDataSet.circleRadius = 3.0
        lineDataSet.circleHoleRadius = 2.0
        lineDataSet.drawCirclesEnabled = false
        lineDataSet.fillColor = .gray
        lineDataSet.mode = .cubicBezier
        lineDataSet.setColor(.black)
        lineDataSet.drawHorizontalHighlightIndicatorEnabled = false
        lineDataSet.drawVerticalHighlightIndicatorEnabled = false
        
        chartView.data = LineChartData(dataSets: [lineDataSet])
        chartView.data?.setDrawValues(false)
        chartView.animate(xAxisDuration: 0.3, yAxisDuration: 0.3)
    }
}


extension GraphContainerView: StockViewProtocol {
    func updateView(with graphModel: GraphModel) {
        configureGraph(with: graphModel)
    }

    
    func updateView(withLoader isLoading: Bool) {
        configure(with: isLoading)
    }
    
    func updateView(withError message: String) {
        
    }
}
