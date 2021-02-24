//
//  Extensions.swift
//  WeatherApp_Test
//
//  Created by Inspire MiniMac001 on 24/02/21.
//

import UIKit

extension UIViewController {
    // MARK: - UIViewController
    // MARK: - Alert Controller Methods
    /// common alert controller
    func showAlert(title: String, message: String, okButton: String, cancelTitle: String, okBtnAction: @escaping() -> Void) {
        DispatchQueue.main.async { [unowned self] in
            let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: okButton, style: .default, handler: { (_) in
                okBtnAction()
            }))
            if cancelTitle.count > 0 {
                alert.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: nil))
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIView {
    func dropShadowToView(scale: Bool = true) {
        self.clipsToBounds = true
        layer.cornerRadius = 3
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension String {
    ///
    func convertDateFormater(from: String, to: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = from
        let date = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = to
        return  dateFormatter.string(from: date ?? Date())
        
    }
    
    ///
    func customizeString(fontSize: CGFloat) -> NSAttributedString {
        let text = self + "°C"
        let attributedText = NSMutableAttributedString.init(string: text)

        attributedText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                                      NSAttributedString.Key.foregroundColor: UIColor.darkGray],
                                 range: NSMakeRange(0, self.count))
        return attributedText
    }
    
    ///
    func changeFont(fontSize: CGFloat) -> NSAttributedString {
        let attributedText = NSMutableAttributedString.init(string: self)

        attributedText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                                      NSAttributedString.Key.foregroundColor: UIColor.darkGray],
                                 range: NSMakeRange(0, self.count))
        return attributedText
    }
}
///
extension Double {
    ///
    func convertToCelsius() -> String {
        return String(format: "%.1f", self - 273.15)
    }
}
