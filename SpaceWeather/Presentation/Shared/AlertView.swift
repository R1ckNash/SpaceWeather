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
    
    //MARK: - Properties
    private weak var view: UIViewController?
    
    //MARK: - Lifecycle
    init(view: UIViewController) {
        self.view = view
    }
}

//MARK: - Extension
extension AlertView: AlertViewProtocol {
    
    func showAlert(model: AlertModel) {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion?()
        }
        
        alert.addAction(action)
        view?.present(alert, animated: true, completion: nil)
    }
    
}
