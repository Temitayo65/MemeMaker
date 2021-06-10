//
//  SentMemesDetailVC.swift
//  MeMe 1.0
//
//  Created by owner on 10/06/2021.
//

import UIKit

class SentMemesDetailVC: UIViewController {
    var meme: Meme!

    @IBOutlet weak var sentMemesImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sentMemesImageView.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    


}
