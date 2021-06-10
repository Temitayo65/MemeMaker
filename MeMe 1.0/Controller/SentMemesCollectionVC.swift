//
//  SentMemesCollectionVC.swift
//  MeMe 1.0
//
//  Created by owner on 09/06/2021.
//

import UIKit

// private let reuseIdentifier = "Cell"

class SentMemesCollectionVC: UICollectionViewController {
    
    // Using a computed property - setting the meme property to correspond with the appDelegates array of memes
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newMeme))
        navigationItem.title = "Sent Memes"
        self.tabBarController?.tabBar.isHidden = false
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellProps = self.memes[(indexPath as NSIndexPath).row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCell", for: indexPath) as? SentMemesCollectionViewCell{
            cell.imageView.image = cellProps.memedImage
            return cell
        }
        return UICollectionViewCell()
    }
    // selector function for creating new Meme
    @objc func newMeme(){
        if let navigationController = navigationController{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let createMemeController = storyboard.instantiateViewController(identifier: "CreateMemeVC") as! CreateMemeVC
            navigationController.pushViewController(createMemeController, animated: true)
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

