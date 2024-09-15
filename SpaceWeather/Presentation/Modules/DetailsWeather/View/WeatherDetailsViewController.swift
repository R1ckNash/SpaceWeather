//
//  WeatherDetailsViewController.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import UIKit

protocol WeatherDetailsViewControllerInput: AnyObject {
    func configure(state: ViewState<WeatherModel>)
}

final class WeatherDetailsViewController: BaseViewController {
    
    //MARK: - Properties
    private let interactor: WeatherDetailsInteractorInput
    
    //MARK: - UI Elements
    private let backgroundView = UILabel()
    private let cityNameLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let weatherIconImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let humidityLabel = UILabel()
    private let pressureLabel = UILabel()

    //MARK: - Lifecycle
    init(interactor: WeatherDetailsInteractorInput) {
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
    private func updateWeatherData(with model: WeatherModel) {
        cityNameLabel.text = model.name
        temperatureLabel.text = "\(model.temp)°C"
        descriptionLabel.text = model.description
        humidityLabel.text = "Humidity: \(model.humidity)%".localized
        pressureLabel.text = "Pressure: \(model.pressure) hPa".localized
        weatherIconImageView.image = UIImage(systemName: model.iconName)
    }
    
    private func showLoadingIndicator() {
        backgroundView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        backgroundView.isHidden = false
        activityIndicator.stopAnimating()
    }
    
}
//MARK: - Extensions
extension WeatherDetailsViewController: WeatherDetailsViewControllerInput {
    
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
extension WeatherDetailsViewController {
    
    private func configureUI() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(cityNameLabel)
        backgroundView.addSubview(temperatureLabel)
        backgroundView.addSubview(weatherIconImageView)
        backgroundView.addSubview(descriptionLabel)
        backgroundView.addSubview(humidityLabel)
        backgroundView.addSubview(pressureLabel)
        
        configureBackground()
        configureCityNameLabel()
        configureTemperatureLabel()
        configureWeatherIconImageView()
        configureDescriptionLabel()
        configureHumidityLabel()
        configurePressureLabel()
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
    
    private func configureDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureHumidityLabel() {
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.font = UIFont.systemFont(ofSize: 18)
        humidityLabel.textAlignment = .center
        humidityLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            humidityLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            humidityLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func configurePressureLabel() {
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.font = UIFont.systemFont(ofSize: 18)
        pressureLabel.textAlignment = .center
        pressureLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            pressureLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            pressureLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 20),
            pressureLabel.bottomAnchor.constraint(lessThanOrEqualTo: backgroundView.bottomAnchor, constant: -40)
        ])
    }
    
}
