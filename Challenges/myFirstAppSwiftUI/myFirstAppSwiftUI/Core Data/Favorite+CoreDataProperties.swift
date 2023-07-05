//
//  Favorite+CoreDataProperties.swift
//  myFirstAppSwiftUI
//
//  Created by yacov touati on 05/07/2023.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?

}

extension Favorite : Identifiable {

}
