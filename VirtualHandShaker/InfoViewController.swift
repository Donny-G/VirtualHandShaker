//
//  InfoViewController.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 24.11.2020.
//

import UIKit

class InfoViewController: UIViewController, AttributedString {
    
    let verticalLightShadow = CAShapeLayer()
    let horizontalLightShadow = CAShapeLayer()
    let horizontalDarkShadow = CAShapeLayer()
    let verticalDarkShadow = CAShapeLayer()

    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet var connectButtonImage: UIImageView!
    @IBOutlet var connectButtonDescription: UILabel!
    
    @IBOutlet var connectionViewImage: UIImageView!
    @IBOutlet var connectionViewDescription: UILabel!
    
    @IBOutlet var handTypeButtonImage: UIImageView!
    @IBOutlet var handTypeButtonDescription: UILabel!
    
    @IBOutlet var shakeTypeButtonImage: UIImageView!
    @IBOutlet var shakeTypeButtonDescription: UILabel!
    
    @IBOutlet var actionButtonImage: UIImageView!
    @IBOutlet var actionButtonDescription: UILabel!
    
    @IBOutlet var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.attributedText = addAttributesToDescription(string: "Info", color: .infoColor2Set())
        connectButtonImage.image = UIImage(named: "forInfoCBLight")
        
        connectButtonDescription.attributedText = addAttributesToDescription(string: "Press to start multipeer session with friends", color: UIColor.infoColor1Set())
        
        connectionViewImage.image = UIImage(named: "connectView")
        
        connectionViewDescription.attributedText = addAttributesToDescription(string: "Start session or join to session to handshake", color: UIColor.infoColor2Set())
        
        handTypeButtonImage.image = UIImage(named: "forInfoHTBLight")
        
        handTypeButtonDescription.attributedText = addAttributesToDescription(string: "Choose hand type", color: UIColor.infoColor1Set())
        
        shakeTypeButtonImage.image = UIImage(named: "forInfoSTBLight")
        
        shakeTypeButtonDescription.attributedText = addAttributesToDescription(string: "Choose shake type", color: UIColor.infoColor2Set())
        
        actionButtonImage.image = UIImage(named: "forInfoABLight")
       // addShadowForStaticView(yourView: actionButtonImage, color: UIColor.buttonLight1)
        actionButtonDescription.attributedText = addAttributesToDescription(string: "Press to start animation", color: UIColor.infoColor1Set())
        backButton.setImage(UIImage(named: "backButtonLight"), for: .normal)
        
        scrollView.backgroundColor = UIColor.backgroundColorSet()
        
        contentView.backgroundColor = UIColor.backgroundColorSet()
    }
    
    
    
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
