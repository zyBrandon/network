//
//  JSONViewController.swift
//  network
//
//  Created by student on 2018/12/13.
//  Copyright © 2018年 2016110456. All rights reserved.
//

import UIKit
import Alamofire

class JSONViewController: UIViewController {
    
    var  person: [[String:String]]?

    let url = URL(string: "http://10.0.1.2/piclist.php")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loadwithURL(_ sender: Any) {
        if let data = try? Data(contentsOf: url) {
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:String]]{
                for person in json {
                    print("name:\(person["stuName"]!)")
                }
            }
        }
    }
    @IBAction func loadwithsession(_ sender: Any) {
        let task = URLSession.shared.dataTask(with: url) { (data, respomse, error) in
            if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:String]]{
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ShowPersonList", sender: self)
                }
            }
        }
        task.resume()
    }
    @IBAction func loadwithAF(_ sender: Any) {
        AF.request(url).responseJSON { (response) in
            self.person = response.value as! [[String:String]]
            self.performSegue(withIdentifier: "ShowPersonList", sender: self)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowPersonList" {
            if let secVC = segue.destination as? PersonTableViewController {
                secVC.person = self.person
            }
        }
    }
 

}
