//
//  UIViewController+Alert.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 18.04.2022.
//

import UIKit

extension UIViewController {
    func showAlertWith(text: String) {
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        present(alert, animated: true)
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            alert.dismiss(animated: true)
        }
    }
}
