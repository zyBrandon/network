//
//  ViewController.swift
//  network
//
//  Created by student on 2018/12/13.
//  Copyright © 2018年 2016110456. All rights reserved.
//

import UIKit
import Alamofire

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func loadwithURL(_ sender: Any) {
        DispatchQueue.global().async {
            if let url = URL(string: "http://10.0.1.2/pic.php?id=1") {
                if let data = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        self.imageView1.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    @IBAction func loadwithSession(_ sender: Any) {
        if let url = URL(string: "http://10.0.1.2/pic.php?id=2") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    self.imageView2.image = UIImage(data: data!)
                }
            }
            task.resume()
        }
    }
    @IBAction func loadwithAf(_ sender: Any) {
        if let url = URL(string: "http://10.0.1.2/pic.php?id=3") {
            AF.request(url).responseData { (response) in
                self.imageView2.image = UIImage(data: response.data!)
            }
        }
    }
    

}

