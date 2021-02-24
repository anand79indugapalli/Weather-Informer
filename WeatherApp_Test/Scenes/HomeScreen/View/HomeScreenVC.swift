//
//  HomeScreenVC.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 22/02/21.
//

import UIKit
import SafariServices

class HomeScreenVC: UIViewController {
    
    // MARK: - Variables
    ///
    var viewModel: HomeViewModelType?
    ///
    var citiesList: [BookMarkModel] = []
    
    @IBOutlet weak var citiesTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadUI()
    }
    
    func loadUI() {
        citiesTblView.register(UINib(nibName: "CityTableCell", bundle: nil), forCellReuseIdentifier: "CityTableCell")
        citiesTblView.register(UINib(nibName: "CityTableCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "CityTableCell")
        citiesTblView.separatorStyle = .none
        citiesTblView.isHidden = citiesList.isEmpty
        viewModel?.getCitiesList({ (list) in
            self.citiesList = list
            DispatchQueue.main.async {
                self.citiesTblView.isHidden = self.citiesList.isEmpty
                self.citiesTblView.reloadData()
            }
        })
    }
    
    func addSelectedCities(city: BookMarkModel) {
        guard !citiesList.contains(where: {$0.pinCode == city.pinCode}) else {
            return
        }
        citiesList.append(city)
        
        viewModel?.getSavedCities(cities: citiesList)
        citiesTblView.isHidden = false
        citiesTblView.reloadData()
    }
    
    func openurlInBrowser(urlString: String) {
           guard let url = URL(string: urlString) else { return }
           let svc = SFSafariViewController(url: url)
           present(svc, animated: true, completion: nil)
       }

    
    @IBAction func addCitiesButtonTapped(_ sender: UIButton) {
        viewModel?.openMapViewToBookMark()
    }
}

extension HomeScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableCell", for: indexPath) as? CityTableCell else { return UITableViewCell() }
        cell.displayCity(info: citiesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel?.selectedCity(city: citiesList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            citiesList.remove(at: indexPath.row)
            viewModel?.getSavedCities(cities: citiesList)
            citiesTblView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
