//
//  ViewController.swift
//  to du list
//
//  Created by yacov touati on 18/06/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let colorData = [#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),
                     #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1), #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1), #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]
    
    
    var taskData: [NSManagedObject] = []
    
    //var coreDataStack: CoreDataStack = CoreDataStack()  // יצירת מופע של הקלאס
    var managedObjectContext: NSManagedObjectContext!   //
    var entity: NSEntityDescription!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Todu", in: managedObjectContext)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        getSavedData()
        
        //        userDefaults metod
        //        if let todoArray = UserDefaults.standard.array(forKey: "taskData") as? [String] {
        //            taskData = todoArray
        //            }
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func addNEwItem(_ sender: UIBarButtonItem) {
        showAlertWithTextField()
    }
    
    // function popup to add a new task
    private func showAlertWithTextField() {
        let alertController = UIAlertController(title: "Add new task", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text, !text.isEmpty {  // check there is field
                self.saveTask(text: text)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Add new task"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
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
        
        //      userDefaults metod
        //        UserDefaults.standard.set(taskData, forKey: "taskData")
        //        UserDefaults.standard.removeObject(forKey: "taskData")
    }
    
    // function that get the data from the coreData
    private func getSavedData() {
        let request = NSFetchRequest<NSManagedObject>(entityName: "Todu")
        do {
            taskData = try managedObjectContext.fetch(request)
        } catch {
            print("Failed")
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskData", for: indexPath) as! DataCollectionViewCell
        let randomColorIndex = randomIndexFromArray(array: taskData)
        let backgroundColor = colorData[randomColorIndex]
        cell.setup(backgroundColor: backgroundColor, cellData: taskData[indexPath.item])
        return cell
    }
    
    // A function that defines the size of each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width     //   get the view of collection view  -> |--|
        let flowLayut = collectionViewLayout as! UICollectionViewFlowLayout   // access the collectionVeiw
        let spaceBetweenCells = flowLayut.minimumInteritemSpacing    //get the value for the space betwwen the cells
        let adjutedWidth = collectionViewWidth - spaceBetweenCells - 1
        let width: CGFloat = adjutedWidth / 2
        let height: CGFloat = 100
        return CGSize(width: width, height: height)
    }
    
    //function to get randomal number from the array
    func randomIndexFromArray(array: [NSManagedObject]) -> Int {
        let randomIndex = Int.random(in: 0..<array.count)
        return randomIndex
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}
