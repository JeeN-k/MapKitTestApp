//
//  BottomSheetViewController.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 15.04.2022.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    private lazy var dragView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var stopNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "Stop name text"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var routesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 64, height: 60)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RouteCell.self, forCellWithReuseIdentifier: RouteCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.layer.opacity = 0
        return collectionView
    }()
    
    var fullView: CGFloat = UIScreen.main.bounds.height / 1.3
    
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 100
    }
    
    let viewModel: BottomSheetViewModel
    init(viewModel: BottomSheetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let frame = self.view.frame
        self.view.frame = CGRect(x: 0, y: self.partialView, width: frame.width, height: frame.height)
        
        dragView.frame = CGRect(x: view.frame.midX - 40, y: 20, width: 80, height: 5)
        dragView.layer.cornerRadius = 2.5
        
        let stopNameSize = stopNameLabel.sizeThatFits(CGSize(width: view.frame.width - 30, height: 200))
        stopNameLabel.frame = CGRect(x: 20,
                                     y: dragView.frame.maxY + 10,
                                     width: stopNameSize.width,
                                     height: stopNameSize.height)
        routesCollectionView.frame = CGRect(x: 20, y: stopNameLabel.frame.maxY + 10,
                                            width: view.frame.width - 30,
                                            height: 80)
        
        fullView = UIScreen.main.bounds.height - (stopNameSize.height + 10 + 20 + 80 + 50)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
        
        prepareView()
    }
    
    
    @objc
    func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let velocity = recognizer.velocity(in: view)
        let y = view.frame.minY
        if ( y + translation.y >= fullView) && (y + translation.y <= partialView ) {
            view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
        
        if recognizer.state == .ended {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0,
                                             y: self.partialView,
                                             width: self.view.frame.width,
                                             height: self.view.frame.height)
                    self.routesCollectionView.layer.opacity = 0
                } else {
                    self.view.frame = CGRect(x: 0,
                                             y: self.fullView,
                                             width: self.view.frame.width,
                                             height: self.view.frame.height)
                    self.routesCollectionView.layer.opacity = 1
                }
                
            }, completion: nil)
        }
    }
    
    func prepareView() {
        view.layer.cornerRadius = 12
        view.backgroundColor = .secondarySystemBackground
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 10
        view.addSubview(stopNameLabel)
        view.addSubview(routesCollectionView)
        view.addSubview(dragView)
        
        stopNameLabel.text = viewModel.stopDetail?.name
    }
}

extension BottomSheetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.stopDetail?.routePath.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RouteCell.identifier,
                                                      for: indexPath) as! RouteCell
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }
}

extension BottomSheetViewController: UICollectionViewDelegate {
    
}
