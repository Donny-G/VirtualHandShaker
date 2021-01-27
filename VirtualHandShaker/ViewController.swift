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
    
    //constraint outlets
    @IBOutlet var connectButtonLeadingConstraint: NSLayoutConstraint!
   
    @IBOutlet var connectButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet var nameTextfieldTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var infoButtonTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var infoButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var handTypeLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var shakeTypeTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet var actionButtonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var leftHandTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var leftHandBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var rightHandLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var rightHandTopConstraint: NSLayoutConstraint!
    
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
        handImage.image = UIImage(named: "humanHandLeft")
        secondHandImage.image = UIImage(named: "humanHandRight")
        
        customConnectButton.image = UIImage(named: "connect5")
        addActionForButtons(view: customConnectButton)
        
        customInfoButton.image = UIImage(named: "info5")
        addActionForButtons(view: customInfoButton)
        
        
        nameTextField.backgroundColor = UIColor.viewLight1
        
        //load types from userDefaults ?
        handTypeShowView.image = UIImage(named: handType)
        addActionForButtons(view: handTypeShowView)
        
        shakeTypeShowView.image = UIImage(named: shakeType)
        
        addActionForButtons(view: shakeTypeShowView)
        
        customActionButton.image = UIImage(named: "action3")
        addActionForButtons(view: customActionButton)
        
       // view.backgroundColor = UIColor.offWhite
        view.backgroundColor = UIColor.backgroundLight
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
        UIView.animate(withDuration: 5) {
            self.handImage.transform = CGAffineTransform(translationX: 100, y: 300)
            self.secondHandImage.transform = CGAffineTransform(translationX: -100, y: -300)
          //  self.handImage.transform = CGAffineTransform(rotationAngle: 30)
           // self.secondHandImage.transform = CGAffineTransform(rotationAngle: 40)
            self.perform(#selector(self.initial), with: nil, afterDelay: 5)
        }
    }
    @objc func initial() {
        self.handImage.transform = .identity
        self.secondHandImage.transform = .identity
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

