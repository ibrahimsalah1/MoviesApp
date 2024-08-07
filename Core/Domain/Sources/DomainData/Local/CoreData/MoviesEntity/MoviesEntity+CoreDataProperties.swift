//
//  MoviesEntity+CoreDataProperties.swift
//  MoviesApp
//
//  Created by Ibrahim Salah on 07/08/2024.
//
//

import Foundation
import CoreData


extension MoviesEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoviesEntity> {
        return NSFetchRequest<MoviesEntity>(entityName: "MoviesEntity")
    }

    @NSManaged public var pageIndex: Int64
    @NSManaged public var result: String?

}

extension MoviesEntity : Identifiable {

}
