//
//  BaseViewController.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var alertView: AlertViewProtocol = {
        return AlertView(delegate: self)
    }()
    
    //MARK: - UI
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .large
        
        return indicator
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    //MARK: - Private methods
    private func setupLayout() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    //MARK: - Public methods
    
    func showAlert(message: String) {
        let alertModel = AlertModel(
            title: "Error",
            message: message,
            buttonText: "OK",
            completion: nil
        )
        alertView.showAlert(model: alertModel)
    }
}
