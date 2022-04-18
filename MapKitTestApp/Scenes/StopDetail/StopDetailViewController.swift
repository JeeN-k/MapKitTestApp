//
//  StopDetailViewController.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 15.04.2022.
//

import UIKit
import MapKit

class StopDetailViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        return mapView
    }()
    
    private var bottomSheet: BottomSheetViewController?
    
    let viewModel: StopDetailViewModel
    
    init(viewModel: StopDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.fetchDetailStop { errorText in
            if let errorText = errorText {
                self.showAlertWith(text: errorText)
            } else {
                self.updateData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mapView.frame = view.bounds
        bottomSheet?.view.frame = CGRect(x: 0,
                                         y: view.frame.maxY,
                                         width: view.frame.width,
                                         height: view.frame.height)
    }
}

extension StopDetailViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
    }
    
    private func addBottomSheet() {
        bottomSheet = viewModel.makeBottomSheet()
        if let bottomSheet = bottomSheet {
            self.addChild(bottomSheet)
            view.addSubview(bottomSheet.view)
            bottomSheet.didMove(toParent: self)
        }
    }
    
    private func updateData() {
        guard let stopDetail = viewModel.stopDetail else { return }
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: stopDetail.lat, longitude: stopDetail.lon)
        let location = CLLocation(latitude: stopDetail.lat, longitude: stopDetail.lon)
        mapView.addAnnotation(point)
        mapView.centerToLocation(location)
        addBottomSheet()
    }
}

extension StopDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}

extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 600) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: false)
    }
}
