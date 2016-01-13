//
//  ListDetailsViewController.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/21/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class ListDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tempListView: UITextView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var addExistingButton: UIButton!
    @IBOutlet weak var addNewButton: UIButton!
    
    var listName: String?
    var listDetailsDic: [Int:String]?
    var listDetails: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        
        print(listName)
        print(listDetailsDic)
        
        if listDetailsDic != nil {
            
        for dictCounter in 1...listDetailsDic!.count {
            listDetails.append(listDetailsDic![dictCounter]!)
        }

        }
            
        print(listDetails)
        
        for x in 1...listDetailsDic!.count {
            if x == 1 {
                tempListView.text = listDetailsDic![x]
            } else {
                tempListView.text = tempListView.text + "\n" + listDetailsDic![x]!
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - TableView
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return nil
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listDetails.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ListDetailsTableViewCell"
        
        let cell = self.listTableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ListDetailsTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let listIngredient = listDetails[indexPath.row]
        let rowNumber = indexPath.row + 1
        cell.listItemNumber.text = String(rowNumber)
        print(listIngredient)
        cell.listItemName.text = listIngredient
        
        return cell
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
        
    
}
