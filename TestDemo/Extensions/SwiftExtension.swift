//
//  SwiftExtension.swift
//  TestDemo
//
//  Created by Apple on 01/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    //Static Property
    static let MoviewNavColor = UIColor(hex :"87878C")
    static let SegmentButtonColor = UIColor(hex :"D2D2D2")

    
    //Hex color
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
}

extension UIViewController {
    public func showAlert(title: String?, message: String?, closure: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                closure()
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
}
}
