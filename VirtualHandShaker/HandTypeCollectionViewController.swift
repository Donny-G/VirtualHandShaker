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

class HandTypeCollectionViewController: UICollectionViewController, NeumorphicShadows, UICollectionViewDelegateFlowLayout {
    private let spacing:CGFloat = 16.0
    let verticalLightShadow = CAShapeLayer()
    let horizontalLightShadow = CAShapeLayer()
    let horizontalDarkShadow = CAShapeLayer()
    let verticalDarkShadow = CAShapeLayer()
    
    var handImages = [HandTypes.humanHand.rawValue, HandTypes.womanHand.rawValue, HandTypes.zombieHand.rawValue, HandTypes.robotHand.rawValue, HandTypes.alienHand.rawValue, HandTypes.scullHand.rawValue]
    var delegate: HandTypeProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.backgroundColorSet()
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
            addShadowForStaticView(yourView: cell, color: UIColor.showViewColorSet())
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HandType", for: indexPath)
        addShadowForActiveViewVer2(yourView: cell, verticalLightShadow: verticalLightShadow, horizontalLightShadow: horizontalLightShadow, horizontalDarkShadow: horizontalDarkShadow, verticalDarkShadow: verticalDarkShadow, color: UIColor.showViewColorSet())
        
        shadowChangeByBeganVer2(verticalDarkShadow: verticalDarkShadow, horizontalDarkShadow: horizontalDarkShadow, verticalLightShadow: verticalLightShadow, horizontalLightShadow: horizontalLightShadow)
        
        let hand = handImages[indexPath.item]
        delegate?.handTypeTransferWithProtocol(data: hand)
        perform(#selector(backToMain(indexPath:)), with: nil, afterDelay: 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
                let spacingBetweenCells:CGFloat = 16
                
                let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
                
                if let collection = self.collectionView{
                    let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
                    return CGSize(width: width, height: width)
                }else{
                    return CGSize(width: 0, height: 0)
                }
    }
    
    @objc func backToMain(indexPath: IndexPath) {
       //x shadowChangeByEndedVer2(verticalDarkShadow: verticalDarkShadow, horizontalDarkShadow: horizontalDarkShadow, verticalLightShadow: verticalLightShadow, horizontalLightShadow: horizontalLightShadow)
       
        dismiss(animated: true, completion: nil)
    }

}
