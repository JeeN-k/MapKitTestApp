//
//  RouteCell.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 18.04.2022.
//

import UIKit

final class RouteCell: UICollectionViewCell {
    
    static let identifier = "routeCell"
    private lazy var routeNumCard: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private lazy var routeNumLabel: UILabel = {
        let label = UILabel()
        label.text = "121"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var waitTime: UILabel = {
        let label = UILabel()
        label.text = "1m"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    var viewModel: RouteCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            routeNumCard.backgroundColor = viewModel.route.color.hexStringToUIColor()
            routeNumLabel.text = viewModel.route.number
            routeNumLabel.textColor = viewModel.route.fontColor.hexStringToUIColor()
            waitTime.text = viewModel.route.timeArrival.first ?? "Н/Д"
            if viewModel.route.byTelemetry == 1 {
                waitTime.textColor = .systemGreen
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(routeNumCard)
        addSubview(routeNumLabel)
        addSubview(waitTime)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        routeNumCard.layer.cornerRadius = 5
        
        routeNumCard.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        routeNumLabel.frame = CGRect(x: routeNumCard.frame.minX + 2,
                                     y: 5,
                                     width: 56,
                                     height: 20)
        
        waitTime.frame = CGRect(x: 2,
                                y: routeNumCard.frame.maxY + 3,
                                width: routeNumCard.frame.width - 4,
                                height: 20)
    }
}
