//
//  ViewController.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 24.11.2020.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate, UITextFieldDelegate, HandTypeProtocol, ShakeTypeProtocol, NeumorphicShadows {
    
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
    
    var peerId: MCPeerID!
    var mcSession: MCSession?
    var mcAdvertiserAssistant: MCNearbyServiceAdvertiser?
    //x var mcAdvertiserAssistant1: MCAdvertiserAssistant?
    
    @IBOutlet var customConnectButton: UIImageView!
    @IBOutlet var customInfoButton: UIImageView!
    
    @IBOutlet var handTypeShowView: UIImageView!
    @IBOutlet var shakeTypeShowView: UIImageView!
    
    //for greetings ?
    @IBOutlet var testLabel: UILabel!
    
    @IBOutlet var handImage: UIImageView!
    @IBOutlet var secondHandImage: UIImageView!
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var customActionButton: UIImageView!
    
    @IBOutlet var bangImage: UIImageView!
    
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
    
    
    //? animation
    var startAnimation = false

    var handType = "humanHand"
    var shakeType = "humanHandShake1"
    var userName: String?
    //?
    var greeting = "Hello !"

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        //? add new savings for type
        if let savedName  = defaults.object(forKey: "userName") as? String {
            userName = savedName
            nameTextField.text = savedName
        }
        //? conflict with autoload
        autoShakeTypeChooser()
        
        nameTextField.placeholder = "Enter your name"
        nameTextField.delegate = self
        
        // ? left and right hands
        //@
        handImage.image = UIImage(named: "humanHandLeft1")
        //@
        secondHandImage.image = UIImage(named: "humanHandRight1")
        
        customConnectButton.image = UIImage(named: "connect5")
        addActionForButtons(view: customConnectButton)
        
        customInfoButton.image = UIImage(named: "info5")
        addActionForButtons(view: customInfoButton)
        
        
        nameTextField.backgroundColor = UIColor.viewLight1
        
        //load types from userDefaults ?
        handTypeShowView.image = UIImage(named: handType)
        addActionForButtons(view: handTypeShowView)
        
        //new image
        shakeTypeShowView.image = UIImage(named: shakeType)
        bangImage.image = UIImage(named: "bang1")
        
        addActionForButtons(view: shakeTypeShowView)
        
        customActionButton.image = UIImage(named: "action3")
        addActionForButtons(view: customActionButton)
        
       // view.backgroundColor = UIColor.offWhite
        view.backgroundColor = UIColor.backgroundLight
        
      //  handImage.backgroundColor = .red
       // secondHandImage.backgroundColor = .blue
    }
    
    //solution for problem with shadows and autolayout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Update you're layer based on the new frame
        addShadowForActiveView(yourView: nameTextField, verticalLightShadow: verticalLightShadowForNameTextField, horizontalLightShadow: horizontalLightShadowForNameTextField, horizontalDarkShadow: horizontalDarkShadowForNameTextField, verticalDarkShadow: verticalDarkShadowForNameTextField, color: UIColor.viewLight1)
        
        addShadowForActiveView(yourView: customActionButton, verticalLightShadow: verticalLightShadowForActionButton, horizontalLightShadow: horizontalLightShadowForActionButton, horizontalDarkShadow: horizontalDarkShadowForActionButton, verticalDarkShadow: verticalDarkShadowForActionButton, color: UIColor.viewLight1)
        
        addShadowForActiveView(yourView: customConnectButton, verticalLightShadow: verticalLightShadowForConnectButton, horizontalLightShadow: horizontalLightShadowForConnectButton, horizontalDarkShadow: horizontalDarkShadowForConnectButton, verticalDarkShadow: verticalDarkShadowForConnectButton, color: UIColor.viewLight1)
        
        addShadowForActiveView(yourView: customInfoButton, verticalLightShadow: verticalLightShadowForInfoButton, horizontalLightShadow: horizontalLightShadowForInfoButton, horizontalDarkShadow: horizontalDarkShadowForInfoButton, verticalDarkShadow: verticalDarkShadowForInfoButton, color: UIColor.viewLight1)
        
        addShadowForActiveView(yourView: handTypeShowView, verticalLightShadow: verticalLightShadowForHandTypeButton, horizontalLightShadow: horizontalLightShadowForHandTypeButton, horizontalDarkShadow: horizontalDarkShadowForHandTypeButton, verticalDarkShadow: verticalDarkShadowForHandTypeButton, color: UIColor.buttonLight1)
        
        addShadowForActiveView(yourView: shakeTypeShowView, verticalLightShadow: verticalLightShadowForShakeTypeButton, horizontalLightShadow: horizontalLightShadowForShakeTypeButton, horizontalDarkShadow: horizontalDarkShadowForShakeTypeButton, verticalDarkShadow: verticalDarkShadowForShakeTypeButton, color: UIColor.buttonLight1)
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
        if let name = nameTextField.text {
            userName = name
            let defaults = UserDefaults.standard
            defaults.set(userName, forKey: "userName")
        }
        textField.resignFirstResponder()
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //unused funcs
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
    //? received data
            if let receivedData = String(data: data, encoding: .utf8) {
                self?.startAnimation = NSString(string:receivedData).boolValue
            }
            print(self?.startAnimation)
            
            if let data = String(data: data, encoding: .utf8) {
            self?.testLabel.text = data
            }
        }
    }
    
    //incoming request
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        let ac = UIAlertController(title: "Connection Request", message: "User: \(peerID.displayName) is requesting to join the network.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Allow", style: .default) {[weak self] action in
                invitationHandler(true, self?.mcSession)
                })
            ac.addAction(UIAlertAction(title: "Deny", style: .cancel) {[weak self] action in
                invitationHandler(false, self?.mcSession)
                })
            present(ac, animated: true)
    }
    
    //Connection button
    
    @objc func actionForConnectButton(gest: UILongPressGestureRecognizer) {
        if gest.state == .began {
            shadowChangeByBegan(verticalDarkShadow: verticalDarkShadowForConnectButton, horizontalDarkShadow: horizontalDarkShadowForConnectButton, verticalLightShadow: verticalLightShadowForConnectButton, horizontalLightShadow: horizontalLightShadowForConnectButton)
        } else if gest.state == .ended {
            shadowChangeByEnded(verticalDarkShadow: verticalDarkShadowForConnectButton, horizontalDarkShadow: horizontalDarkShadowForConnectButton, verticalLightShadow: verticalLightShadowForConnectButton, horizontalLightShadow: horizontalLightShadowForConnectButton)
            
            mcSessionConfig()
            let ac = UIAlertController(title: "Connect View", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Start Hosting", style: .default, handler: startHosting))
            ac.addAction(UIAlertAction(title: "Join Session", style: .default, handler: joinSession))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            ac.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.backgroundLight

            ac.view.tintColor = UIColor.tintColorForAlertController1
            present(ac, animated: true)
        }
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
    }
    
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        let mcBrowser = MCBrowserViewController(serviceType: "social-distance", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    func sendData() {
        //?
        let stringVar = "true"
        
        guard let mcSession = mcSession else { return }
        if mcSession.connectedPeers.count > 0 {
            //?
            if let dataToSend = stringVar.data(using: .utf8){
                print(dataToSend)
            do {
                try mcSession.send(dataToSend, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch {
                let ac = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                present(ac, animated: true)
            }
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
        autoShakeTypeChooser()
        handTypeShowView.image = UIImage(named: "\(handType)")
        switch handType {
        case "humanHand":
            //@
            handImage.image = UIImage(named: "humanHandLeft1")
            //@
            secondHandImage.image = UIImage(named: "humanHandRight1")
        case "robotHand":
            handImage.image = UIImage(named: "robotHandLeft")
            secondHandImage.image = UIImage(named: "robotHandRight")
        case "womanHand":
            handImage.image = UIImage(named: "womanHandLeft")
            secondHandImage.image = UIImage(named: "womanHandRight")
        case "scullHand":
            handImage.image = UIImage(named: "scullHandLeft")
            secondHandImage.image = UIImage(named: "scullHandRight")
        case "alienHand":
            handImage.image = UIImage(named: "alienHandLeft")
            secondHandImage.image = UIImage(named: "alienHandRight")
        case "zombieHand":
            handImage.image = UIImage(named: "zombieHandLeft")
            secondHandImage.image = UIImage(named: "zombieHandRight")
        default:
            //@
            handImage.image = UIImage(named: "humanHandLeft1")
            //@
            secondHandImage.image = UIImage(named: "humanHandRight1")
        }
        
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
            //sending type of hand ?
        }
    }
    
    func shakeTypeTransferWithProtocol(data: String) {
        shakeType = data
        print(shakeType)
        shakeTypeShowView.image = UIImage(named: shakeType)
        
        switch handType {
        case "humanHand" where shakeType == "humanHandShake1":
            //@
            handImage.image = UIImage(named: "humanHandLeft1")
            //@
            secondHandImage.image = UIImage(named: "humanHandRight1")
        case "humanHand" where shakeType == "humanHandShake2":
            //@
            handImage.image = UIImage(named: "humanFistLeft1_1")
            //@
            secondHandImage.image = UIImage(named: "humanFistRight1_1")
        case "humanHand" where shakeType == "humanHandShake3":
            //@
            handImage.image = UIImage(named: "humanFistLeft1_2")
            //@
            secondHandImage.image = UIImage(named: "humanFistRight1_2")
            
        case "womanHand" where shakeType == "womanHandShake1":
            handImage.image = UIImage(named: "womanHandLeft")
            secondHandImage.image = UIImage(named: "womanHandRight")
        case "womanHand" where shakeType == "womanHandShake2":
            handImage.image = UIImage(named: "womanFistLeft")
            secondHandImage.image = UIImage(named: "womanFistRight")
        case "womanHand" where shakeType == "womanHandShake3":
            handImage.image = UIImage(named: "womanFistLeft")
            secondHandImage.image = UIImage(named: "womanFistRight")
        
        case "zombieHand" where shakeType == "zombieHandShake1":
            handImage.image = UIImage(named: "zombieHandLeft")
            secondHandImage.image = UIImage(named: "zombieHandRight")
        case "zombieHand" where shakeType == "zombieHandShake2":
            handImage.image = UIImage(named: "zombieFistLeft")
            secondHandImage.image = UIImage(named: "zombieFistRight")
        case "zombieHand" where shakeType == "zombieHandShake3":
            handImage.image = UIImage(named: "zombieFistLeft2")
            secondHandImage.image = UIImage(named: "zombieFistRight2")
            
        case "robotHand" where shakeType == "robotHandShake1":
            handImage.image = UIImage(named: "robotHandLeft")
            secondHandImage.image = UIImage(named: "robotHandRight")
        case "robotHand" where shakeType == "robotHandShake2":
            handImage.image = UIImage(named: "robotFistLeft")
            secondHandImage.image = UIImage(named: "robotFistRight")
        case "robotHand" where shakeType == "robotHandShake3":
            handImage.image = UIImage(named: "robotFistLeft")
            secondHandImage.image = UIImage(named: "robotFistRight")
            
        case "alienHand" where shakeType == "alienHandShake1":
            handImage.image = UIImage(named: "alienHandLeft")
            secondHandImage.image = UIImage(named: "alienHandRight")
        case "alienHand" where shakeType == "alienHandShake2":
            handImage.image = UIImage(named: "alienFistLeft")
            secondHandImage.image = UIImage(named: "alienFistRight")
        case "alienHand" where shakeType == "alienHandShake3":
            handImage.image = UIImage(named: "alienFistLeft")
            secondHandImage.image = UIImage(named: "alienFistRight")
            
        case "scullHand" where shakeType == "scullHandShake1":
            handImage.image = UIImage(named: "scullHandLeft")
            secondHandImage.image = UIImage(named: "scullHandRight")
        case "scullHand" where shakeType == "scullHandShake2":
            handImage.image = UIImage(named: "scullFistLeft")
            secondHandImage.image = UIImage(named: "scullFistRight")
        case "scullHand" where shakeType == "scullHandShake3":
            handImage.image = UIImage(named: "scullFistLeft")
            secondHandImage.image = UIImage(named: "scullFistRight")
        
        default:
            print("unknown")
        }
    }
    
    @objc func actionForActionButton(gest: UILongPressGestureRecognizer) {
        if gest.state == .began {
            shadowChangeByBegan(verticalDarkShadow: verticalDarkShadowForActionButton, horizontalDarkShadow: horizontalDarkShadowForActionButton, verticalLightShadow: verticalLightShadowForActionButton, horizontalLightShadow: horizontalLightShadowForActionButton)
            
        } else if gest.state == .ended {
            shadowChangeByEnded(verticalDarkShadow: verticalDarkShadowForActionButton, horizontalDarkShadow: horizontalDarkShadowForActionButton, verticalLightShadow: verticalLightShadowForActionButton, horizontalLightShadow: horizontalLightShadowForActionButton)
            handShake()
        }
    }
    
    //ActionCVC
    //? not used still animation settings
    @IBAction func actionTapped(_ sender: Any) {
       // handShake()
        print(handType)
        print(shakeType)
    }
    
    //Animation
    func handShake() {
        //Step 1. Animate all user interface elements like swiping out from screen
        UIView.animate(withDuration: 1) {
            self.customConnectButton.transform = CGAffineTransform(translationX: self.connectButtonLeadingConstraint.constant - 300, y: self.connectButtonTopConstraint.constant - 300)

            self.nameTextField.transform = CGAffineTransform(translationX: 0, y: self.nameTextfieldTopConstraint.constant - 300)
            
            self.customInfoButton.transform = CGAffineTransform(translationX: self.infoButtonTrailingConstraint.constant + 300, y: self.infoButtonTopConstraint.constant - 300)
            
            self.handTypeShowView.transform = CGAffineTransform(translationX: self.handTypeLeadingConstraint.constant - 500, y: 0)
            
            self.shakeTypeShowView.transform = CGAffineTransform(translationX: self.shakeTypeTrailingConstraint.constant + 500, y: 0)
            
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

        } completion: { [weak handImage, weak secondHandImage] completed in
            guard completed, let leftHand = handImage, let rightHand = secondHandImage else { return }
            
            //Step 2. Appearance of users hands in corners
            UIView.animate(withDuration: 1) {
                leftHand.transform = CGAffineTransform(translationX: self.view.frame.minX - self.leftHandLeadingConstraint.constant, y: self.view.frame.minY - self.leftHandTopConstraint.constant)
                rightHand.transform = CGAffineTransform(translationX: self.view.frame.minX - self.rightHandTrailingConstraint.constant  , y: self.view.frame.minY - self.rightHandBottomConstraint.constant )
            } completion: { [weak handImage, weak secondHandImage]completed in
                guard completed, let leftHand = handImage, let rightHand = secondHandImage else { return }
                //animation for different type of shakes
                switch self.shakeType {
                //Hand Shake 1
                case "womanHandShake1", "humanHandShake1", "alienHandShake1", "robotHandShake1", "zombieHandShake1", "scullHandShake1":
                    // Step1. move hands in center [lr]
                    UIView.animate(withDuration: 1) {
                        leftHand.transform = CGAffineTransform(translationX: self.view.frame.midX - self.leftHandLeadingConstraint.constant - self.handImage.frame.width / 2, y: self.view.frame.midY - self.leftHandTopConstraint.constant - self.handImage.frame.height / 2)
                        rightHand.transform = CGAffineTransform(translationX:  -self.view.frame.midX - self.rightHandTrailingConstraint.constant + self.secondHandImage.frame.width / 2, y: -self.view.frame.midY - self.rightHandBottomConstraint.constant + self.secondHandImage.frame.height / 2)
                    } completion: { completed in
                        guard completed else { return }
                        //Step2. move all objects in initial position
                        UIView.animate(withDuration: 0.8) {
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
                case "womanHandShake2", "humanHandShake2", "alienHandShake2", "robotHandShake2", "zombieHandShake2", "scullHandShake2":
                    // Step 1. l@
                    //          @r
                    UIView.animate(withDuration: 0.5) {
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
                case "womanHandShake3", "humanHandShake3", "alienHandShake3", "robotHandShake3", "zombieHandShake3", "scullHandShake3":
                    //Step 1. l@  @r
                    UIView.animate(withDuration: 1) {
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
                                    self.customConnectButton.transform = .identity
                                    self.customInfoButton.transform = .identity
                                    self.nameTextField.transform = .identity
                                    self.handImage.transform = .identity
                                    self.secondHandImage.transform = .identity
                                    self.handTypeShowView.transform = .identity
                                    self.shakeTypeShowView.transform = .identity
                                    self.customActionButton.transform = .identity
                                    self.bangImage.isHidden = true
                                    self.perform(#selector(self.showShadows), with: nil, afterDelay: 0.7)
                                }
                            }
                        }
                    }
                default:
                    print("Unknown type")
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
    }
    
    func autoShakeTypeChooser() {
        print("woof")
        switch handType {
        case "humanHand":
            shakeType = "humanHandShake1"
            shakeTypeShowView.image = UIImage(named: shakeType)
        case "womanHand":
            shakeType = "womanHandShake1"
            shakeTypeShowView.image = UIImage(named: shakeType)
        case "zombieHand":
            shakeType = "zombieHandShake1"
            shakeTypeShowView.image = UIImage(named: shakeType)
        case "robotHand":
            shakeType = "robotHandShake1"
            shakeTypeShowView.image = UIImage(named: shakeType)
        case "scullHand":
            shakeType = "scullHandShake1"
            shakeTypeShowView.image = UIImage(named: shakeType)
        case "alienHand":
            shakeType = "alienHandShake1"
            shakeTypeShowView.image = UIImage(named: shakeType)
        default:
            shakeType = "humanHandShake1"
            shakeTypeShowView.image = UIImage(named: shakeType)
        }
    }
    
}

