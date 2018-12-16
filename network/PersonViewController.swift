//
//  PersonViewController.swift
//  network
//
//  Created by student on 2018/12/13.
//  Copyright © 2018年 2016110456. All rights reserved.
//

import UIKit
import Alamofire

class PersonViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var person:[String:String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = person?["stuName"]
        noLabel.text = person?["stuNo"]
        genderLabel.text = person?["stuGender"]
        classLabel.text = person?["stuClass"]
        
        
        if let imagePath = person?["imagePath"] {
            if let url = URL(string: "http://10.0.1.2/\(imagePath)") {
                AF.request(url).responseJSON { (response) in
                    self.imageView.image = UIImage(data: response.data!)
                }
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
