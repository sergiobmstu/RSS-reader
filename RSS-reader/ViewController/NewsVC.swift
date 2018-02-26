//
//  ViewController.swift
//  RSS-reader
//
//  Created by Sergey on 20.02.2018.
//  Copyright © 2018 Sergey Kochetov. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Variables
    private var presenter: Presenter?
    private let kNewsCellReuseID = "kNewsCellReuseID"
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.presenter == nil {
            DependencyInjector.assignPresenter(view: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.provideDate()
    }
    
    // MARK: - Private
    private func configureView() {
        let kNewsCellNIB = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(kNewsCellNIB, forCellReuseIdentifier: kNewsCellReuseID)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
    }
}

// MARK: - UITableViewDelegate
extension NewsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell else { return }
        guard let model = presenter?.getModel(atIndexPath: indexPath) as? News else { return }
        model.isOpen = !model.isOpen
        tableView.beginUpdates()
        cell.descriptionTextView.text = model.isOpen ? model.description : ""
        tableView.endUpdates()
        if model.isOpen == true {
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension NewsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter?.numberOfModel(inSection: section) else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kNewsCellReuseID) as! NewsTableViewCell
        let model = presenter?.getModel(atIndexPath: indexPath) as! News
        cell.model = model
        cell.descriptionTextView.text = model.isOpen ? model.description : ""
        return cell
    }
}

// MARK: - ViewProtocol
extension NewsVC: ViewProtocol {
    
    func assignPresenter(presenter: Presenter) {
        self.presenter = presenter
        presenter.viewLoaded(view: self)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func handleErrorCode(_ code: Int) {
        let alert = UIAlertController(title: "Error \(code)", message: "Check your internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

