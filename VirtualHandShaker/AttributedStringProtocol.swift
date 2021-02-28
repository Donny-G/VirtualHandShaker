//
//  AttributedStringProtocol.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 17.02.2021.
//

import Foundation
import UIKit

protocol AttributedString {
    
}

extension AttributedString where Self: UIViewController {
    
    func addAttributesToNameLabel(string: String, color: UIColor)-> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 5))
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        return NSAttributedString(string: string, attributes: attributes)
    }
    
    func addAttributesToMessageLabel(string: String, color: UIColor)-> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 5))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.firstLineHeadIndent = 5.0
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color, .paragraphStyle: paragraphStyle]
        return NSAttributedString(string: string, attributes: attributes)
    }
    
    func addAttributesToDescription(string: String, color: UIColor)-> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 5))
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.shadowColorSet()
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.firstLineHeadIndent = 5.0
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color, .paragraphStyle: paragraphStyle, .shadow: shadow]
        return NSAttributedString(string: string, attributes: attributes)
    }
    
    func addAttributesToDescriptionLarge(string: String, color: UIColor)-> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight(rawValue: 5))
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.shadowColorSet()
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color, .paragraphStyle: paragraphStyle, .shadow: shadow]
        return NSAttributedString(string: string, attributes: attributes)
    }
    
}
