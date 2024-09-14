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
    
    //MARK: - UI Elements
    private let backgroundView: UILabel = UILabel()
    private let updateButton: UIButton = UIButton()
    private let detailsButton: UIButton = UIButton()
    private let cityNameLabel: UILabel = UILabel()
    private let temperatureLabel: UILabel = UILabel()
    private let weatherIconImageView: UIImageView = UIImageView()
    
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
        
        configureUI()
        interactor.viewDidLoad()
    }
    
    //MARK: - Private methods
    @objc private func didTapDetailsButton() {
        interactor.didTapDetailsButton()
    }
    
    @objc private func didTapUpdateButton() {
        interactor.didTapUpdateButton()
    }
    
    private func showLoadingIndicator() {
        backgroundView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        backgroundView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    private func updateWeatherData(with model: WeatherModel) {
        cityNameLabel.text = model.name
        temperatureLabel.text = "\(model.temp)°C"
        weatherIconImageView.image = UIImage(systemName: model.iconName)
    }
}

//MARK: - Extensions
extension WeatherMainViewController: WeatherMainViewControllerInput {
    func configure(state: ViewState) {
        switch state {
        case .loading:
            showLoadingIndicator()
        case .error(let error):
            hideLoadingIndicator()
            showAlert(message: error.localizedDescription)
        case .content(let model):
            hideLoadingIndicator()
            backgroundView.isHidden = false
            updateWeatherData(with: model)
        }
    }
}

//MARK: - Configure UI
extension WeatherMainViewController {
    
    private func configureUI() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(cityNameLabel)
        backgroundView.addSubview(temperatureLabel)
        backgroundView.addSubview(weatherIconImageView)
        
        view.addSubview(updateButton)
        view.addSubview(detailsButton)
        
        configureBackground()
        configureCityNameLable()
        configureTemperatureLabel()
        configureWeatherIconImageView()
        configureUpdateButton()
        configureDetailsButton()
    }
    
    private func configureBackground() {
        view.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureCityNameLable() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        cityNameLabel.textAlignment = .center
        cityNameLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            cityNameLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            cityNameLabel.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }
    
    private func configureTemperatureLabel() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont.systemFont(ofSize: 40)
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 20),
        ])
    }
    
    private func configureWeatherIconImageView() {
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherIconImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            weatherIconImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            weatherIconImageView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 100),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func configureUpdateButton() {
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        updateButton.setTitle("Update", for: .normal)
        updateButton.setTitleColor(.blue, for: .normal)
        updateButton.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.bottomAnchor.constraint(equalTo: detailsButton.topAnchor, constant: -20)
        ])
    }
    
    private func configureDetailsButton() {
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        detailsButton.setTitle("Details", for: .normal)
        detailsButton.setTitleColor(.blue, for: .normal)
        
        detailsButton.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            detailsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}
