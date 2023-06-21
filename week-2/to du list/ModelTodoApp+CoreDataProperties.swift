//
//  ModelTodoApp+CoreDataProperties.swift
//  to du list
//
//  Created by yacov touati on 20/06/2023.
//

import Foundation
import CoreData

extension ModelTodoApp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ModelTodoApp> {
        return NSFetchRequest<ModelTodoApp>(entityName: "ModelTodoApp")
    }

    @NSManaged public var task: String?
}

