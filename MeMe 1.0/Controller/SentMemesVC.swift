//
//  SentMemesVC.swift
//  MeMe 1.0
//
//  Created by owner on 09/06/2021.
//

import UIKit

class SentMemesVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var sentMemesTableView: UITableView!
    
    // Acccessing meme array from appDelegate
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newMeme))
        navigationItem.title = "Sent Memes"
        sentMemesTableView.delegate = self
        sentMemesTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        sentMemesTableView.reloadData() // reloads the view with the saved data in the Model
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeCell", for: indexPath)
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText
        cell.detailTextLabel?.text = meme.bottomText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = memes[(indexPath as NSIndexPath).row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sentMemesController = storyboard.instantiateViewController(withIdentifier: "SentMemesDetailVC") as! SentMemesDetailVC
        sentMemesController.meme = cell
        navigationController?.pushViewController(sentMemesController, animated: true)
    }
    
    @objc func newMeme(){
        if let navigationController = navigationController{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let createMemeController = storyboard.instantiateViewController(identifier: "CreateMemeVC") as! CreateMemeVC
            navigationController.pushViewController(createMemeController, animated: true)
        }
    }


}
