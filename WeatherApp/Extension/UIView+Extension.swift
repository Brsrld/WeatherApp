//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by İSMAİL AÇIKYÜREK on 31.03.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ Views : UIView...) {
        for i in Views {
            addSubview(i)
        }
    }
}
