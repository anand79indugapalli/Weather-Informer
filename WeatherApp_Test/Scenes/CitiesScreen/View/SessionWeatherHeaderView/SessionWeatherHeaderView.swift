//
//  SessionWeatherHeaderView.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 24/02/21.
//

import UIKit

class SessionWeatherHeaderView: UITableViewHeaderFooterView {

    
    var delegate: CityTableHeaderType?
    var index: Int = 0
    
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerTapped)))
    }

    @objc private func headerTapped(gestureRecognizer: UITapGestureRecognizer) {
        delegate?.dateSelected(index: index)
    }
    
    
    func loadCell(info: List, index: Int) {
        self.index = index
        weatherDescLabel.text = info.weather.first?.main ?? ""
        dateLabel.text = info.dtTxt.convertDateFormater(from: "yyyy-MM-dd HH:mm:ss", to: "MMM dd   EEE")
        let tempMax = "\(info.main.tempMax)".customizeString(fontSize: 17) //+
        let tempMin = "\(info.main.tempMin)".customizeString(fontSize: 17)
        let combination = NSMutableAttributedString()
        combination.append(tempMax)
        combination.append("/".changeFont(fontSize: 17))
        combination.append(tempMin)
        tempLabel.attributedText = combination
        let iconUrl = "http://openweathermap.org/img/wn/\(info.weather[0].icon)@2x.png"
        weatherIcon.loadImageFrom(url: iconUrl)
    }
}
