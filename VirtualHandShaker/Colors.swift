//
//  Colors.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 16.02.2021.
//

import Foundation

import UIKit

extension UIColor {
    
    //light
    static let mainBackgroundLightColor = UIColor.init(red: 0.639, green: 0.867, blue: 0.796, alpha: 1)
    static let showViewLightColor = UIColor.init(red: 0.086, green: 0.647, blue: 0.588, alpha: 1)
    static let buttonLightColor = UIColor.init(red: 0.251, green: 0.616, blue: 0.608, alpha: 1)
    
    static let textFieldLightColor = UIColor.init(red: 1.000, green: 0.800, blue: 0.161, alpha: 1)
    static let textfieldTextLightColor = UIColor.init(red: 0.231, green: 0.325, blue: 0.376, alpha: 1)
    static let textfieldPlaceholderLightColor = UIColor.init(red: 0.231, green: 0.325, blue: 0.376, alpha: 1)
    
    static let friendNameLabelTextLightColor = UIColor.init(red: 1.000, green: 0.086, blue: 0.365, alpha: 1)
    static let userNameLabelTextLightColor = UIColor.init(red: 0.012, green: 0.314, blue: 0.435, alpha: 1)
    
    static let messageLightColor = UIColor.init(red: 0.094, green: 0.302, blue: 0.278, alpha: 1)
    
    //with shadow
    static let infoTextLightColor1 = UIColor.init(red: 0.898, green: 0.439, blue: 0.494, alpha: 1)
    //with shadow
    static let infoTextLightColor2 = UIColor.init(red: 0.086, green: 0.529, blue: 0.655, alpha: 1)
    
    //dark
    static let mainBackgroundDarkColor = UIColor.init(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
    static let showViewDarkColor = UIColor.init(red: 0.271, green: 0.365, blue: 0.478, alpha: 1)
    static let buttonDarkColor = UIColor.init(red: 0.000, green: 0.345, blue: 0.478, alpha: 1)
    
    static let textFieldDarkColor = UIColor.init(red: 0.769, green: 0.929, blue: 0.871, alpha: 1)
    static let textfieldTetxDarkColor = UIColor.init(red: 0.247, green: 0.478, blue: 0.612, alpha: 1)
    static let textfieldPlaceholderDarkColor = UIColor.init(red: 0.247, green: 0.478, blue: 0.612, alpha: 1)
    
    static let userNameLabelTextDarkColor = UIColor.init(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
    static let friendNameLabelTextDarkColor = UIColor.init(red: 0.996, green: 0.804, blue: 0.102, alpha: 1)
    static let messageDarkColor = UIColor.init(red: 0.000, green: 0.345, blue: 0.478, alpha: 1)
    
//+info shadow
    static let infoTextDarkColor1 = UIColor.init(red: 0.439, green: 0.686, blue: 0.522, alpha: 1)
    //info ? shadow
    static let infoTextDarkColor2 = UIColor.init(red: 0.918, green: 0.592, blue: 0.678, alpha: 1)
    
    static let tintColorForAlertController = UIColor.init(red: 0.227, green: 0.565, blue: 0.498, alpha: 1)
    
    static func backgroundColorSet() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.mainBackgroundDarkColor : UIColor.mainBackgroundLightColor
            }
        }
        else { return UIColor.mainBackgroundLightColor }
    }
    
    static func showViewColorSet() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.showViewDarkColor : UIColor.showViewLightColor
            }
        }
        else { return UIColor.showViewLightColor }
    }
    
    static func buttonColorSet() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.buttonDarkColor : UIColor.buttonLightColor
            }
        }
        else { return UIColor.buttonLightColor }
    }
    
    static func textFieldColorSet() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.textFieldDarkColor : UIColor.textFieldLightColor
            }
        }
        else { return UIColor.textFieldLightColor }
    }
    
    static func textFieldTextColorSet() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.textfieldTetxDarkColor : UIColor.textfieldTextLightColor
            }
        }
        else { return UIColor.textfieldTextLightColor }
    }
    
    static func textFieldPlaceholderColorSet() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.textfieldTetxDarkColor : UIColor.textfieldTextLightColor
            }
        }
        else { return UIColor.textfieldTextLightColor }
    }
    
    static func shadowColorSet() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.black : UIColor.textFieldDarkColor
            }
        }
        else { return UIColor.textFieldDarkColor }
    }
    
    static func messageColorSet() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.messageDarkColor : UIColor.messageLightColor
            }
        }
        else { return UIColor.messageLightColor }
    }
    
    static func infoColor1Set() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.infoTextDarkColor1 : UIColor.infoTextLightColor1
            }
        }
        else { return UIColor.infoTextLightColor1 }
    }
    
    static func infoColor2Set() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.infoTextDarkColor2 : UIColor.infoTextLightColor2
            }
        }
        else { return UIColor.infoTextLightColor2 }
    }
    
    static func friendLabelColorSet() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.friendNameLabelTextDarkColor : UIColor.friendNameLabelTextLightColor
            }
        }
        else { return UIColor.friendNameLabelTextLightColor }
    }
    
    static func userLabelColorSet() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.userNameLabelTextDarkColor : UIColor.userNameLabelTextLightColor
            }
        }
        else { return UIColor.userNameLabelTextLightColor }
    }
    
}



