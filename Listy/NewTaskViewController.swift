//
//  NewTaskViewController.swift
//  Listy
//
//  Created by Erica Correa on 6/2/16.
//  Copyright © 2016 Turn to Tech. All rights reserved.
//

import UIKit
import CoreData

class NewTaskViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func addTaskButton(sender: AnyObject) {
        
        //add new task will go here
        guard let taskText = self.newTaskTextField.text
            else { return }
        
        guard let priority:Int = self.prioritySegmentedControl.selectedSegmentIndex
            else { return }
        
        let newTask = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: self.managedObjectContext) as! Task
        
        newTask.text = taskText
        newTask.priority = priority
        newTask.completed = false
        
        do {
            try self.managedObjectContext.save()
            print("added new task \(newTask.text)")
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}
