//
//  ViewController.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 24.11.2020.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate, UITextFieldDelegate, HandTypeProtocol, ShakeTypeProtocol, NeumorphicShadows, AttributedString {
    
//shadows
    let verticalLightShadowForConnectButton = CAShapeLayer()
    let horizontalLightShadowForConnectButton = CAShapeLayer()
    let horizontalDarkShadowForConnectButton = CAShapeLayer()
    let verticalDarkShadowForConnectButton = CAShapeLayer()
    
    let verticalLightShadowForInfoButton = CAShapeLayer()
    let horizontalLightShadowForInfoButton = CAShapeLayer()
    let horizontalDarkShadowForInfoButton = CAShapeLayer()
    let verticalDarkShadowForInfoButton = CAShapeLayer()
    
    let verticalLightShadowForHandTypeButton = CAShapeLayer()
    let horizontalLightShadowForHandTypeButton = CAShapeLayer()
    let horizontalDarkShadowForHandTypeButton = CAShapeLayer()
    let verticalDarkShadowForHandTypeButton = CAShapeLayer()
    
    let verticalLightShadowForShakeTypeButton = CAShapeLayer()
    let horizontalLightShadowForShakeTypeButton = CAShapeLayer()
    let horizontalDarkShadowForShakeTypeButton = CAShapeLayer()
    let verticalDarkShadowForShakeTypeButton = CAShapeLayer()
    
    let verticalLightShadowForActionButton = CAShapeLayer()
    let horizontalLightShadowForActionButton = CAShapeLayer()
    let horizontalDarkShadowForActionButton = CAShapeLayer()
    let verticalDarkShadowForActionButton = CAShapeLayer()
    
    let verticalLightShadowForNameTextField = CAShapeLayer()
    let horizontalLightShadowForNameTextField = CAShapeLayer()
    let horizontalDarkShadowForNameTextField = CAShapeLayer()
    let verticalDarkShadowForNameTextField = CAShapeLayer()
    
    let verticalLightShadowForGreetingsTextField = CAShapeLayer()
    let horizontalLightShadowForGreetingsTextField = CAShapeLayer()
    let horizontalDarkShadowForGreetingsTextField = CAShapeLayer()
    let verticalDarkShadowForGreetingsTextField = CAShapeLayer()
    
    let verticalLightShadowForGreetingsTextLabel = CAShapeLayer()
    let horizontalLightShadowForGreetingsTextLabel = CAShapeLayer()
    let horizontalDarkShadowForGreetingsTextLabel = CAShapeLayer()
    let verticalDarkShadowForGreetingsTextLabel = CAShapeLayer()
    
    var peerId: MCPeerID!
    var mcSession: MCSession?
    var mcAdvertiserAssistant: MCNearbyServiceAdvertiser?
    
    @IBOutlet var customConnectButton: UIImageView!
    @IBOutlet var customInfoButton: UIImageView!
    @IBOutlet var handTypeShowView: UIImageView!
    @IBOutlet var shakeTypeShowView: UIImageView!
    @IBOutlet var greetingsLabel: UILabel!
    @IBOutlet var greetingsTextField: UITextField!
    @IBOutlet var handImage: UIImageView!
    @IBOutlet var secondHandImage: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var customActionButton: UIImageView!
    @IBOutlet var bangImage: UIImageView!
    @IBOutlet var friendNameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    
    //constraint outlets
    @IBOutlet var connectButtonLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var connectButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var nameTextfieldTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var infoButtonTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var infoButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var handTypeLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var shakeTypeTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet var actionButtonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var leftHandLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var leftHandTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var rightHandTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var rightHandBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var friendNameLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet var friendNameLabelXConstraint: NSLayoutConstraint!
    
    @IBOutlet var userNameLabelBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var userNameLabelXConstraint: NSLayoutConstraint!
    
    @IBOutlet var handImageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var greetingsTextFieldTopConstraint: NSLayoutConstraint!
    
    //solo
    var handType = HandTypes.humanHand.rawValue
    var shakeType = HandShakeTypes.handShake1.rawValue
    var shakeTypeImage = HandShakeTypeImages.humanHandShake1.rawValue
    //multi
    var online = false
    var friendShakeType: String?
    var friendHandType: String?
    var userName: String?
    var friendName: String?
    var greeting: String?
    var defaultGreeting = NSLocalizedString("DefaultGreetingMVC", comment: "greeting for default")
    
    var activeTextField : UITextField? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
    
        if let savedName  = defaults.object(forKey: "userName") as? String {
            userName = savedName
            nameTextField.text = savedName
        }
        
        if let savedHandType = defaults.object(forKey: "handType") as? String {
            handType = savedHandType
        }
        
        if let savedShakeType = defaults.object(forKey: "shakeType") as? String {
            shakeType = savedShakeType
        }
        
        if let savedGreeting = defaults.object(forKey: "greeting") as? String {
            greeting = savedGreeting
            greetingsTextField.text = greeting
        } else {
            greeting = defaultGreeting
        }
        
        autoShakeTypeChooser(fromHandTypeCollectionView: true)
        
        greetingsTextField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(5))
        greetingsTextField.textColor = UIColor.textFieldTextColorSet()
        nameTextField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(5))
        nameTextField.textColor = UIColor.textFieldTextColorSet()
        nameTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("NamePlaceHolderMVC", comment: "text for nameTextField placeholder"), attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFieldPlaceholderColorSet().withAlphaComponent(0.6)])
        nameTextField.delegate = self
        
        greetingsTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("GreetingsPlaceHolderMVC", comment: "text for greetingsTextfield placeholder"), attributes: [NSAttributedString.Key.foregroundColor: UIColor.textFieldPlaceholderColorSet().withAlphaComponent(0.6)])
        greetingsTextField.delegate = self
        
        customConnectButton.image = UIImage(named: "connect5")
        addActionForButtons(view: customConnectButton)
        
        customInfoButton.image = UIImage(named: "info5")
        addActionForButtons(view: customInfoButton)
        
        nameTextField.backgroundColor = UIColor.textFieldColorSet()
        greetingsTextField.backgroundColor = UIColor.textFieldColorSet()
        
        handTypeShowView.image = UIImage(named: handType)
        
        addActionForButtons(view: handTypeShowView)
        addActionForButtons(view: shakeTypeShowView)
        
        bangImage.image = UIImage(named: "bang1")
        
        customActionButton.image = UIImage(named: "action3")
        addActionForButtons(view: customActionButton)
        
        view.backgroundColor = UIColor.backgroundColorSet()
        
        userNameLabel.attributedText = addAttributesToNameLabel(string: userName ?? "User", color: UIColor.userLabelColorSet())
        userNameLabel.numberOfLines = 0
        
        friendNameLabel.numberOfLines = 0
        friendNameLabel.attributedText = addAttributesToNameLabel(string: NSLocalizedString("FriendMVC", comment: "default name for second user labelname"), color: UIColor.friendLabelColorSet())
        
        greetingsLabel.alpha = 0
        verticalLightShadowForGreetingsTextLabel.opacity = 0
        horizontalLightShadowForGreetingsTextLabel.opacity = 0
        horizontalDarkShadowForGreetingsTextLabel.opacity = 0
        verticalDarkShadowForGreetingsTextLabel.opacity = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        var shouldMoveViewUp = false
          // if active text field is not nil
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    //solution for problem with shadows and autolayout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Update layer based on the new frame
        addShadowForActiveView(yourView: nameTextField, verticalLightShadow: verticalLightShadowForNameTextField, horizontalLightShadow: horizontalLightShadowForNameTextField, horizontalDarkShadow: horizontalDarkShadowForNameTextField, verticalDarkShadow: verticalDarkShadowForNameTextField, color: UIColor.textFieldColorSet())
        
        addShadowForActiveView(yourView: greetingsLabel, verticalLightShadow: verticalLightShadowForGreetingsTextLabel, horizontalLightShadow: horizontalLightShadowForGreetingsTextLabel, horizontalDarkShadow: horizontalDarkShadowForGreetingsTextLabel, verticalDarkShadow: verticalDarkShadowForGreetingsTextLabel, color: UIColor.textFieldColorSet())
        
        addShadowForActiveView(yourView: greetingsTextField, verticalLightShadow: verticalLightShadowForGreetingsTextField, horizontalLightShadow: horizontalLightShadowForGreetingsTextField, horizontalDarkShadow: horizontalDarkShadowForGreetingsTextField, verticalDarkShadow: verticalDarkShadowForGreetingsTextField, color: UIColor.textFieldColorSet())
        
        addShadowForActiveView(yourView: customActionButton, verticalLightShadow: verticalLightShadowForActionButton, horizontalLightShadow: horizontalLightShadowForActionButton, horizontalDarkShadow: horizontalDarkShadowForActionButton, verticalDarkShadow: verticalDarkShadowForActionButton, color: UIColor.buttonColorSet())
        
        addShadowForActiveView(yourView: customConnectButton, verticalLightShadow: verticalLightShadowForConnectButton, horizontalLightShadow: horizontalLightShadowForConnectButton, horizontalDarkShadow: horizontalDarkShadowForConnectButton, verticalDarkShadow: verticalDarkShadowForConnectButton, color: UIColor.buttonColorSet())
        
        addShadowForActiveView(yourView: customInfoButton, verticalLightShadow: verticalLightShadowForInfoButton, horizontalLightShadow: horizontalLightShadowForInfoButton, horizontalDarkShadow: horizontalDarkShadowForInfoButton, verticalDarkShadow: verticalDarkShadowForInfoButton, color: UIColor.buttonColorSet())
        
        addShadowForActiveView(yourView: handTypeShowView, verticalLightShadow: verticalLightShadowForHandTypeButton, horizontalLightShadow: horizontalLightShadowForHandTypeButton, horizontalDarkShadow: horizontalDarkShadowForHandTypeButton, verticalDarkShadow: verticalDarkShadowForHandTypeButton, color: UIColor.showViewColorSet())
        
        addShadowForActiveView(yourView: shakeTypeShowView, verticalLightShadow: verticalLightShadowForShakeTypeButton, horizontalLightShadow: horizontalLightShadowForShakeTypeButton, horizontalDarkShadow: horizontalDarkShadowForShakeTypeButton, verticalDarkShadow: verticalDarkShadowForShakeTypeButton, color: UIColor.showViewColorSet())
     }
    
    func addActionForButtons(view: UIView) {
        let gesture = UILongPressGestureRecognizer()
        gesture.minimumPressDuration = 0.001
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
        switch view {
        case customConnectButton:
            gesture.addTarget(self, action: #selector(actionForConnectButton(gest:)))
        case customInfoButton:
            gesture.addTarget(self, action: #selector(actionForInfoButton(gest:)))
        case handTypeShowView:
            gesture.addTarget(self, action: #selector(actionForHandTypeButton(gest:)))
        case shakeTypeShowView:
            gesture.addTarget(self, action: #selector(actionForShakeTypeButton(gest:)))
        case customActionButton:
            gesture.addTarget(self, action: #selector(actionForActionButton(gest:)))
        default:
            print("unknown view")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let defaults = UserDefaults.standard
        
        if let name = nameTextField.text {
            if !name.isEmpty {
            userName = name
            userNameLabel.attributedText = addAttributesToNameLabel(string: userName ?? "User", color: UIColor.userLabelColorSet())
            defaults.set(userName, forKey: "userName")
            } else {
                userName = nil
            }
        }
        
        if let greetingsFromTextField = greetingsTextField.text {
            if !greetingsFromTextField.isEmpty {
            greeting = greetingsFromTextField
                defaults.set(greeting, forKey: "greeting")
            } else {
                greeting = defaultGreeting
                defaults.set(greeting, forKey: "greeting")
            }
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //unused
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
    
    //info about peer session
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected: \(peerId.displayName)")
        case .connecting:
            print("Connecting: \(peerId.displayName)")
        case .notConnected:
            print("Not Connected: \(peerId.displayName)")
        @unknown default:
            print("Unknown state: \(peerId.displayName)")
        }
    }
    
    //receive data from another user
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            [weak self] in
            do {
                let inputData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: String]
                self?.friendNameLabel.text = inputData?["name"]
                self?.leftOrRightHandSettings(hand: self?.handType ?? HandTypes.humanHand.rawValue, shake: inputData?["shakeType"] ?? HandShakeTypes.handShake1.rawValue, leftHand: false)
                self?.leftOrRightHandSettings(hand: inputData?["handType"] ?? HandTypes.humanHand.rawValue, shake: inputData?["shakeType"] ?? HandShakeTypes.handShake1.rawValue, leftHand: true)
                self?.friendName = inputData?["name"]
                self?.friendHandType = inputData?["handType"] ?? HandTypes.humanHand.rawValue
                self?.friendShakeType = inputData?["shakeType"] ?? HandShakeTypes.handShake1.rawValue
                self?.handShake(shakeType: inputData?["shakeType"] ?? HandShakeTypes.handShake1.rawValue)
                self?.greetingsLabel.attributedText = self?.addAttributesToMessageLabel(string: inputData?["greeting"] ?? "Hello", color: UIColor.messageColorSet())
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func leftOrRightHandSettings(hand: String, shake: String, leftHand: Bool) {
        switch hand {
        case HandTypes.humanHand.rawValue where shake == HandShakeTypes.handShake1.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftHumanHand.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightHumanHand.rawValue))
        case HandTypes.humanHand.rawValue where shake == HandShakeTypes.handShake2.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftHumanFistV1.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightHumanFistV1.rawValue))
        case HandTypes.humanHand.rawValue where shake == HandShakeTypes.handShake3.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftHumanFistV2.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightHumanFistV2.rawValue))
        case HandTypes.womanHand.rawValue where shake == HandShakeTypes.handShake1.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftWomanHand.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightWomanHand.rawValue))
        case HandTypes.womanHand.rawValue where shake == HandShakeTypes.handShake2.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftWomanFistV1.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightWomanFistV1.rawValue))
        case HandTypes.womanHand.rawValue where shake == HandShakeTypes.handShake3.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftWomanFistV2.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightWomanFistV2.rawValue))
        case HandTypes.zombieHand.rawValue where shake == HandShakeTypes.handShake1.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftZombieHand.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightZombieHand.rawValue))
        case HandTypes.zombieHand.rawValue where shake == HandShakeTypes.handShake2.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftZombieFistV1.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightZombieFistV1.rawValue))
        case HandTypes.zombieHand.rawValue where shake == HandShakeTypes.handShake3.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftZombieFistV2.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightZombieFistV2.rawValue))
        case HandTypes.robotHand.rawValue where shake == HandShakeTypes.handShake1.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftRobotHand.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightRobotHand.rawValue))
        case HandTypes.robotHand.rawValue where shake == HandShakeTypes.handShake2.rawValue:
            leftHand ?  (handImage.image = UIImage(named: LeftHandImages.leftRobotFistV1.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightRobotFistV1.rawValue))
        case HandTypes.robotHand.rawValue where shake == HandShakeTypes.handShake3.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftRobotFistV2.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightRobotFistV2.rawValue))
        case HandTypes.alienHand.rawValue where shake == HandShakeTypes.handShake1.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftAlienHand.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightAlienHand.rawValue))
        case HandTypes.alienHand.rawValue where shake == HandShakeTypes.handShake2.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftAlienFistV1.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightAlienFistV1.rawValue))
        case HandTypes.alienHand.rawValue where shake  == HandShakeTypes.handShake3.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftAlienFistV2.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightAlienFistV2.rawValue))
        case HandTypes.scullHand.rawValue where shake == HandShakeTypes.handShake1.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftScullHand.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightScullHand.rawValue))
        case HandTypes.scullHand.rawValue where shake == HandShakeTypes.handShake2.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftScullFistV1.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightScullFistV1.rawValue))
        case HandTypes.scullHand.rawValue where shake == HandShakeTypes.handShake3.rawValue:
            leftHand ? (handImage.image = UIImage(named: LeftHandImages.leftScullFistV2.rawValue)) : (secondHandImage.image = UIImage(named: RightHandImages.rightScullFistV2.rawValue))
        default:
            print("unknown type in func left or right hand \(hand) \(shake) \(leftHand)")
        }
    }
    
    //incoming request
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        let ac = UIAlertController(title: NSLocalizedString("ConnectionRequestMVC", comment: "title for ac confirming connection request"), message: "\(NSLocalizedString("UserMVC", comment: "User"))\(peerID.displayName) \(NSLocalizedString("ActionFromUserMVC", comment: "ask for confirmation"))", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: NSLocalizedString("AllowMVC", comment: "Allow access"), style: .default) {[weak self] action in
                invitationHandler(true, self?.mcSession)
                })
        ac.addAction(UIAlertAction(title: NSLocalizedString("DenyMVC", comment: "Deny access"), style: .cancel) {[weak self] action in
                invitationHandler(false, self?.mcSession)
                })
        ac.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.backgroundColorSet()
        ac.view.tintColor = UIColor.friendLabelColorSet()
            present(ac, animated: true)
    }
    
    @objc func actionForConnectButton(gest: UILongPressGestureRecognizer) {
        if gest.state == .began {
            shadowChangeByBegan(verticalDarkShadow: verticalDarkShadowForConnectButton, horizontalDarkShadow: horizontalDarkShadowForConnectButton, verticalLightShadow: verticalLightShadowForConnectButton, horizontalLightShadow: horizontalLightShadowForConnectButton)
        } else if gest.state == .ended {
            shadowChangeByEnded(verticalDarkShadow: verticalDarkShadowForConnectButton, horizontalDarkShadow: horizontalDarkShadowForConnectButton, verticalLightShadow: verticalLightShadowForConnectButton, horizontalLightShadow: horizontalLightShadowForConnectButton)
            if userName != nil {
                mcSessionConfig()
                let ac = UIAlertController(title: NSLocalizedString("ConnectViewMVC", comment: "Network options"), message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: NSLocalizedString("StartSessionMVC", comment: "Start network session"), style: .default, handler: startHosting))
                ac.addAction(UIAlertAction(title: NSLocalizedString("JoinSessionMVC", comment: "Join current network session"), style: .default, handler: joinSession))
                ac.addAction(UIAlertAction(title: NSLocalizedString("StopSessionMVC", comment: "Stop current session and go to offline mode"), style: .default, handler: stopNetwork))
                ac.addAction(UIAlertAction(title: NSLocalizedString("CancelMVC", comment: "Cancel"), style: .cancel))
                ac.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.backgroundColorSet()
                ac.view.tintColor = UIColor.friendLabelColorSet()
                present(ac, animated: true)
            } else {
                let ac = UIAlertController(title: NSLocalizedString("WarningMVC", comment: "Warning"), message: NSLocalizedString("WarningMessageAboutNameMVC", comment: "Message"), preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                ac.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.backgroundColorSet()
                ac.view.tintColor = UIColor.friendLabelColorSet()
                present(ac, animated: true)
            }
        }
    }
    
    func stopNetwork(action: UIAlertAction) {
        mcAdvertiserAssistant?.stopAdvertisingPeer()
        online = false
        friendShakeType = nil
        friendHandType =  nil
        friendName = nil
    }
    
    func mcSessionConfig() {
        peerId = MCPeerID(displayName: userName ?? UIDevice.current.name)
        mcSession = MCSession(peer: peerId, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }
    
    func startHosting(action: UIAlertAction) {
        mcAdvertiserAssistant = MCNearbyServiceAdvertiser(peer: peerId, discoveryInfo: nil, serviceType: "social-distance")
        mcAdvertiserAssistant?.delegate = self
        mcAdvertiserAssistant?.startAdvertisingPeer()
        online = true
    }
    
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        let mcBrowser = MCBrowserViewController(serviceType: "social-distance", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
        online = true
    }
    
    func sendData() {
        guard let mcSession = mcSession else { return }
        if mcSession.connectedPeers.count > 0 {
            let dictToSend = ["name": userName, "greeting": greeting, "handType": handType, "shakeType": shakeType]
            do {
                let dataToSend = try NSKeyedArchiver.archivedData(withRootObject: dictToSend, requiringSecureCoding: false)
                
                try mcSession.send(dataToSend, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch {
                let ac = UIAlertController(title: NSLocalizedString("ErrorMVC", comment: "Error message"), message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                ac.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.backgroundColorSet()
                ac.view.tintColor = UIColor.friendLabelColorSet()
                present(ac, animated: true)
            }
        }
    }
    
    //Info button
    @objc func actionForInfoButton(gest: UILongPressGestureRecognizer) {
        if gest.state == .began {
            shadowChangeByBegan(verticalDarkShadow: verticalDarkShadowForInfoButton, horizontalDarkShadow: horizontalDarkShadowForInfoButton, verticalLightShadow: verticalLightShadowForInfoButton, horizontalLightShadow: horizontalLightShadowForInfoButton)
        } else if gest.state == .ended {
            shadowChangeByEnded(verticalDarkShadow: verticalDarkShadowForInfoButton, horizontalDarkShadow: horizontalDarkShadowForInfoButton, verticalLightShadow: verticalLightShadowForInfoButton, horizontalLightShadow: horizontalLightShadowForInfoButton)
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Info") as? InfoViewController {
                present(vc, animated: true)
            }
        }
    }
    
    //HandTypeCVC
    @objc func actionForHandTypeButton(gest: UILongPressGestureRecognizer) {
        if gest.state == .began {
            shadowChangeByBegan(verticalDarkShadow: verticalDarkShadowForHandTypeButton, horizontalDarkShadow: horizontalDarkShadowForHandTypeButton, verticalLightShadow: verticalLightShadowForHandTypeButton, horizontalLightShadow: horizontalLightShadowForHandTypeButton)
        } else if gest.state == .ended {
            shadowChangeByEnded(verticalDarkShadow: verticalDarkShadowForHandTypeButton, horizontalDarkShadow: horizontalDarkShadowForHandTypeButton, verticalLightShadow: verticalLightShadowForHandTypeButton, horizontalLightShadow: horizontalLightShadowForHandTypeButton)
            performSegue(withIdentifier: "handTypeSegue", sender: self)
        }
    }
    
    func handTypeTransferWithProtocol(data: String) {
        handType = data
        autoShakeTypeChooser(fromHandTypeCollectionView: true)
        handTypeShowView.image = UIImage(named: "\(handType)")
        let defaults = UserDefaults.standard
        defaults.set(handType, forKey: "handType")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "handTypeSegue" {
            if let handVC = segue.destination as? HandTypeCollectionViewController {
                handVC.delegate = self
            }
        } else if segue.identifier == "shakeTypeSegue" {
            if let shakeVC = segue.destination as? ShakeTypeCollectionViewController {
                shakeVC.handType = handType
                shakeVC.delegate = self
            }
        }
    }
    
    //HandShakeCVC
    @objc func actionForShakeTypeButton(gest: UILongPressGestureRecognizer) {
        if gest.state == .began {
            shadowChangeByBegan(verticalDarkShadow: verticalDarkShadowForShakeTypeButton, horizontalDarkShadow: horizontalDarkShadowForShakeTypeButton, verticalLightShadow: verticalLightShadowForShakeTypeButton, horizontalLightShadow: horizontalLightShadowForShakeTypeButton)
        } else if gest.state == .ended {
            shadowChangeByEnded(verticalDarkShadow: verticalDarkShadowForShakeTypeButton, horizontalDarkShadow: horizontalDarkShadowForShakeTypeButton, verticalLightShadow: verticalLightShadowForShakeTypeButton, horizontalLightShadow: horizontalLightShadowForShakeTypeButton)
            performSegue(withIdentifier: "shakeTypeSegue", sender: self)
        }
    }
    
    func shakeTypeTransferWithProtocol(type: String, imageName: String)  {
        shakeType = type
        shakeTypeImage = imageName
        shakeTypeShowView.image = UIImage(named: shakeTypeImage)
        autoShakeTypeChooser(fromHandTypeCollectionView: false)
        let defaults = UserDefaults.standard
        defaults.set(shakeType, forKey: "shakeType")
    }
    
    @objc func actionForActionButton(gest: UILongPressGestureRecognizer) {
        if gest.state == .began {
            shadowChangeByBegan(verticalDarkShadow: verticalDarkShadowForActionButton, horizontalDarkShadow: horizontalDarkShadowForActionButton, verticalLightShadow: verticalLightShadowForActionButton, horizontalLightShadow: horizontalLightShadowForActionButton)
        } else if gest.state == .ended {
            shadowChangeByEnded(verticalDarkShadow: verticalDarkShadowForActionButton, horizontalDarkShadow: horizontalDarkShadowForActionButton, verticalLightShadow: verticalLightShadowForActionButton, horizontalLightShadow: horizontalLightShadowForActionButton)
            if online {
                guard let mcSession = mcSession else { return }
                if mcSession.connectedPeers.count > 0 {
                    leftOrRightHandSettings(hand: friendHandType ?? HandTypes.humanHand.rawValue, shake: shakeType, leftHand: true)
                    leftOrRightHandSettings(hand: handType, shake: shakeType, leftHand: false)
                }
            }
            sendData()
            handShake(shakeType: shakeType)
        }
    }
    
    //Animation
    func handShake(shakeType: String) {
        //Step 1. Animate all user interface elements like swiping out from screen
        UIView.animate(withDuration: 1) {
            self.customConnectButton.transform = CGAffineTransform(translationX: self.connectButtonLeadingConstraint.constant - 300, y: self.connectButtonTopConstraint.constant - 300)

            self.nameTextField.transform = CGAffineTransform(translationX: 0, y: self.nameTextfieldTopConstraint.constant - 300)
            
            self.greetingsTextField.transform = CGAffineTransform(translationX: 0, y: self.greetingsTextFieldTopConstraint.constant + 500)
            
            self.customInfoButton.transform = CGAffineTransform(translationX: self.infoButtonTrailingConstraint.constant + 300, y: self.infoButtonTopConstraint.constant - 300)
            
            self.handTypeShowView.transform = CGAffineTransform(translationX: self.handTypeLeadingConstraint.constant - 1500, y: 0)
            
            self.shakeTypeShowView.transform = CGAffineTransform(translationX: self.shakeTypeTrailingConstraint.constant + 1500, y: 0)
            
            self.customActionButton.transform = CGAffineTransform(translationX: self.view.frame.maxX, y: self.view.frame.maxY)
            //for correct shadow show
            self.verticalLightShadowForConnectButton.isHidden = true
            self.horizontalLightShadowForConnectButton.isHidden = true
            self.horizontalDarkShadowForConnectButton.isHidden = true
            self.verticalDarkShadowForConnectButton.isHidden = true
            
            self.verticalLightShadowForInfoButton.isHidden = true
            self.horizontalLightShadowForInfoButton.isHidden = true
            self.horizontalDarkShadowForInfoButton.isHidden = true
            self.verticalDarkShadowForInfoButton.isHidden = true
            
            self.verticalLightShadowForHandTypeButton.isHidden = true
            self.horizontalLightShadowForHandTypeButton.isHidden = true
            self.horizontalDarkShadowForHandTypeButton.isHidden = true
            self.verticalDarkShadowForHandTypeButton.isHidden = true
            
            self.verticalLightShadowForShakeTypeButton.isHidden = true
            self.horizontalLightShadowForShakeTypeButton.isHidden = true
            self.horizontalDarkShadowForShakeTypeButton.isHidden = true
            self.verticalDarkShadowForShakeTypeButton.isHidden = true
            
            self.verticalLightShadowForActionButton.isHidden = true
            self.horizontalLightShadowForActionButton.isHidden = true
            self.horizontalDarkShadowForActionButton.isHidden = true
            self.verticalDarkShadowForActionButton.isHidden = true
            
            self.verticalLightShadowForNameTextField.isHidden = true
            self.horizontalLightShadowForNameTextField.isHidden = true
            self.horizontalDarkShadowForNameTextField.isHidden = true
            self.verticalDarkShadowForNameTextField.isHidden = true
            
            self.verticalLightShadowForGreetingsTextField.isHidden = true
            self.horizontalLightShadowForGreetingsTextField.isHidden = true
            self.horizontalDarkShadowForGreetingsTextField.isHidden = true
            self.verticalDarkShadowForGreetingsTextField.isHidden = true
            
        } completion: { [weak handImage, weak secondHandImage] completed in
            guard completed, let leftHand = handImage, let rightHand = secondHandImage else { return }
            
            //Step 2. Appearance of users hands in corners
            UIView.animate(withDuration: 1) {
                leftHand.transform = CGAffineTransform(translationX: self.view.frame.minX - self.leftHandLeadingConstraint.constant, y: self.view.frame.minY - self.leftHandTopConstraint.constant)
                rightHand.transform = CGAffineTransform(translationX: self.view.frame.minX - self.rightHandTrailingConstraint.constant  , y: self.view.frame.minY - self.rightHandBottomConstraint.constant )
                if self.online {
                    self.userNameLabel.transform = CGAffineTransform(translationX: self.view.frame.minX - self.rightHandTrailingConstraint.constant , y: self.view.frame.minY - self.rightHandBottomConstraint.constant)
                    self.friendNameLabel.transform = CGAffineTransform(translationX: self.view.frame.minX - self.leftHandLeadingConstraint.constant, y: self.view.frame.minY - self.leftHandTopConstraint.constant)
                    if self.friendName != nil{
                    self.greetingsLabel.alpha = 1
                    self.verticalLightShadowForGreetingsTextLabel.opacity = 1
                    self.horizontalLightShadowForGreetingsTextLabel.opacity = 1
                    self.horizontalDarkShadowForGreetingsTextLabel.opacity = 1
                    self.verticalDarkShadowForGreetingsTextLabel.opacity = 1
                    }
                }
                
            } completion: { [weak handImage, weak secondHandImage]completed in
                guard completed, let leftHand = handImage, let rightHand = secondHandImage else { return }
                
                //animation for different type of shakes
                switch shakeType {
                //Hand Shake 1
                case HandShakeTypes.handShake1.rawValue:
                    // Step1. move hands in center [lr]
                    UIView.animate(withDuration: 1, delay: 1) {
                        if self.online {
                            self.userNameLabel.alpha = 0
                            self.friendNameLabel.alpha = 0
                            self.greetingsLabel.alpha = 0
                            self.verticalLightShadowForGreetingsTextLabel.opacity = 0
                            self.horizontalLightShadowForGreetingsTextLabel.opacity = 0
                            self.horizontalDarkShadowForGreetingsTextLabel.opacity = 0
                            self.verticalDarkShadowForGreetingsTextLabel.opacity = 0
                        }
                        leftHand.transform = CGAffineTransform(translationX: self.view.frame.midX - self.leftHandLeadingConstraint.constant - self.handImage.frame.width / 2, y: self.view.frame.midY - self.leftHandTopConstraint.constant - self.handImage.frame.height / 2)
                        rightHand.transform = CGAffineTransform(translationX:  -self.view.frame.midX - self.rightHandTrailingConstraint.constant + self.secondHandImage.frame.width / 2, y: -self.view.frame.midY - self.rightHandBottomConstraint.constant + self.secondHandImage.frame.height / 2)
                    } completion: { completed in
                        guard completed else { return }
                        //Step2. move all objects in initial position
                        UIView.animate(withDuration: 0.8) {
                            if self.online {
                                self.userNameLabel.transform = .identity
                                self.friendNameLabel.transform = .identity
                                self.userNameLabel.alpha = 1
                                self.friendNameLabel.alpha = 1
                            }
                            self.greetingsTextField.transform = .identity
                            self.customConnectButton.transform = .identity
                            self.customInfoButton.transform = .identity
                            self.nameTextField.transform = .identity
                            self.handImage.transform = .identity
                            self.secondHandImage.transform = .identity
                            self.handTypeShowView.transform = .identity
                            self.shakeTypeShowView.transform = .identity
                            self.customActionButton.transform = .identity
                            self.perform(#selector(self.showShadows), with: nil, afterDelay: 0.7)
                        }
                    }
                //Hand Shake 2
                case HandShakeTypes.handShake2.rawValue:
                    // Step 1. l@
                    //          @r
                    UIView.animate(withDuration: 0.5, delay: 1) {
                        if self.online {
                            self.userNameLabel.alpha = 0
                            self.friendNameLabel.alpha = 0
                            self.greetingsLabel.alpha = 0
                            self.verticalLightShadowForGreetingsTextLabel.opacity = 0
                            self.horizontalLightShadowForGreetingsTextLabel.opacity = 0
                            self.horizontalDarkShadowForGreetingsTextLabel.opacity = 0
                            self.verticalDarkShadowForGreetingsTextLabel.opacity = 0
                        }
                        leftHand.transform = CGAffineTransform(translationX: self.view.frame.midX - self.leftHandLeadingConstraint.constant - self.handImage.frame.width * 0.8, y: self.view.frame.midY - self.leftHandTopConstraint.constant - self.handImage.frame.height * 0.9)
                        rightHand.transform = CGAffineTransform(translationX:  -self.view.frame.midX - self.rightHandTrailingConstraint.constant + self.secondHandImage.frame.width * 0.8, y: -self.view.frame.midY - self.rightHandBottomConstraint.constant + self.secondHandImage.frame.height * 0.9)
                    } completion: { completed in
                        guard completed, let leftHand = handImage, let rightHand = secondHandImage else { return }
                        // Step2. l@
                        //             @r
                        UIView.animate(withDuration: 0.5) {
                            leftHand.transform = CGAffineTransform(translationX: self.view.frame.midX - self.leftHandLeadingConstraint.constant - self.handImage.frame.width * 1.25, y: self.view.frame.midY - self.leftHandTopConstraint.constant - self.handImage.frame.height * 0.9)
                            rightHand.transform = CGAffineTransform(translationX:  -self.view.frame.midX - self.rightHandTrailingConstraint.constant + self.secondHandImage.frame.width * 1.25, y: -self.view.frame.midY - self.rightHandBottomConstraint.constant + self.secondHandImage.frame.height * 0.9)
                        } completion: { completed in
                            guard completed, let leftHand = handImage, let rightHand = secondHandImage else { return }
                            //Step3.      @r
                            //       l@
                            UIView.animate(withDuration: 0.5) {
                                leftHand.transform = CGAffineTransform(translationX: self.view.frame.midX - self.leftHandLeadingConstraint.constant - self.handImage.frame.width * 1.25, y: self.view.frame.midY - self.leftHandTopConstraint.constant - self.handImage.frame.height / 2)
                                rightHand.transform = CGAffineTransform(translationX:  -self.view.frame.midX - self.rightHandTrailingConstraint.constant + self.secondHandImage.frame.width * 1.25, y: -self.view.frame.midY - self.rightHandBottomConstraint.constant + self.secondHandImage.frame.height / 2)
                            } completion: { completed in
                                guard completed, let leftHand = handImage, let rightHand = secondHandImage else { return }
                                //Step4.  @r
                                
                                
                                //       l@
                                UIView.animate(withDuration: 0.5) {
                                    leftHand.transform = CGAffineTransform(translationX: self.view.frame.midX - self.leftHandLeadingConstraint.constant - self.handImage.frame.width * 0.8, y: self.view.frame.maxY - self.leftHandTopConstraint.constant - self.handImage.frame.height * 2)
                                    rightHand.transform = CGAffineTransform(translationX:  -self.view.frame.midX - self.rightHandTrailingConstraint.constant + self.secondHandImage.frame.width * 0.8, y: -self.view.frame.maxY - self.rightHandBottomConstraint.constant + self.secondHandImage.frame.height * 2)
                                } completion: { completed in
                                    guard completed, let leftHand = handImage, let rightHand = secondHandImage else { return }
                                    //Step 5. @r
                                    //       l@
                                    UIView.animate(withDuration: 0.5) {
                                        leftHand.transform = CGAffineTransform(translationX: self.view.frame.midX - self.leftHandLeadingConstraint.constant - self.handImage.frame.width * 0.8, y: self.view.frame.midY - self.leftHandTopConstraint.constant - self.handImage.frame.height * 0.6)
                                        rightHand.transform = CGAffineTransform(translationX:  -self.view.frame.midX - self.rightHandTrailingConstraint.constant + self.secondHandImage.frame.width * 0.8, y: -self.view.frame.midY - self.rightHandBottomConstraint.constant + self.secondHandImage.frame.height * 0.6)
                                    } completion: { completed in
                                        guard completed, let leftHand = handImage, let rightHand = secondHandImage else { return }
                                        //Step 6.   @r
                                        //      l@
                                        UIView.animate(withDuration: 0.5) {
                                            leftHand.transform = CGAffineTransform(translationX: self.view.frame.midX - self.leftHandLeadingConstraint.constant - self.handImage.frame.width * 1.25, y: self.view.frame.midY - self.leftHandTopConstraint.constant - self.handImage.frame.height * 0.6)
                                            rightHand.transform = CGAffineTransform(translationX:  -self.view.frame.midX - self.rightHandTrailingConstraint.constant + self.secondHandImage.frame.width * 1.25, y: -self.view.frame.midY - self.rightHandBottomConstraint.constant + self.secondHandImage.frame.height * 0.6)
                                        } completion: { completed in
                                            guard completed, let leftHand = handImage, let rightHand = secondHandImage else { return }
                                            //Step 7. l@  @r
                                            UIView.animate(withDuration: 0.5) {
                                                leftHand.transform = CGAffineTransform(translationX: self.view.frame.midX - self.leftHandLeadingConstraint.constant - self.handImage.frame.width * 1.25, y: self.view.frame.midY - self.leftHandTopConstraint.constant - self.handImage.frame.height)
                                                rightHand.transform = CGAffineTransform(translationX:  -self.view.frame.midX - self.rightHandTrailingConstraint.constant + self.secondHandImage.frame.width * 1.25, y: -self.view.frame.midY - self.rightHandBottomConstraint.constant + self.secondHandImage.frame.height / 2)
                                            } completion: { completed in
                                                guard completed, let leftHand = handImage, let rightHand = secondHandImage else { return }
                                                //Step 8. r@@l
                                                UIView.animate(withDuration: 0.5) {
                                                    leftHand.transform = CGAffineTransform(translationX: self.view.frame.midX - self.leftHandLeadingConstraint.constant - self.handImage.frame.width * 0.95, y: self.view.frame.midY - self.leftHandTopConstraint.constant - self.handImage.frame.height)
                                                    rightHand.transform = CGAffineTransform(translationX:  -self.view.frame.midX - self.rightHandTrailingConstraint.constant + self.secondHandImage.frame.width * 0.95, y: -self.view.frame.midY - self.rightHandBottomConstraint.constant + self.secondHandImage.frame.height / 2)
                                                } completion: { completed in
                                                    guard completed else { return }
                                                    //Step 9. Initial stage
                                                    UIView.animate(withDuration: 0.8) {
                                                        if self.online {
                                                            self.userNameLabel.transform = .identity
                                                            self.friendNameLabel.transform = .identity
                                                            self.userNameLabel.alpha = 1
                                                            self.friendNameLabel.alpha = 1
                                                        }
                                                        self.greetingsTextField.transform = .identity
                                                        self.customConnectButton.transform = .identity
                                                        self.customInfoButton.transform = .identity
                                                        self.nameTextField.transform = .identity
                                                        self.handImage.transform = .identity
                                                        self.secondHandImage.transform = .identity
                                                        self.handTypeShowView.transform = .identity
                                                        self.shakeTypeShowView.transform = .identity
                                                        self.customActionButton.transform = .identity
                                                        self.perform(#selector(self.showShadows), with: nil, afterDelay: 0.7)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                //Hand Shake 3
                case HandShakeTypes.handShake3.rawValue:
                    //Step 1. l@  @r
                    UIView.animate(withDuration: 1, delay: 1) {
                        if self.online {
                            self.userNameLabel.alpha = 0
                            self.friendNameLabel.alpha = 0
                            self.greetingsLabel.alpha = 0
                            self.verticalLightShadowForGreetingsTextLabel.opacity = 0
                            self.horizontalLightShadowForGreetingsTextLabel.opacity = 0
                            self.horizontalDarkShadowForGreetingsTextLabel.opacity = 0
                            self.verticalDarkShadowForGreetingsTextLabel.opacity = 0
                        }
                        leftHand.transform = CGAffineTransform(translationX: self.view.frame.midX - self.leftHandLeadingConstraint.constant - self.handImage.frame.width * 1.2, y: self.view.frame.midY - self.leftHandTopConstraint.constant - self.handImage.frame.height / 2)
                        rightHand.transform = CGAffineTransform(translationX:  -self.view.frame.midX - self.rightHandTrailingConstraint.constant + self.secondHandImage.frame.width * 1.2, y: -self.view.frame.midY - self.rightHandBottomConstraint.constant + self.secondHandImage.frame.height / 2)
                    } completion: { completed in
                        guard completed, let leftHand = handImage, let rightHand = secondHandImage else { return }
                        //Step2. l@@r
                        UIView.animate(withDuration: 0.3) {
                            leftHand.transform = CGAffineTransform(translationX: self.view.frame.midX - self.leftHandLeadingConstraint.constant - self.handImage.frame.width, y: self.view.frame.midY - self.leftHandTopConstraint.constant - self.handImage.frame.height / 2)
                            rightHand.transform = CGAffineTransform(translationX:  -self.view.frame.midX - self.rightHandTrailingConstraint.constant + self.secondHandImage.frame.width, y: -self.view.frame.midY - self.rightHandBottomConstraint.constant + self.secondHandImage.frame.height / 2)
                        } completion: { completed in
                            guard completed, let bang = self.bangImage else { return }
                            //Step3. Bang animation
                            UIView.animate(withDuration: 1) {
                                bang.isHidden = false
                                bang.transform = CGAffineTransform(scaleX: 3, y: 3)
                            } completion: { completed in
                                guard completed else { return }
                                //Step4. initial stage
                                UIView.animate(withDuration: 1) {
                                    if self.online {
                                        self.userNameLabel.transform = .identity
                                        self.friendNameLabel.transform = .identity
                                        self.userNameLabel.alpha = 1
                                        self.friendNameLabel.alpha = 1
                                    }
                                    self.greetingsTextField.transform = .identity
                                    self.customConnectButton.transform = .identity
                                    self.customInfoButton.transform = .identity
                                    self.nameTextField.transform = .identity
                                    self.handImage.transform = .identity
                                    self.secondHandImage.transform = .identity
                                    self.handTypeShowView.transform = .identity
                                    self.shakeTypeShowView.transform = .identity
                                    self.customActionButton.transform = .identity
                                    self.bangImage.isHidden = true
                                    self.bangImage.transform = .identity
                                    self.perform(#selector(self.showShadows), with: nil, afterDelay: 0.7)
                                }
                            }
                        }
                    }
                default:
                    print("Unknown type \(self.shakeType)")
                }
            }
        }
    }
    
    @objc func showShadows() {
        self.verticalLightShadowForConnectButton.isHidden = false
        self.horizontalLightShadowForConnectButton.isHidden = false
        self.horizontalDarkShadowForConnectButton.isHidden = false
        self.verticalDarkShadowForConnectButton.isHidden = false
        
        self.verticalLightShadowForInfoButton.isHidden = false
        self.horizontalLightShadowForInfoButton.isHidden = false
        self.horizontalDarkShadowForInfoButton.isHidden = false
        self.verticalDarkShadowForInfoButton.isHidden = false
        
        self.verticalLightShadowForHandTypeButton.isHidden = false
        self.horizontalLightShadowForHandTypeButton.isHidden = false
        self.horizontalDarkShadowForHandTypeButton.isHidden = false
        self.verticalDarkShadowForHandTypeButton.isHidden = false
        
        self.verticalLightShadowForShakeTypeButton.isHidden = false
        self.horizontalLightShadowForShakeTypeButton.isHidden = false
        self.horizontalDarkShadowForShakeTypeButton.isHidden = false
        self.verticalDarkShadowForShakeTypeButton.isHidden = false
        
        self.verticalLightShadowForActionButton.isHidden = false
        self.horizontalLightShadowForActionButton.isHidden = false
        self.horizontalDarkShadowForActionButton.isHidden = false
        self.verticalDarkShadowForActionButton.isHidden = false
        
        self.verticalLightShadowForNameTextField.isHidden = false
        self.horizontalLightShadowForNameTextField.isHidden = false
        self.horizontalDarkShadowForNameTextField.isHidden = false
        self.verticalDarkShadowForNameTextField.isHidden = false
        
        self.verticalLightShadowForGreetingsTextField.isHidden = false
        self.horizontalLightShadowForGreetingsTextField.isHidden = false
        self.horizontalDarkShadowForGreetingsTextField.isHidden = false
        self.verticalDarkShadowForGreetingsTextField.isHidden = false
        //solution for bug with online mode
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func autoShakeTypeChooser(fromHandTypeCollectionView: Bool) {
        switch handType {
        case HandTypes.humanHand.rawValue where shakeType == HandShakeTypes.handShake1.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftHumanHand.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightHumanHand.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.humanHandShake1.rawValue)
            }
        case HandTypes.humanHand.rawValue where shakeType == HandShakeTypes.handShake2.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftHumanFistV1.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightHumanFistV1.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.humanHandShake2.rawValue)
            }
        case HandTypes.humanHand.rawValue where shakeType == HandShakeTypes.handShake3.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftHumanFistV2.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightHumanFistV2.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.humanHandShake3.rawValue)
            }
        case HandTypes.womanHand.rawValue where shakeType == HandShakeTypes.handShake1.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftWomanHand.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightWomanHand.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.womanHandShake1.rawValue)
            }
        case HandTypes.womanHand.rawValue where shakeType == HandShakeTypes.handShake2.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftWomanFistV1.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightWomanFistV1.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.womanHandShake2.rawValue)
            }
        case HandTypes.womanHand.rawValue where shakeType == HandShakeTypes.handShake3.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftWomanFistV2.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightWomanFistV2.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.womanHandShake3.rawValue)
            }
        case HandTypes.zombieHand.rawValue where shakeType == HandShakeTypes.handShake1.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftZombieHand.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightZombieHand.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.zombieHandShake1.rawValue)
            }
        case HandTypes.zombieHand.rawValue where shakeType == HandShakeTypes.handShake2.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftZombieFistV1.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightZombieFistV1.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.zombieHandShake2.rawValue)
            }
        case HandTypes.zombieHand.rawValue where shakeType == HandShakeTypes.handShake3.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftZombieFistV2.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightZombieFistV2.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.zombieHandShake3.rawValue)
            }
        case HandTypes.robotHand.rawValue where shakeType == HandShakeTypes.handShake1.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftRobotHand.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightRobotHand.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.robotHandShake1.rawValue)
            }
        case HandTypes.robotHand.rawValue where shakeType == HandShakeTypes.handShake2.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftRobotFistV1.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightRobotFistV1.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.robotHandShake2.rawValue)
            }
        case HandTypes.robotHand.rawValue where shakeType == HandShakeTypes.handShake3.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftRobotFistV2.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightRobotFistV2.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.robotHandShake3.rawValue)
            }
        case HandTypes.alienHand.rawValue where shakeType == HandShakeTypes.handShake1.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftAlienHand.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightAlienHand.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.alienHandShake1.rawValue)
            }
        case HandTypes.alienHand.rawValue where shakeType == HandShakeTypes.handShake2.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftAlienFistV1.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightAlienFistV1.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.alienHandShake2.rawValue)
            }
        case HandTypes.alienHand.rawValue where shakeType == HandShakeTypes.handShake3.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftAlienFistV2.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightAlienFistV2.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.alienHandShake3.rawValue)
            }
        case HandTypes.scullHand.rawValue where shakeType == HandShakeTypes.handShake1.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftScullHand.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightScullHand.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.scullHandShake1.rawValue)
            }
        case HandTypes.scullHand.rawValue where shakeType == HandShakeTypes.handShake2.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftScullFistV1.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightScullFistV1.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.scullHandShake2.rawValue)
            }
        case HandTypes.scullHand.rawValue where shakeType == HandShakeTypes.handShake3.rawValue:
            handImage.image = UIImage(named: LeftHandImages.leftScullFistV2.rawValue)
            secondHandImage.image = UIImage(named: RightHandImages.rightScullFistV2.rawValue)
            if fromHandTypeCollectionView {
                shakeTypeShowView.image = UIImage(named: HandShakeTypeImages.scullHandShake3.rawValue)
            }
        default:
            print("unknown")
        }
    }
}

