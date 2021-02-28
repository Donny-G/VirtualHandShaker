//
//  ShadowProtocol.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 19.01.2021.
//

import Foundation
import UIKit

protocol NeumorphicShadows {
}

extension NeumorphicShadows where Self: UIViewController {
    
    func addShadowForActiveView(yourView: UIView,verticalLightShadow: CAShapeLayer, horizontalLightShadow: CAShapeLayer, horizontalDarkShadow: CAShapeLayer, verticalDarkShadow: CAShapeLayer, color: UIColor ) {
        yourView.layer.cornerRadius = 20
        yourView.backgroundColor = color
        yourView.layer.masksToBounds = true
        yourView.clipsToBounds = true
        
        yourView.layer.borderWidth = 0.2
        yourView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        horizontalDarkShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: yourView.frame.width - 20, height: 10), cornerRadius: 20).cgPath
        
        horizontalDarkShadow.frame = CGRect(x: yourView.frame.origin.x + 10, y: yourView.frame.origin.y + 3, width: yourView.frame.size.width, height: yourView.frame.height)
         
        horizontalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        horizontalDarkShadow.shadowRadius = 4
        horizontalDarkShadow.shadowOpacity = 0.3
        horizontalDarkShadow.shouldRasterize = true
        
        verticalDarkShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 10, height: yourView.frame.height - 10), cornerRadius: 20).cgPath
        verticalDarkShadow.frame = CGRect(x: yourView.frame.origin.x, y: yourView.frame.origin.y, width: yourView.frame.size.width, height: yourView.frame.height)
        verticalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        verticalDarkShadow.shadowOffset = CGSize(width: 0, height: 0)
        verticalDarkShadow.shadowRadius = 4
        verticalDarkShadow.shadowOpacity = 0.3
        verticalDarkShadow.shouldRasterize = true
        
        verticalLightShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: yourView.frame.width, y: 0, width: 10, height: yourView.frame.height - 10), cornerRadius: 20).cgPath
        verticalLightShadow.frame = CGRect(x: yourView.frame.origin.x - 5, y: yourView.frame.origin.y + 10, width: yourView.frame.size.width, height: yourView.frame.height)
        verticalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        verticalLightShadow.shadowOffset = CGSize(width: -10, height: 0)
        verticalLightShadow.shadowOpacity = 1
        verticalLightShadow.shadowRadius = 7
        verticalLightShadow.shouldRasterize = true
        
        horizontalLightShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: yourView.frame.height, width: yourView.frame.width - 20, height: 10), cornerRadius: 20).cgPath
        horizontalLightShadow.frame = CGRect(x: yourView.frame.origin.x + 10, y: yourView.frame.origin.y - 5, width: yourView.frame.size.width, height: yourView.frame.height)
        horizontalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        horizontalLightShadow.shadowOffset = CGSize(width: 0, height: -10)
        horizontalLightShadow.shadowOpacity = 1
        horizontalLightShadow.shadowRadius = 7
        horizontalLightShadow.shouldRasterize = true
        
        self.view.layer.insertSublayer(verticalLightShadow, above: yourView.layer)
        self.view.layer.insertSublayer(horizontalLightShadow, above: yourView.layer)
        self.view.layer.insertSublayer(horizontalDarkShadow, above: yourView.layer)
        self.view.layer.insertSublayer(verticalDarkShadow, above: yourView.layer)
        }
    
    func addShadowForStaticView(yourView: UIView, color: UIColor) {
        let verticalLightShadow = CAShapeLayer()
        let horizontalLightShadow = CAShapeLayer()
        let horizontalDarkShadow = CAShapeLayer()
        let verticalDarkShadow = CAShapeLayer()
        
        yourView.layer.cornerRadius = 20
        yourView.backgroundColor = color
        yourView.layer.masksToBounds = true
        yourView.clipsToBounds = true
        
        yourView.layer.borderWidth = 0.2
        yourView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        horizontalDarkShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: yourView.frame.width - 20, height: 10), cornerRadius: 20).cgPath
        
        horizontalDarkShadow.frame = CGRect(x: yourView.frame.origin.x + 10, y: yourView.frame.origin.y + 3, width: yourView.frame.size.width, height: yourView.frame.height)
         
        horizontalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        horizontalDarkShadow.shadowRadius = 4
        horizontalDarkShadow.shadowOpacity = 0.3
        horizontalDarkShadow.shouldRasterize = true
        
        verticalDarkShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 10, height: yourView.frame.height - 10), cornerRadius: 20).cgPath
        verticalDarkShadow.frame = CGRect(x: yourView.frame.origin.x, y: yourView.frame.origin.y, width: yourView.frame.size.width, height: yourView.frame.height)
        verticalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        verticalDarkShadow.shadowOffset = CGSize(width: 0, height: 0)
        verticalDarkShadow.shadowRadius = 4
        verticalDarkShadow.shadowOpacity = 0.3
        verticalDarkShadow.shouldRasterize = true
        
        verticalLightShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: yourView.frame.width, y: 0, width: 10, height: yourView.frame.height - 10), cornerRadius: 20).cgPath
        verticalLightShadow.frame = CGRect(x: yourView.frame.origin.x - 5, y: yourView.frame.origin.y + 10, width: yourView.frame.size.width, height: yourView.frame.height)
        verticalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        verticalLightShadow.shadowOffset = CGSize(width: -10, height: 0)
        verticalLightShadow.shadowOpacity = 1
        verticalLightShadow.shadowRadius = 7
        verticalLightShadow.shouldRasterize = true
        
        horizontalLightShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: yourView.frame.height, width: yourView.frame.width - 20, height: 10), cornerRadius: 20).cgPath
        horizontalLightShadow.frame = CGRect(x: yourView.frame.origin.x + 10, y: yourView.frame.origin.y - 5, width: yourView.frame.size.width, height: yourView.frame.height)
        horizontalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        horizontalLightShadow.shadowOffset = CGSize(width: 0, height: -10)
        horizontalLightShadow.shadowOpacity = 1
        horizontalLightShadow.shadowRadius = 7
        horizontalLightShadow.shouldRasterize = true
        
        self.view.layer.insertSublayer(verticalLightShadow, above: yourView.layer)
        self.view.layer.insertSublayer(horizontalLightShadow, above: yourView.layer)
        self.view.layer.insertSublayer(horizontalDarkShadow, above: yourView.layer)
        self.view.layer.insertSublayer(verticalDarkShadow, above: yourView.layer)
        }
    
    func shadowChangeByBegan(verticalDarkShadow: CAShapeLayer, horizontalDarkShadow: CAShapeLayer, verticalLightShadow: CAShapeLayer, horizontalLightShadow: CAShapeLayer) {
        verticalDarkShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        horizontalDarkShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        verticalLightShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        horizontalLightShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    }
    
    func shadowChangeByEnded(verticalDarkShadow: CAShapeLayer, horizontalDarkShadow: CAShapeLayer, verticalLightShadow: CAShapeLayer, horizontalLightShadow: CAShapeLayer) {
        verticalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        horizontalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        verticalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        horizontalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
    }
    
    //for collection view
    func shadowChangeByBeganVer2(verticalDarkShadow: CAShapeLayer, horizontalDarkShadow: CAShapeLayer, verticalLightShadow: CAShapeLayer, horizontalLightShadow: CAShapeLayer) {
        verticalDarkShadow.shadowColor = UIColor.white.withAlphaComponent(1).cgColor
        horizontalDarkShadow.shadowColor = UIColor.white.withAlphaComponent(1).cgColor
        verticalLightShadow.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        horizontalLightShadow.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
    
    func addShadowForActiveViewVer2(yourView: UIView,verticalLightShadow: CAShapeLayer, horizontalLightShadow: CAShapeLayer, horizontalDarkShadow: CAShapeLayer, verticalDarkShadow: CAShapeLayer, color: UIColor ) {
        yourView.layer.cornerRadius = 20
        yourView.backgroundColor = color
        yourView.layer.masksToBounds = true
        yourView.clipsToBounds = true
        
        yourView.layer.borderWidth = 0.2
        yourView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        horizontalDarkShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: yourView.frame.width - 20, height: 10), cornerRadius: 20).cgPath
        
        horizontalDarkShadow.frame = CGRect(x: yourView.frame.origin.x + 10, y: yourView.frame.origin.y + 3, width: yourView.frame.size.width, height: yourView.frame.height)
         
        horizontalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.0).cgColor
        horizontalDarkShadow.shadowRadius = 4
        horizontalDarkShadow.shadowOpacity = 0.3
        horizontalDarkShadow.shouldRasterize = true
        
        verticalDarkShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 10, height: yourView.frame.height - 10), cornerRadius: 20).cgPath
        verticalDarkShadow.frame = CGRect(x: yourView.frame.origin.x, y: yourView.frame.origin.y, width: yourView.frame.size.width, height: yourView.frame.height)
        verticalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.0).cgColor
        verticalDarkShadow.shadowOffset = CGSize(width: 0, height: 0)
        verticalDarkShadow.shadowRadius = 4
        verticalDarkShadow.shadowOpacity = 0.3
        verticalDarkShadow.shouldRasterize = true
        
        verticalLightShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: yourView.frame.width, y: 0, width: 10, height: yourView.frame.height - 10), cornerRadius: 20).cgPath
        verticalLightShadow.frame = CGRect(x: yourView.frame.origin.x - 5, y: yourView.frame.origin.y + 10, width: yourView.frame.size.width, height: yourView.frame.height)
        verticalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.0).cgColor
        verticalLightShadow.shadowOffset = CGSize(width: -10, height: 0)
        verticalLightShadow.shadowOpacity = 0.7
        verticalLightShadow.shadowRadius = 7
        verticalLightShadow.shouldRasterize = true
        
        horizontalLightShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: yourView.frame.height, width: yourView.frame.width - 20, height: 10), cornerRadius: 20).cgPath
        horizontalLightShadow.frame = CGRect(x: yourView.frame.origin.x + 10, y: yourView.frame.origin.y - 5, width: yourView.frame.size.width, height: yourView.frame.height)
        horizontalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.0).cgColor
        horizontalLightShadow.shadowOffset = CGSize(width: 0, height: -10)
        horizontalLightShadow.shadowOpacity = 0.7
        horizontalLightShadow.shadowRadius = 7
        horizontalLightShadow.shouldRasterize = true
        
        self.view.layer.insertSublayer(verticalLightShadow, above: yourView.layer)
        self.view.layer.insertSublayer(horizontalLightShadow, above: yourView.layer)
        self.view.layer.insertSublayer(horizontalDarkShadow, above: yourView.layer)
        self.view.layer.insertSublayer(verticalDarkShadow, above: yourView.layer)
        }
    
}


