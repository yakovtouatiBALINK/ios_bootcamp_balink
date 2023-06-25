//
//  manageCoreData.swift
//  to du list
//
//  Created by yacov touati on 21/06/2023.
//

import UIKit
import Foundation
import CoreData

class ManageCoreData {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedObjectContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Todu", in: managedObjectContext)
    
    // function that get the task and keef this in the memory of aply
    private func saveTask(text: String) {
        let newTask = NSManagedObject(entity: entity! , insertInto: managedObjectContext)
        newTask.setValue(text, forKey: "task")
        do {
            try managedObjectContext.save()
            self.taskData.append(newTask)
            self.collectionView.reloadData()
        }
        catch {
            print("error")
        }
    }

    func updateTask() {
        
    }

}


