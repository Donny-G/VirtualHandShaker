//
//  ViewController.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 24.11.2020.
//

import UIKit
import MultipeerConnectivity

extension UIColor {
    static let offWhite = UIColor.init(red: 225/255, green: 225/255, blue: 235/255, alpha: 1)
    static let customWhiteBackground = UIColor.init(red: 0.937, green: 0.949, blue: 0.984, alpha: 1)
    
    static let backgroundLight = UIColor.init(red: 0.686, green: 0.808, blue: 0.827, alpha: 1)
    static let backgroundDark = UIColor.init(red: 0.616, green: 0.616, blue: 0.714, alpha: 1)
    
    static let buttonLight1 = UIColor.init(red: 0.478, green: 0.737, blue: 0.741, alpha: 1)
    static let buttonDark1 = UIColor.init(red: 0.471, green: 0.451, blue: 0.584, alpha: 1)
    
    static let buttonLight2 = UIColor.init(red: 0.376, green: 0.686, blue: 0.690, alpha: 1)
    static let buttonDark2 = UIColor.init(red: 0.353, green: 0.337, blue: 0.463, alpha: 1)
    
    static let viewLight1 = UIColor.init(red: 1.0, green: 0.765, blue: 0.424, alpha: 1)
    static let viewDark1 = UIColor.init(red: 0.435, green: 0.541, blue: 0.733, alpha: 1)
    
    static let viewLight2 = UIColor.init(red: 0.992, green: 0.675, blue: 0.490, alpha: 1)
}

class ViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate, UITextFieldDelegate, HandTypeProtocol, ShakeTypeProtocol {
    
    let darkShadowForConnectButton = CAShapeLayer()
    let lightShadowForConnectButton = CAShapeLayer()
    
    let darkShadowForInfoButton = CAShapeLayer()
    let lightShadowForInfoButton = CAShapeLayer()
    
    let darkShadowForHandTypeButton = CAShapeLayer()
    let lightShadowForHandTypeButton = CAShapeLayer()
    
    let darkShadowForShakeTypeButton = CAShapeLayer()
    let lightShadowForShakeTypeButton = CAShapeLayer()
    
    let darkShadowForNameTextfield = CAShapeLayer()
    let lightShadowForNameTextfield = CAShapeLayer()
    
    let verticalLightShadow = CAShapeLayer()
    let horizontalLightShadow = CAShapeLayer()
    let horizontalDarkShadow = CAShapeLayer()
    let verticalDarkShadow = CAShapeLayer()
    
    var peerId: MCPeerID!
    var mcSession: MCSession?
    var mcAdvertiserAssistant: MCNearbyServiceAdvertiser?
    //x var mcAdvertiserAssistant1: MCAdvertiserAssistant?
    
    @IBOutlet var customConnectButton: UIImageView!
    @IBOutlet var customInfoButton: UIImageView!
    @IBOutlet var customHandTypeButton: UIImageView!
    @IBOutlet var customShakeTypeButton: UIImageView!
    
  
    @IBOutlet var handTypeShowView: UIImageView!
    
    @IBOutlet var shakeTypeShowView: UIImageView!
    
    @IBOutlet var testLabel: UILabel!
    
    @IBOutlet var handImage: UIImageView!
    @IBOutlet var secondHandImage: UIImageView!
    
    @IBOutlet var nameTextField: UITextField!
    
    
    @IBOutlet var customActionButton: UIImageView!
    
    var startAnimation = false
    //тип неясен
    var handType = "nil"
    var shakeStyle = "nil"
    
    var userName: String?
    var greeting = "Hello !"

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let savedName  = defaults.object(forKey: "userName") as? String {
            userName = savedName
            nameTextField.text = savedName
        }
        nameTextField.placeholder = "Enter your name"
        nameTextField.delegate = self
        //
        handImage.image = UIImage(named: "IMG_2982")
        secondHandImage.image = UIImage(named: "IMG_2982")
        
        customConnectButton.image = UIImage(named: "connect4_1")
        customConnectButton.layer.cornerRadius = customConnectButton.frame.height / 2
        addShadow(view: customConnectButton, darkShadow: darkShadowForConnectButton, lightShadow: lightShadowForConnectButton)
        addActionForButtons(view: customConnectButton)
        
        customInfoButton.image = UIImage(named: "info4")
        customInfoButton.layer.cornerRadius = customInfoButton.frame.height / 2
        addShadow(view: customInfoButton, darkShadow: darkShadowForInfoButton, lightShadow: lightShadowForInfoButton)
        addActionForButtons(view: customInfoButton)
        
