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
        return AlertView(view: self)
    }()
    
    //MARK: - UI
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .gray
        
        return indicator
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Private methods
    private func configureUI() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    //MARK: - Public methods
    func showAlert(title: String, message: String, buttonText: String, completion: (() -> Void)?) {
        let alertModel = AlertModel(
            title: title,
            message: message,
            buttonText: buttonText,
            completion: completion
        )
        alertView.showAlert(model: alertModel)
    }
    
}
