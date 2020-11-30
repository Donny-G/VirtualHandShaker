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
    func shakeTypeTransferWithProtocol(data: String)
}

class ShakeTypeCollectionViewController: UICollectionViewController {
    
    var shakeImages = ["IMG_2982"]
    var delegate: ShakeTypeProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    //?
    //override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //return 0
    //}


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shakeImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShakeType", for: indexPath)
        if let imageView = cell.viewWithTag(1001) as? UIImageView {
            imageView.image = UIImage(named: shakeImages[indexPath.item])
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shake = shakeImages[indexPath.item]
        delegate?.shakeTypeTransferWithProtocol(data: shake)
        dismiss(animated: true, completion: nil)
    }


}
