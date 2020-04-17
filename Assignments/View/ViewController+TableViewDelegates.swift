//
//  ViewController+TableViewDelegates.swift
//  Assignments
//
//  Created by Shri's Mac Mini on 16/04/20.
//  Copyright © 2020 Redbytes. All rights reserved.
//

import UIKit
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell else {
            return ProductTableViewCell()
        }
        let resultData = rowData?[indexPath.row]
        cell.productNameLabel.text = resultData?["title"] as? String ?? ""
        cell.productDescriptionLabel.text = resultData?["description"] as? String ?? ""
        if let url = resultData?["imageHref"] as? String {
            cell.productImage.loadImageUsingCacheWithURLString(url, placeHolder: #imageLiteral(resourceName: "account")) { (bool) in
            }
        }
        
        return cell
    }
  
}
