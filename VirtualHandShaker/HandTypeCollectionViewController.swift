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

class HandTypeCollectionViewController: UICollectionViewController {
    
    var handImages = ["IMG_2982"]
    var delegate: HandTypeProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hand = handImages[indexPath.item]
        delegate?.handTypeTransferWithProtocol(data: hand)
        dismiss(animated: true, completion: nil)
    }

}