        customHandTypeButton.image = UIImage(named: "handType4")
        customHandTypeButton.layer.cornerRadius = customHandTypeButton.frame.height / 2
        addShadow(view: customHandTypeButton, darkShadow: darkShadowForHandTypeButton, lightShadow: lightShadowForHandTypeButton)
        addActionForButtons(view: customHandTypeButton)
        
        customShakeTypeButton.image = UIImage(named: "shakeType4")
        customShakeTypeButton.layer.cornerRadius = customShakeTypeButton.frame.height / 2
        addShadow(view: customShakeTypeButton, darkShadow: darkShadowForShakeTypeButton, lightShadow: lightShadowForShakeTypeButton)
        addActionForButtons(view: customShakeTypeButton)
        
        nameTextField.layer.cornerRadius = nameTextField.frame.height / 2
        addShadow(view: nameTextField, darkShadow: darkShadowForNameTextfield, lightShadow: lightShadowForNameTextfield)
        nameTextField.backgroundColor = UIColor.viewLight1
        
        
        handTypeShowView.image = UIImage(named: "handType1")
        addShadowForStaticView(yourView: handTypeShowView)
        
        shakeTypeShowView.image = UIImage(named: "shakeType1")
        addShadowForStaticView(yourView: shakeTypeShowView)
        
        customActionButton.image = UIImage(named: "action1")
        addShadowForActiveView(yourView: customActionButton, verticalLightShadow: verticalLightShadow, horizontalLightShadow: horizontalLightShadow, horizontalDarkShadow: horizontalDarkShadow, verticalDarkShadow: verticalDarkShadow)
        addActionForView(view: customActionButton)
        
