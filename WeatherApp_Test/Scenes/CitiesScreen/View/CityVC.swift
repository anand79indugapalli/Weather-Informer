//
//  CityVC.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 23/02/21.
//

import UIKit

class CityVC: UIViewController {
    
    // MARK - Outlets
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var tempDateInfoLabel: UILabel!
    
    @IBOutlet weak var weatherForeCastTableView: UITableView!
    
    // MARK: - Variables
    ///
    var viewModel: CityViewModelType?
    //
    var units: String = "metric"
    ///
    var cityWeatherForeCast: CityWeatherForecast?
    ///
    var selectedDate: Int = -1
    ///
    var weatherForeCast: [ForeCastModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
        viewModel?.getCityForecastInfoFromServer(units: units, completionHandler: { (response, errorMsg) in
            
            self.cityWeatherForeCast = response
            self.serializeInfo()
            DispatchQueue.main.async {
                self.title = response?.city.name
            }
            if response == nil  {
                self.showAlert(title: "Error", message: errorMsg, okButton: "OK", cancelTitle: "") {
                    self.viewModel?.goToHomeScreen()
                }
            }
        })
        // Do any additional setup after loading the view.
    }

    // MARK: - HelperMethods
    func loadUI() {
        weatherForeCastTableView.register(UINib(nibName: "SessionWeatherTableCell", bundle: nil), forCellReuseIdentifier: "SessionWeatherTableCell")
        weatherForeCastTableView.register(UINib(nibName: "SessionWeatherHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SessionWeatherHeaderView")
        weatherForeCastTableView.tableFooterView = UIView()
    }
    ///
    func serializeInfo() {
        cityWeatherForeCast?.list.forEach({ (list) in
            if let dtIndex = weatherForeCast.firstIndex(where: {$0.date.convertDateFormater(from: "yyyy-MM-dd HH:mm:ss", to: "yyyy-MM-dd") == list.dtTxt.convertDateFormater(from: "yyyy-MM-dd HH:mm:ss", to: "yyyy-MM-dd")}) {
                weatherForeCast[dtIndex].list.append(list)
            } else {
                weatherForeCast.append(ForeCastModel(date: list.dtTxt, list: [list]))
            }
        })
        debugPrint(weatherForeCast)
        DispatchQueue.main.async {
            self.weatherForeCastTableView.reloadData()
            self.loadCurrentTimeInfo()
        }
    }
    
    func loadCurrentTimeInfo() {
        currentTempLabel.attributedText = "\(weatherForeCast.first?.list.first?.main.temp ?? 0)".customizeString(fontSize: 35
        )
        weatherDescLabel.text = weatherForeCast.first?.list.first?.weather.first?.main ?? ""
        let tempMax = "\(weatherForeCast.first?.list.first?.main.tempMax ?? 0)".customizeString(fontSize: 20)
        let tempMin = "\(weatherForeCast.first?.list.first?.main.tempMin ?? 0)".customizeString(fontSize: 20)
        let date = (weatherForeCast.first?.date.convertDateFormater(from: "yyyy-MM-dd HH:mm:ss", to: "EEE") ?? "").changeFont(fontSize: 20)
        let combination = NSMutableAttributedString()
        combination.append(tempMax)
        combination.append("/".changeFont(fontSize: 20))
        combination.append(tempMin)
        combination.append(NSAttributedString(string: "      "))
        combination.append(date)
        tempDateInfoLabel.attributedText = combination
        
    }

}

extension CityVC: UITableViewDataSource, UITableViewDelegate, CityTableHeaderType {
    func dateSelected(index: Int) {
        selectedDate = selectedDate == index ? -1 : index
        weatherForeCastTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return weatherForeCast.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedDate == section {
            return weatherForeCast[section].list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SessionWeatherTableCell", for: indexPath) as? SessionWeatherTableCell else { return UITableViewCell() }
        let date = weatherForeCast[indexPath.section].list.indices.contains(indexPath.row+1) ? weatherForeCast[indexPath.section].list[indexPath.row+1].dtTxt : ""
            cell.loadCell(info: weatherForeCast[indexPath.section].list[indexPath.row], date: date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SessionWeatherHeaderView") as? SessionWeatherHeaderView else { return UIView() }
        headerView.delegate = self
        headerView.loadCell(info: weatherForeCast[section].list[0], index: section)
        return headerView
    }
    
}
