//
//  AlertView.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import Foundation
import UIKit

protocol AlertViewProtocol {
    func showAlert(model: AlertModel)
}

final class AlertView {
    
    private weak var delegate: UIViewController?
    
    init(delegate: UIViewController) {
        self.delegate = delegate
    }
}

extension AlertView: AlertViewProtocol {
    
    func showAlert(model: AlertModel) {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion?()
        }
        
        alert.addAction(action)
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.present(alert, animated: true, completion: nil)
        }
    }
}
