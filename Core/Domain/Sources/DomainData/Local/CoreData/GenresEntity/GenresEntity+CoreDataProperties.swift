//
//  GenresEntity+CoreDataProperties.swift
//  MoviesApp
//
//  Created by Ibrahim Salah on 07/08/2024.
//
//

import Foundation
import CoreData
import Domain


extension GenresEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenresEntity> {
        return NSFetchRequest<GenresEntity>(entityName: "GenresEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?

}

extension GenresEntity : Identifiable {

}

public extension Genre {
    
    init(entity: GenresEntity) {
        self.init(
            id: Int(entity.id),
            name: GenreType(rawValue: entity.name ?? "")!
        )
    }
}
