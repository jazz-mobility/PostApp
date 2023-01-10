//
//  UIViewController+Alert.swift
//  PostApp
//
//  Created by Jasveer Singh on 10.01.23.
//

import UIKit

extension UIViewController {
    func showAlert(text: String) {
        let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .destructive))
        present(alertController, animated: true)
    }
}
