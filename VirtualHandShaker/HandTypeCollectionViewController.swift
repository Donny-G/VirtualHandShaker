//
//  HandTypeCollectionViewController.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 24.11.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol HandTypeProtocol {
    //?type
    func handTypeTransferWithProtocol(data: String)
}

class HandTypeCollectionViewController: UICollectionViewController, NeumorphicShadows {
    
    let verticalLightShadow = CAShapeLayer()
    let horizontalLightShadow = CAShapeLayer()
    let horizontalDarkShadow = CAShapeLayer()
    let verticalDarkShadow = CAShapeLayer()
    
    var handImages = [HandTypes.humanHand.rawValue, HandTypes.womanHand.rawValue, HandTypes.zombieHand.rawValue, HandTypes.robotHand.rawValue, HandTypes.alienHand.rawValue, HandTypes.scullHand.rawValue]
    var delegate: HandTypeProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.backgroundLight
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    //?
    //  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //    return 1
    //  }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return handImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HandType", for: indexPath)
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = UIImage(named: handImages[indexPath.item])
            //!
            addShadowForStaticView(yourView: cell, color: UIColor.buttonLight1)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HandType", for: indexPath)
        addShadowForActiveViewVer2(yourView: cell, verticalLightShadow: verticalLightShadow, horizontalLightShadow: horizontalLightShadow, horizontalDarkShadow: horizontalDarkShadow, verticalDarkShadow: verticalDarkShadow, color: UIColor.buttonLight1)
        
        shadowChangeByBeganVer2(verticalDarkShadow: verticalDarkShadow, horizontalDarkShadow: horizontalDarkShadow, verticalLightShadow: verticalLightShadow, horizontalLightShadow: horizontalLightShadow)
        
        let hand = handImages[indexPath.item]
        delegate?.handTypeTransferWithProtocol(data: hand)
        perform(#selector(backToMain(indexPath:)), with: nil, afterDelay: 0.5)
    }
    
    @objc func backToMain(indexPath: IndexPath) {
       //x shadowChangeByEndedVer2(verticalDarkShadow: verticalDarkShadow, horizontalDarkShadow: horizontalDarkShadow, verticalLightShadow: verticalLightShadow, horizontalLightShadow: horizontalLightShadow)
       
        dismiss(animated: true, completion: nil)
    }

}