       // view.backgroundColor = UIColor.offWhite
        view.backgroundColor = UIColor.backgroundLight
        
    }
    
    func addActionForView(view: UIView) {
        let gesture = UILongPressGestureRecognizer()
        gesture.minimumPressDuration = 0.001
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
        gesture.addTarget(self, action: #selector(tapped(gest:)))
    }
    
    @objc func tapped(gest: UILongPressGestureRecognizer) {
        if gest.state == .began {
            verticalDarkShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
            horizontalDarkShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
            verticalLightShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            horizontalLightShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            
        } else if gest.state == .ended {
            verticalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            horizontalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            verticalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
            horizontalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
            
        }
    }
    
    func addShadow(view: UIView, darkShadow: CAShapeLayer, lightShadow: CAShapeLayer) {
        //   view.layer.cornerRadius = 50
        view.backgroundColor = UIColor.buttonLight2
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        
        darkShadow.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 50).cgPath
        darkShadow.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.size.width, height: view.frame.height)
        darkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        darkShadow.shadowOffset = CGSize(width: 10, height: 10)
        darkShadow.shadowOpacity = 0.7
        darkShadow.shadowRadius = 4
        darkShadow.shouldRasterize = true
        
        lightShadow.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 50).cgPath
        lightShadow.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.size.width, height: view.frame.height)
        lightShadow.cornerRadius = 15
        lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        lightShadow.shadowOffset = CGSize(width: -10, height: -10)
        lightShadow.shadowRadius = 7
        lightShadow.shadowOpacity = 0.7
        lightShadow.shouldRasterize = true
        
        self.view.layer.insertSublayer(darkShadow, below: view.layer)
        self.view.layer.insertSublayer(lightShadow, below: view.layer)
        }
    func addShadowForActiveView(yourView: UIView,verticalLightShadow: CAShapeLayer, horizontalLightShadow: CAShapeLayer, horizontalDarkShadow: CAShapeLayer, verticalDarkShadow: CAShapeLayer ) {
        yourView.layer.cornerRadius = 20
        yourView.backgroundColor = UIColor.viewLight1
        yourView.layer.masksToBounds = true
        yourView.clipsToBounds = true
        
        yourView.layer.borderWidth = 0.2
        yourView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        horizontalDarkShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: yourView.frame.width - 20, height: 10), cornerRadius: 20).cgPath
        
        horizontalDarkShadow.frame = CGRect(x: yourView.frame.origin.x + 10, y: yourView.frame.origin.y + 3, width: yourView.frame.size.width, height: yourView.frame.height)
         
        horizontalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        horizontalDarkShadow.shadowRadius = 4
        horizontalDarkShadow.shadowOpacity = 0.3
       // horizontalDarkShadow.cornerRadius = 20
        horizontalDarkShadow.shouldRasterize = true
        
        verticalDarkShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 10, height: yourView.frame.height - 10), cornerRadius: 20).cgPath
        verticalDarkShadow.frame = CGRect(x: yourView.frame.origin.x, y: yourView.frame.origin.y, width: yourView.frame.size.width, height: yourView.frame.height)
        verticalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        verticalDarkShadow.shadowOffset = CGSize(width: 0, height: 0)
        verticalDarkShadow.shadowRadius = 4
        verticalDarkShadow.shadowOpacity = 0.3
       // verticalDarkShadow.cornerRadius = 20
        verticalDarkShadow.shouldRasterize = true
        
        verticalLightShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: yourView.frame.width, y: 0, width: 10, height: yourView.frame.height - 10), cornerRadius: 20).cgPath
        verticalLightShadow.frame = CGRect(x: yourView.frame.origin.x - 5, y: yourView.frame.origin.y + 10, width: yourView.frame.size.width, height: yourView.frame.height)
        verticalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        verticalLightShadow.shadowOffset = CGSize(width: -10, height: 0)
        verticalLightShadow.shadowOpacity = 1
        verticalLightShadow.shadowRadius = 7
       // verticalLightShadow.cornerRadius = 20
        verticalLightShadow.shouldRasterize = true
        
        horizontalLightShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: yourView.frame.height, width: yourView.frame.width - 20, height: 10), cornerRadius: 20).cgPath
        horizontalLightShadow.frame = CGRect(x: yourView.frame.origin.x + 10, y: yourView.frame.origin.y - 5, width: yourView.frame.size.width, height: yourView.frame.height)
        horizontalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        horizontalLightShadow.shadowOffset = CGSize(width: 0, height: -10)
        horizontalLightShadow.shadowOpacity = 1
        horizontalLightShadow.shadowRadius = 7
      //  horizontalLightShadow.cornerRadius = 20
        horizontalLightShadow.shouldRasterize = true
        
        self.view.layer.insertSublayer(verticalLightShadow, above: yourView.layer)
        self.view.layer.insertSublayer(horizontalLightShadow, above: yourView.layer)
        self.view.layer.insertSublayer(horizontalDarkShadow, above: yourView.layer)
        self.view.layer.insertSublayer(verticalDarkShadow, above: yourView.layer)
        }
    
    func addShadowForStaticView(yourView: UIView) {
        let verticalLightShadow = CAShapeLayer()
        let horizontalLightShadow = CAShapeLayer()
        let horizontalDarkShadow = CAShapeLayer()
        let verticalDarkShadow = CAShapeLayer()
        
        yourView.layer.cornerRadius = 20
        yourView.backgroundColor = UIColor.buttonLight1
        yourView.layer.masksToBounds = true
        yourView.clipsToBounds = true
        
        yourView.layer.borderWidth = 0.2
        yourView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        horizontalDarkShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: yourView.frame.width - 20, height: 10), cornerRadius: 20).cgPath
        
        horizontalDarkShadow.frame = CGRect(x: yourView.frame.origin.x + 10, y: yourView.frame.origin.y + 3, width: yourView.frame.size.width, height: yourView.frame.height)
         
        horizontalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        horizontalDarkShadow.shadowRadius = 4
        horizontalDarkShadow.shadowOpacity = 0.3
       // horizontalDarkShadow.cornerRadius = 20
        horizontalDarkShadow.shouldRasterize = true
        
        verticalDarkShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 10, height: yourView.frame.height - 10), cornerRadius: 20).cgPath
        verticalDarkShadow.frame = CGRect(x: yourView.frame.origin.x, y: yourView.frame.origin.y, width: yourView.frame.size.width, height: yourView.frame.height)
        verticalDarkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        verticalDarkShadow.shadowOffset = CGSize(width: 0, height: 0)
        verticalDarkShadow.shadowRadius = 4
        verticalDarkShadow.shadowOpacity = 0.3
       // verticalDarkShadow.cornerRadius = 20
        verticalDarkShadow.shouldRasterize = true
        
        verticalLightShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: yourView.frame.width, y: 0, width: 10, height: yourView.frame.height - 10), cornerRadius: 20).cgPath
        verticalLightShadow.frame = CGRect(x: yourView.frame.origin.x - 5, y: yourView.frame.origin.y + 10, width: yourView.frame.size.width, height: yourView.frame.height)
        verticalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        verticalLightShadow.shadowOffset = CGSize(width: -10, height: 0)
        verticalLightShadow.shadowOpacity = 1
        verticalLightShadow.shadowRadius = 7
       // verticalLightShadow.cornerRadius = 20
        verticalLightShadow.shouldRasterize = true
        
        horizontalLightShadow.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: yourView.frame.height, width: yourView.frame.width - 20, height: 10), cornerRadius: 20).cgPath
        horizontalLightShadow.frame = CGRect(x: yourView.frame.origin.x + 10, y: yourView.frame.origin.y - 5, width: yourView.frame.size.width, height: yourView.frame.height)
        horizontalLightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        horizontalLightShadow.shadowOffset = CGSize(width: 0, height: -10)
        horizontalLightShadow.shadowOpacity = 1
        horizontalLightShadow.shadowRadius = 7
      //  horizontalLightShadow.cornerRadius = 20
        horizontalLightShadow.shouldRasterize = true
        
        self.view.layer.insertSublayer(verticalLightShadow, above: yourView.layer)
        self.view.layer.insertSublayer(horizontalLightShadow, above: yourView.layer)
        self.view.layer.insertSublayer(horizontalDarkShadow, above: yourView.layer)
        self.view.layer.insertSublayer(verticalDarkShadow, above: yourView.layer)
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
        case customHandTypeButton:
            gesture.addTarget(self, action: #selector(actionForHandTypeButton(gest:)))
        case customShakeTypeButton:
            gesture.addTarget(self, action: #selector(actionForShakeTypeButton(gest:)))
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
            darkShadowForConnectButton.shadowOffset = CGSize(width: -5, height: -5)
            lightShadowForConnectButton.shadowOffset = CGSize(width: 10, height: 10)
        } else if gest.state == .ended {
            lightShadowForConnectButton.shadowOffset = CGSize(width: -5, height: -5)
            darkShadowForConnectButton.shadowOffset = CGSize(width: 10, height: 10)
            
            mcSessionConfig()
            let ac = UIAlertController(title: "Connect View", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Start Hosting", style: .default, handler: startHosting))
            ac.addAction(UIAlertAction(title: "Join Session", style: .default, handler: joinSession))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
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
            darkShadowForInfoButton.shadowOffset = CGSize(width: -5, height: -5)
            lightShadowForInfoButton.shadowOffset = CGSize(width: 10, height: 10)
        } else if gest.state == .ended {
            lightShadowForInfoButton.shadowOffset = CGSize(width: -5, height: -5)
            darkShadowForInfoButton.shadowOffset = CGSize(width: 10, height: 10)
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Info") as? InfoViewController {
                present(vc, animated: true)
            }
        }
    }
    
    
    //HandTypeCVC
    
    @objc func actionForHandTypeButton(gest: UILongPressGestureRecognizer) {
        if gest.state == .began {
            darkShadowForHandTypeButton.shadowOffset = CGSize(width: -5, height: -5)
            lightShadowForHandTypeButton.shadowOffset = CGSize(width: 10, height: 10)
        } else if gest.state == .ended {
            lightShadowForHandTypeButton.shadowOffset = CGSize(width: -5, height: -5)
            darkShadowForHandTypeButton.shadowOffset = CGSize(width: 10, height: 10)
            
            performSegue(withIdentifier: "handTypeSegue", sender: self)
        }
    }
   
    func handTypeTransferWithProtocol(data: String) {
        handType = data
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "handTypeSegue" {
            if let handVC = segue.destination as? HandTypeCollectionViewController {
                handVC.delegate = self
            }
        } else if segue.identifier == "shakeTypeSegue" {
            if let shakeVC = segue.destination as? ShakeTypeCollectionViewController {
                shakeVC.delegate = self
            }
        }
    }
    
    //HandShakeCVC
    
    @objc func actionForShakeTypeButton(gest: UILongPressGestureRecognizer) {
        if gest.state == .began {
            darkShadowForShakeTypeButton.shadowOffset = CGSize(width: -5, height: -5)
            lightShadowForShakeTypeButton.shadowOffset = CGSize(width: 10, height: 10)
        } else if gest.state == .ended {
            lightShadowForShakeTypeButton.shadowOffset = CGSize(width: -5, height: -5)
            darkShadowForShakeTypeButton.shadowOffset = CGSize(width: 10, height: 10)
            
            performSegue(withIdentifier: "shakeTypeSegue", sender: self)
        }
    }
    
    func shakeTypeTransferWithProtocol(data: String) {
        shakeStyle = data
    }
    
    //ActionCVC
    @IBAction func actionTapped(_ sender: Any) {
       // handShake()
        print(handType)
        print(shakeStyle)
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
    
}

