//
//  WeatherDetailsViewController.swift
//  SpaceWeather
//
//  Created by Ilia Liasin on 14/09/2024.
//

import UIKit

protocol WeatherDetailsViewControllerInput: AnyObject {
    
}

final class WeatherDetailsViewController: UIViewController {
    
    //MARK: - Properties
    private let interactor: WeatherDetailsInteractorInput

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

        
        view.backgroundColor = .white
    }
    
}

extension WeatherDetailsViewController: WeatherDetailsViewControllerInput {
    
}
