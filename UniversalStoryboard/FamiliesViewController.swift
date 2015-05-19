//
//  FamiliesViewController.swift
//  UniversalStoryboard
//
//  Created by Wesley Sadler on 1/6/15.
//  Copyright (c) 2015 Digital Sadler. All rights reserved.
//

import UIKit

class FamiliesViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var objects: [String: [String]]!
    var rows: [String]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBirds" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = rows![indexPath.row]
                var objectValues: [String] = objects[object]!
                
                let controller = segue.destinationViewController as! BirdsViewController
                controller.objects = objectValues as Array
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FamiliesCell", forIndexPath: indexPath) as! UITableViewCell
        let object = rows[indexPath.row] as String
        cell.textLabel!.text = object
        return cell
    }
        
}

