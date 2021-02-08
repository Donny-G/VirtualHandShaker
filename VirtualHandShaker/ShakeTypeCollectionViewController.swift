//
//  ShakeTypeCollectionViewController.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 24.11.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

public enum HandShakeTypes: String {
    case handShake1 = "handShake1"
    case handShake2 = "handShake2"
    case handShake3 = "handShake3"
}

protocol ShakeTypeProtocol {
    //?
    func shakeTypeTransferWithProtocol(type: String, imageName: String)
}

class ShakeTypeCollectionViewController: UICollectionViewController, NeumorphicShadows {
    
    let verticalLightShadow = CAShapeLayer()
    let horizontalLightShadow = CAShapeLayer()
    let horizontalDarkShadow = CAShapeLayer()
    let verticalDarkShadow = CAShapeLayer()
    
    var shakeTypes = [String]()
    var handType = "humanHand"
    var shakeType = HandShakeTypes.handShake1.rawValue
    var shakeTypeImageName = "humanHandShake1"
    var humanShakeTypes = ["humanHandShake1", "humanHandShake2", "humanHandShake3"]
    var womanShakeTypes = ["womanHandShake1", "womanHandShake2", "womanHandShake3"]
    var zombieShakeTypes = ["zombieHandShake1", "zombieHandShake2", "zombieHandShake3"]
    var robotShakeTypes = ["robotHandShake1", "robotHandShake2", "robotHandShake3"]
    var scullShakeTypes = ["scullHandShake1", "scullHandShake2", "scullHandShake3"]
    var alienShakeTypes = ["alienHandShake1", "alienHandShake2", "alienHandShake3"]
    
    var delegate: ShakeTypeProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.backgroundLight
        print(handType)
        handShakeChooser()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    //?
    //override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //return 0
    //}


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShakeType", for: indexPath)
        if let imageView = cell.viewWithTag(1001) as? UIImageView {
                imageView.image = UIImage(named: shakeTypes[indexPath.item])
            addShadowForStaticView(yourView: cell, color: UIColor.buttonLight1)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShakeType", for: indexPath)
        addShadowForActiveViewVer2(yourView: cell, verticalLightShadow: verticalLightShadow, horizontalLightShadow: horizontalLightShadow, horizontalDarkShadow: horizontalDarkShadow, verticalDarkShadow: verticalDarkShadow, color: UIColor.buttonLight1)
        
        shadowChangeByBeganVer2(verticalDarkShadow: verticalDarkShadow, horizontalDarkShadow: horizontalDarkShadow, verticalLightShadow: verticalLightShadow, horizontalLightShadow: horizontalLightShadow)
        
        let shakeTypeImageName = shakeTypes[indexPath.item]
        switch shakeTypeImageName {
        case "humanHandShake1", "scullHandShake1", "womanHandShake1", "alienHandShake1", "robotHandShake1", "zombieHandShake1":
            shakeType = HandShakeTypes.handShake1.rawValue
        case "humanHandShake2", "scullHandShake2", "womanHandShake2", "alienHandShake2", "robotHandShake2", "zombieHandShake2":
            shakeType = HandShakeTypes.handShake2.rawValue
        case "humanHandShake3","scullHandShake3", "alienHandShake3", "womanHandShake3", "robotHandShake3", "zombieHandShake3":
            shakeType = HandShakeTypes.handShake3.rawValue
        default:
            print("Unknown type")
        }
        delegate?.shakeTypeTransferWithProtocol(type: shakeType, imageName: shakeTypeImageName)
        
        perform(#selector(backToMain(indexPath:)), with: nil, afterDelay: 0.5)
    }
    
    @objc func backToMain(indexPath: IndexPath) {
       //x shadowChangeByEndedVer2(verticalDarkShadow: verticalDarkShadow, horizontalDarkShadow: horizontalDarkShadow, verticalLightShadow: verticalLightShadow, horizontalLightShadow: horizontalLightShadow)
       
        dismiss(animated: true, completion: nil)
    }
    
    func handShakeChooser(){
        switch handType {
        case "humanHand":
            shakeTypes = humanShakeTypes
        case "womanHand":
            shakeTypes = womanShakeTypes
        case "zombieHand":
            shakeTypes = zombieShakeTypes
        case "scullHand":
            shakeTypes = scullShakeTypes
        case "robotHand":
            shakeTypes = robotShakeTypes
        case "alienHand":
            shakeTypes = alienShakeTypes
        default:
            shakeTypes = humanShakeTypes
        }
    }


}
