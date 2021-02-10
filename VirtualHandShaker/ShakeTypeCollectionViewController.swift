//
//  ShakeTypeCollectionViewController.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 24.11.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

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
    var handType = HandTypes.humanHand.rawValue
    var shakeType = HandShakeTypes.handShake1.rawValue
    var shakeTypeImageName = HandShakeTypeImages.humanHandShake1.rawValue
    var humanShakeTypes = [HandShakeTypeImages.humanHandShake1.rawValue, HandShakeTypeImages.humanHandShake2.rawValue, HandShakeTypeImages.humanHandShake3.rawValue]
    var womanShakeTypes = [HandShakeTypeImages.womanHandShake1.rawValue, HandShakeTypeImages.womanHandShake2.rawValue, HandShakeTypeImages.womanHandShake3.rawValue]
    var zombieShakeTypes = [HandShakeTypeImages.zombieHandShake1.rawValue, HandShakeTypeImages.zombieHandShake2.rawValue, HandShakeTypeImages.zombieHandShake3.rawValue]
    var robotShakeTypes = [HandShakeTypeImages.robotHandShake1.rawValue, HandShakeTypeImages.robotHandShake2.rawValue, HandShakeTypeImages.robotHandShake3.rawValue]
    var scullShakeTypes = [HandShakeTypeImages.scullHandShake1.rawValue, HandShakeTypeImages.scullHandShake2.rawValue, HandShakeTypeImages.scullHandShake3.rawValue]
    var alienShakeTypes = [HandShakeTypeImages.alienHandShake1.rawValue, HandShakeTypeImages.alienHandShake2.rawValue, HandShakeTypeImages.alienHandShake3.rawValue]
    
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
        case HandShakeTypeImages.humanHandShake1.rawValue, HandShakeTypeImages.scullHandShake1.rawValue, HandShakeTypeImages.womanHandShake1.rawValue, HandShakeTypeImages.alienHandShake1.rawValue, HandShakeTypeImages.robotHandShake1.rawValue, HandShakeTypeImages.zombieHandShake1.rawValue:
            shakeType = HandShakeTypes.handShake1.rawValue
        case HandShakeTypeImages.humanHandShake2.rawValue, HandShakeTypeImages.scullHandShake2.rawValue, HandShakeTypeImages.womanHandShake2.rawValue, HandShakeTypeImages.alienHandShake2.rawValue, HandShakeTypeImages.robotHandShake2.rawValue, HandShakeTypeImages.zombieHandShake2.rawValue:
            shakeType = HandShakeTypes.handShake2.rawValue
        case HandShakeTypeImages.humanHandShake3.rawValue, HandShakeTypeImages.scullHandShake3.rawValue, HandShakeTypeImages.alienHandShake3.rawValue, HandShakeTypeImages.womanHandShake3.rawValue, HandShakeTypeImages.robotHandShake3.rawValue, HandShakeTypeImages.zombieHandShake3.rawValue:
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
        case HandTypes.humanHand.rawValue:
            shakeTypes = humanShakeTypes
        case HandTypes.womanHand.rawValue:
            shakeTypes = womanShakeTypes
        case HandTypes.zombieHand.rawValue:
            shakeTypes = zombieShakeTypes
        case HandTypes.scullHand.rawValue:
            shakeTypes = scullShakeTypes
        case HandTypes.robotHand.rawValue:
            shakeTypes = robotShakeTypes
        case HandTypes.alienHand.rawValue:
            shakeTypes = alienShakeTypes
        default:
            shakeTypes = humanShakeTypes
        }
    }


}
