//
//  InfoViewController.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 24.11.2020.
//

import UIKit

class InfoViewController: UIViewController, NeumorphicShadows {
    
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
        
        titleLabel.text = "Info"
        connectButtonImage.image = UIImage(named: "connect5")
        addShadowForActiveView(yourView: connectButtonImage, verticalLightShadow: verticalLightShadow, horizontalLightShadow: horizontalLightShadow, horizontalDarkShadow: horizontalDarkShadow, verticalDarkShadow: verticalDarkShadow, color: UIColor.buttonLight1)
        connectButtonDescription.text = "Press to start multipeer session with friends"
        
        connectionViewImage.image = UIImage(named: "connectView")
        addShadowForStaticView(yourView: connectionViewImage, color: UIColor.buttonLight1)
        connectionViewDescription.text = "Start session or join to session to handshake"
        
        handTypeButtonImage.image = UIImage(named: "handType")
        addShadowForStaticView(yourView: handTypeButtonImage, color: UIColor.buttonLight1)
        handTypeButtonDescription.text = "Choose hand type"
        
        shakeTypeButtonImage.image = UIImage(named: "actionType")
        addShadowForStaticView(yourView: shakeTypeButtonImage, color: UIColor.buttonLight1)
        shakeTypeButtonDescription.text = "Choose shake type"
        
        actionButtonImage.image = UIImage(named: "action3")
        addShadowForStaticView(yourView: actionButtonImage, color: UIColor.buttonLight1)
        actionButtonDescription.text = "Press to start animation"
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        addShadowForStaticView(yourView: backButton, color: UIColor.viewLight1)
        scrollView.backgroundColor = UIColor.backgroundLight
        
        contentView.backgroundColor = UIColor.backgroundLight
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
