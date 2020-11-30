//
//  ViewController.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 24.11.2020.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate, UITextFieldDelegate, HandTypeProtocol, ShakeTypeProtocol {
    
    var peerId: MCPeerID!
    var mcSession: MCSession?
    var mcAdvertiserAssistant: MCNearbyServiceAdvertiser?
    //x var mcAdvertiserAssistant1: MCAdvertiserAssistant?
    
    @IBOutlet var testLabel: UILabel!
    
    @IBOutlet var handImage: UIImageView!
    @IBOutlet var secondHandImage: UIImageView!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var actionButton: UIButton!
    
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
        
        handImage.image = UIImage(named: "IMG_2982")
        secondHandImage.image = UIImage(named: "IMG_2982")
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
    
    //Connection
    @IBAction func connectButtonTapped(_ sender: UIButton) {
        mcSessionConfig()
        let ac = UIAlertController(title: "Connect View", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Start Hosting", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join Session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
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
    
    //Info
    @IBAction func infoButtonTapped(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Info") as? InfoViewController {
            present(vc, animated: true)
        }
    }
    
    //HandTypeCVC
    @IBAction func handTypeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "handTypeSegue", sender: self)
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
    @IBAction func shakeTypeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "shakeTypeSegue", sender: self)
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
