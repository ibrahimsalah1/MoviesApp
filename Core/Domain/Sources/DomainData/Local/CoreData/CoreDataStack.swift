//
//  CoreDataStack.swift
//
//
//  Created by Ibrahim Salah on 07/08/2024.
//

import CoreData

public class CoreDataStack {
    
    public static let shared = CoreDataStack()
    private init() {}
    
    public lazy var persistentContainer: NSPersistentContainer = {
        let bundle = Bundle.module
        
        guard let modelURL = bundle.url(
            forResource: "MoviesEntity",
            withExtension: "momd"
        ), let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load model")
        }
        
        let container = NSPersistentContainer(
            name: "MoviesEntity",
            managedObjectModel: model
        )
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
