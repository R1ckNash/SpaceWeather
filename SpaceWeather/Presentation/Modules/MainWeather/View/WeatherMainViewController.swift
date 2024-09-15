//
//  WeatherMainViewController.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 13/09/2024.
//

import Foundation
import UIKit

protocol WeatherMainViewControllerInput: AnyObject {
    func configure(state: ViewState<WeatherModel>)
}

final class WeatherMainViewController: BaseViewController {
    
    //MARK: - Properties
    private let interactor: WeatherMainInteractorInput
    
    //MARK: - UI Elements
    private let backgroundView = UILabel()
    private let updateButton = UIButton()
    private let detailsButton = UIButton()
    private let cityNameLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let weatherIconImageView = UIImageView()
    private let stackView = UIStackView()
    
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
    
    func configure(state: ViewState<WeatherModel>) {
        switch state {
        case .loading:
            showLoadingIndicator()
        case .error(let error):
            hideLoadingIndicator()
            showAlert(title: "Error".localized, message: error.localizedDescription,
                      buttonText: "OK".localized, completion: nil)
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
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(updateButton)
        stackView.addArrangedSubview(detailsButton)
        
        configureBackground()
        configureCityNameLabel()
        configureTemperatureLabel()
        configureWeatherIconImageView()
        configureStackView()
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
    
    private func configureWeatherIconImageView() {
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherIconImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            weatherIconImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            weatherIconImageView.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 80),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func configureTemperatureLabel() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont.systemFont(ofSize: 60)
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 20),
        ])
    }
    
    private func configureCityNameLabel() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        cityNameLabel.textAlignment = .center
        cityNameLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            cityNameLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            cityNameLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            cityNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: backgroundView.bottomAnchor, constant: -40)
        ])
    }
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureUpdateButton() {
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.filled()
        config.title = "Update".localized
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        
        updateButton.configuration = config
        updateButton.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
    }
    
    private func configureDetailsButton() {
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.filled()
        config.title = "Details".localized
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        
        detailsButton.configuration = config
        detailsButton.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
    }
    
}
