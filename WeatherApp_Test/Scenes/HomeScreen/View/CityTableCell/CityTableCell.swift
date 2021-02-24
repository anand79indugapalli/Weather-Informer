//
//  CityTableCell.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 22/02/21.
//

import UIKit

class CityTableCell: UITableViewCell {
    
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var cityNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.dropShadowToView()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    func displayCity(info: BookMarkModel) {
        let cityTxt = info.city + ", \(info.state), \(info.country)"
        let amountText = NSMutableAttributedString.init(string: cityTxt)

        amountText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
                                      NSAttributedString.Key.foregroundColor: UIColor.black],
                                 range: NSMakeRange(0, info.city.count))
        cityNameLbl.textColor = .darkGray
        cityNameLbl.attributedText = amountText
       // cityNameLbl.UILableTextShadow(color: .black)
    }
}

