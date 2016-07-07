//
//  TaskListTableViewController.swift
//  Listy
//
//  Created by Erica Correa on 6/2/16.
//  Copyright © 2016 Turn to Tech. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var tasks: Array<Task> = []
    //other way to do it: var tasks = [Task]()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib.init(nibName: "TaskTableViewCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "Cell")
        
        getTasks()
    }
    
    override func viewDidAppear(animated: Bool) {
        getTasks()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TaskTableViewCell

        let task = self.tasks[indexPath.row]
        cell.cellTextLabel.text = task.text
        
        switch task.priority as! Int {
        case 0:
                cell.backgroundColor = UIColor.purpleColor()
                cell.cellTextLabel.textColor = UIColor.whiteColor()
        case 1:
                cell.backgroundColor = UIColor.greenColor()
            cell.cellTextLabel.textColor = UIColor.blackColor()
        case 2:
                cell.backgroundColor = UIColor.magentaColor()
            cell.cellTextLabel.textColor = UIColor.whiteColor()
        default:
                cell.backgroundColor = UIColor.blackColor()
            cell.cellTextLabel.textColor = UIColor.whiteColor()
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    @IBAction func toggleEditMode(sender: AnyObject) {
        if self.editing {
            self.editing = false
        } else {
            self.editing = true
        }
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let task = self.tasks[indexPath.row]
            
            task.completed = true
            
            //save managed object context
            do {
                try self.managedObjectContext.save()
            } catch {
                fatalError("Failure to save context:\(error)")
            }
            
            self.tasks.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getTasks() {
        
        let request = NSFetchRequest(entityName: "Task")
        request.predicate = NSPredicate(format: "completed == %@", "false")
        request.sortDescriptors = [NSSortDescriptor(key: "priority", ascending: false)]
        
        do {
            self.tasks = try self.managedObjectContext.executeFetchRequest(request) as! [Task]
            self.tableView.reloadData()
            
            for text in self.tasks {
                print(text)
            }
            
        } catch {
            fatalError("Failure to fetch \(error)")
        }
    }
}
