//
//  PersonTableViewController.swift
//  network
//
//  Created by student on 2018/12/13.
//  Copyright © 2018年 2016110456. All rights reserved.
//

import UIKit
import Alamofire

class PersonTableViewController: UITableViewController {

    var  person: [[String:String]]?
    let url = URL(string: "http://10.0.1.2/piclist.php")!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    @IBAction func reload(_ sender: Any) {
        refreshControl?.beginRefreshing()
        AF.request(url).responseJSON { (response) in
            self.person = response.value as? [[String:String]]
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return person?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        if let person = person?[indexPath.row] {
            cell.textLabel?.text = "\(person["stuName"]!)"
            cell.detailTextLabel?.text = "\(person["stuNo"]!)"
            if let imagePath = person["imagePath"] {
                if let url = URL(string: "http://10.0.1.2/\(imagePath)") {
                    AF.request(url).responseJSON { (response) in
                        cell.imageView?.image = UIImage(data: response.data!)
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let secVC = segue.destination as? PersonViewController {
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell ){
                secVC.person = person![indexPath.row]
            }
        }
        
    }
 

}
