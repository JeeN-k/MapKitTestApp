//
//  StopListViewController.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 15.04.2022.
//

import UIKit

class StopListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let viewModel: StopListViewModelProtocol
    
    init(viewModel: StopListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.fetchStops {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension StopListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.stops[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension StopListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = viewModel.makeDetailViewController(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension StopListViewController {
    private func configureView() {
        title = "Остановки"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
    }
}

