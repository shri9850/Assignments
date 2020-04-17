//
//  ViewController.swift
//  Assignments
//
//  Created by Shri's Mac Mini on 16/04/20.
//  Copyright © 2020 Redbytes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let refreshControl = UIRefreshControl()
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var titles: String? {
        didSet{
            DispatchQueue.main.async {
                self.title = self.titles
            }
        }
    }
    var rowData: [[String:Any]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureTableView()
    }
    func getData(){
        if(Reachability.isConnectedToNetwork() == false)
        {
            self.present(self.showAlert(title: "", msg: "No Internet Connection", btnTitle: "OK"), animated: true, completion: nil)
            return;
        }
        let apiString = "\(Constant.kBASE_URL)facts.json"
        guard let url = URL(string: apiString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{
                let str = String(data:dataResponse, encoding: .isoLatin1)
                let data8 = str?.data(using: .utf8)
                let jsonResult = try JSONSerialization.jsonObject(with: data8!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                let result = ResultData.init(title: jsonResult?.value(forKey: "title") as? String ?? "", rowsData: jsonResult?.value(forKey: "rows") as? [[String:Any]] ?? [[:]])
                self.titles = result.title
                self.rowData = result.rowsData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
               print(result)
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
    }
    func configureTableView() {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        let cellId = "ProductTableViewCell"
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: cellId)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    @objc private func refreshData(_ sender: Any) {
        if(Reachability.isConnectedToNetwork() == false)
        {
            self.present(self.showAlert(title: "", msg: "No Internet Connection", btnTitle: "OK"), animated: true, completion: nil)
            return;
        }
        getData()
    }
    func setUpUi(){
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        view.addSubview(tableView)
        let cellId = "ProductTableViewCell"
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

}

