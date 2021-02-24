//
//  SessionWeatherTableCell.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 24/02/21.
//

import UIKit

class SessionWeatherTableCell: UITableViewCell {

    @IBOutlet weak var timeIndicatorLbl: UILabel!
    @IBOutlet weak var tempValueLbl: UILabel!
    @IBOutlet weak var humidityValueLbl: UILabel!
    
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var rainChancesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // contentView.dropShadowToView()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    ///
    func loadCell(info: List, date: String) {
        let nxtHrs = date.count > 0 ? " - \(date.convertDateFormater(from: "yyyy-MM-dd HH:mm:ss", to: "ha"))" : ""
        timeIndicatorLbl.text = (info.dtTxt.convertDateFormater(from: "yyyy-MM-dd HH:mm:ss", to: "ha") + nxtHrs).lowercased()
        tempValueLbl.attributedText = "\(info.main.temp)".customizeString(fontSize: 20)
        let humidity = "\(info.main.humidity)".changeFont(fontSize: 20)
        let param = "%".changeFont(fontSize: 14)
        let combination = NSMutableAttributedString()
        combination.append(humidity)
        combination.append(param)
        humidityValueLbl.attributedText = combination
        let windAttr = NSMutableAttributedString()
        let wind = "\(info.wind.speed)".changeFont(fontSize: 20)
        let units = "m/s".changeFont(fontSize: 11)
        windAttr.append(wind)
        windAttr.append(units)
        windSpeedLbl.attributedText = windAttr
        if let rain = info.rain {
            let value = rain.the3H != nil ? "\(rain.the3H ?? 0)" : "\(rain.the1H ?? 0)"
            let rainAttr = NSMutableAttributedString()
            rainAttr.append("Yes (".changeFont(fontSize: 17))
            rainAttr.append(value.changeFont(fontSize: 12))
            rainAttr.append("m)".changeFont(fontSize: 11))
            rainChancesLbl.attributedText = rainAttr
        } else {
            rainChancesLbl.text = "No"
        }
        
        
    }
}
