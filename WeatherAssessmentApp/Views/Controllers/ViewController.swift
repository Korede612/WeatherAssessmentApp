//
//  ViewController.swift
//  WeatherAssessmentApp
//
//  Created by Oko-osi Korede on 05/06/2024.
//

import UIKit
import CoreLocation
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var savedLocationsView: UIView!
    @IBOutlet weak var savedLocationTitleLabel: UILabel!
    @IBOutlet weak var savedlocationTableView: UITableView!
    
    @IBOutlet weak var seeMoreWeatherInfo: UIButton!
    
    var dataSource: UITableViewDiffableDataSource<Int, String>!

    
    let locationManager = CLLocationManager()
    var viewModel: ViewModelInterface = ViewModel(networkManager: NetworkManager())
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        seeMoreWeatherInfo.isHidden = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        tempLabel.text = "- -"
        cityLabel.text = "- -"
        conditionImageView.image = UIImage(systemName: "questionmark.circle")
        
        searchTF.delegate = self
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.updateSavedLocation()
        hideSelectedTableView()
        updateWeatherData(location: viewModel.savedLocation)
    }
    
    func setupTableView() {
        savedlocationTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        savedlocationTableView.delegate = self
        
        dataSource = UITableViewDiffableDataSource<Int, String>(tableView: savedlocationTableView) { tableView, indexPath, location in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "\(indexPath.row + 1): \(location)"
            cell.backgroundColor = .clear
            return cell
        }
        hideSelectedTableView()
        // Initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.savedLocation)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func hideSelectedTableView() {
        savedLocationsView.isHidden = viewModel.savedLocation.isEmpty
    }
    
    func updateWeatherData(location: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(location)
        print("Locations: \(location)")
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        performSearch()
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreInfo" {
            guard let destinationVC = segue.destination as? WeatherDetailViewController else {
                return
            }
            destinationVC.viewModel = viewModel
        }
    }
    

    func performSearch() {
        guard let cityName = searchTF.text else { return }
        let fetchWeather: APIEndpoint = .fetchWeatherDataFor(loc: cityName)
        viewModel.networkManager?.request(endpoint: fetchWeather)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: requestCompletionHandler(completion:), receiveValue: requestDataHandler)
            .store(in: &cancellables)
        searchTF.endEditing(true)
        
    }

}

