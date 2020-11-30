//
//  InfoViewController.swift
//  VirtualHandShaker
//
//  Created by DeNNiO   G on 24.11.2020.
//

import UIKit

class InfoViewController: UIViewController {
    
    
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet var title1: UILabel!
    
    
    @IBOutlet var title2: UILabel!
    
    
    @IBOutlet var title3: UILabel!
    
    
    @IBOutlet var title4: UILabel!
    
    
    @IBOutlet var title5: UILabel!
    
    
    @IBOutlet var imageView1: UIImageView!
    
    
    @IBOutlet var imageView2: UIImageView!
    
    
    @IBOutlet var imageView3: UIImageView!
    
    
    @IBOutlet var imageView4: UIImageView!
    
    
    @IBOutlet var imageView5: UIImageView!
    
    
    @IBOutlet var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Info"
        imageView1.image = UIImage(named: "IMG_2998")
        title1.text = "Some text"
        
        imageView2.image = UIImage(named: "IMG_2998")
        title2.text = "Some text"
        
        imageView3.image = UIImage(named: "IMG_2998")
        title3.text = "Some text"
        
        imageView4.image = UIImage(named: "IMG_2998")
        title4.text = "Some text"
        
        imageView5.image = UIImage(named: "IMG_2998")
        title5.text = "Some text"
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
