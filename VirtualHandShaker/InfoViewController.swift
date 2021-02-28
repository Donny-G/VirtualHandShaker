//
//  InfoViewController.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 24.11.2020.
//

import UIKit
import SafariServices

class InfoViewController: UIViewController, AttributedString, NeumorphicShadows {
    
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
    
    @IBOutlet var tagline: UILabel!
    
    @IBOutlet var mailMeText: UILabel!
    
    @IBOutlet var mailMeButton: UIButton!
    
    @IBOutlet var gueszText: UILabel!
    
    @IBOutlet var goToGueszLink: UIButton!
    
    @IBOutlet var habientText: UILabel!
    
    @IBOutlet var goToHabientLink: UIButton!
    
    @IBOutlet var logo: UIImageView!
    
    let linkForHabient = "https://apps.apple.com/ru/app/habient/id1535207220"
    let linkForGuesz = "https://apps.apple.com/ru/app/guessz/id1472726950"
    let mailString = "d0nny@protonmail.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.attributedText = addAttributesToDescription(string: "i", color: .infoColor2Set())
        
        connectButtonImage.image = UIImage(named: "forInfoCBLight")
        connectButtonDescription.attributedText = addAttributesToDescription(string: NSLocalizedString("ConnectButtonDescriptionIVC", comment: "Description for Connect button"), color: UIColor.infoColor1Set())
        
        connectionViewImage.image = UIImage(named: NSLocalizedString("ConnectionViewImageIVC", comment: "connection image"))
        connectionViewDescription.attributedText = addAttributesToDescription(string: NSLocalizedString("NetworkOptionsIVC", comment: "Online mode description"), color: UIColor.infoColor2Set())
        
        handTypeButtonImage.image = UIImage(named: "forInfoHTBLight")
        handTypeButtonDescription.attributedText = addAttributesToDescription(string: NSLocalizedString("HandTypeDescriptionIVC", comment: "Hand type change"), color: UIColor.infoColor1Set())
        
        shakeTypeButtonImage.image = UIImage(named: "forInfoSTBLight")
        shakeTypeButtonDescription.attributedText = addAttributesToDescription(string: NSLocalizedString("ShakeTypeDEscriptionIVC", comment: "Handshake change"), color: UIColor.infoColor2Set())
        
        actionButtonImage.image = UIImage(named: "forInfoABLight")
        actionButtonDescription.attributedText = addAttributesToDescription(string: NSLocalizedString("ActionButtonDescription", comment: "Action button description"), color: UIColor.infoColor1Set())
        
        backButton.setImage(UIImage(named: "backButtonLight"), for: .normal)
        
        scrollView.backgroundColor = UIColor.backgroundColorSet()
        
        contentView.backgroundColor = UIColor.backgroundColorSet()
        
        tagline.attributedText = addAttributesToDescriptionLarge(string: NSLocalizedString("TaglineIVC", comment: "Tagline"), color: UIColor.infoColor2Set())
        
        mailMeText.attributedText = addAttributesToDescription(string: NSLocalizedString("MailMeIVC", comment: "Mail me"), color: UIColor.infoColor1Set())
        mailMeButton.setImage(UIImage(named: "mailMe"), for: .normal)
        
        gueszText.attributedText = addAttributesToDescription(string: NSLocalizedString("GuessZLabelIVC", comment: "Game label"), color: UIColor.infoColor2Set())
        goToGueszLink.setImage(UIImage(named: "guesszLogo"), for: .normal)
        
        
        habientText.attributedText = addAttributesToDescription(string: NSLocalizedString("HabientLabelIVC", comment: "Habient label"), color: UIColor.infoColor1Set())
        goToHabientLink.setImage(UIImage(named: "habientLogo"), for: .normal)
        
        logo.image = UIImage(named: "logoImage")
    }

    
    func showLink(link: String) {
        if let url = URL(string: link) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    func mailMe() {
        if let mailURL = URL(string: "mailto:\(mailString)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(mailURL)
            }
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func sendMeMail(_ sender: UIButton) {
        mailMe()
    }
    
    @IBAction func goToGueszLink(_ sender: UIButton) {
        showLink(link: linkForGuesz)
    }
    
    @IBAction func goToHabientLink(_ sender: UIButton) {
        showLink(link: linkForHabient)
    }
    
}
