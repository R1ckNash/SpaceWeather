//
//  WeatherMainViewController.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 13/09/2024.
//

import Foundation
import UIKit

protocol WeatherMainViewControllerInput: AnyObject {
    func configure(state: ViewState)
}

final class WeatherMainViewController: BaseViewController {
    
    //MARK: - Properties
    private let interactor: WeatherMainInteractorInput
    
    //MARK: - UI
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        button.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var detailsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Details", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        button.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    init(interactor: WeatherMainInteractorInput) {
        self.interactor = interactor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        setupLayout()
        
        interactor.viewDidLoad()
    }
    
    
    //MARK: - Private methods
    private func setupLayout() {
        view.addSubview(updateButton)
        view.addSubview(detailsButton)
        
        NSLayoutConstraint.activate([
            detailsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        ])
    }
    
    @objc private func didTapDetailsButton() {
        interactor.didTapDetailsButton()
    }
    
    @objc private func didTapUpdateButton() {
        interactor.didTapUpdateButton()
    }
}

extension WeatherMainViewController: WeatherMainViewControllerInput {
    func configure(state: ViewState) {
        switch state {
        case .loading:
            showLoadingIndicator()
        case .error(let error):
            hideLoadingIndicator()
            showAlert(message: error.localizedDescription)
        case .content:
            hideLoadingIndicator()
        }
    }
}
