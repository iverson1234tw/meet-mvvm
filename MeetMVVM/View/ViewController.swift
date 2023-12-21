//
//  ViewController.swift
//  MeetMVVM
//
//  Created by Josh on 2023/12/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // tableView lazy init
    lazy var tableView: UITableView = {
        
        // tableView init
        let tableView = UITableView()
        
        // tableView properties
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        tableView.delaysContentTouches = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        
        return tableView
    }()
    
    // viewModel init
    private var viewModel = UserViewModel()
    
    // users init
    private var users: [User] = []
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add table to view
        view.addSubview(tableView)
        
    }

    // MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // tableView constraints
        tableView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
    }

}

// MARK: - [ UITableViewDelegate ]
extension ViewController: UITableViewDelegate {
    
    // TODO: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}

// MARK: - [ UITableViewDataSource ]
extension ViewController: UITableViewDataSource {
    
    // TODO: numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    // TODO: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    // TODO: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // CellIdentifier init
        let CellIdentifier = "Cell\(indexPath.section)\(indexPath.row)"
        
        // cell init
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
                        
        // if cell == nil
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: CellIdentifier)
        }
        
        return cell!
    }
    
}
