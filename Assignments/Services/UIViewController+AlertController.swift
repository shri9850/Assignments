//
//  UIViewController+AlertController.swift
//  Assignments
//
//  Created by Shri's Mac Mini on 16/04/20.
//  Copyright © 2020 Redbytes. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func showAlert(title:String,msg:String,btnTitle:String) -> UIAlertController
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: .cancel, handler:
            nil))
        return alert;
    }
}
