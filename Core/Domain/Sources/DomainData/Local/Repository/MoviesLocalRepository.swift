//
//  MoviesLocalRepository.swift
//
//
//  Created by Ibrahim Salah on 07/08/2024.
//

import Foundation
import Combine
import Domain
import CoreData

public final class MoviesLocalRepository: MoviesLocalRepositoryProtocol {
    
    //MARK: - Properties
    
    private let persistentContainer: NSPersistentContainer
    
    //MARK: - init
    
    public init(
        persistentContainer: NSPersistentContainer = CoreDataStack.shared.persistentContainer
    ) {
        self.persistentContainer = persistentContainer
    }
    
    //MARK: - Methods
    
    public func getMovies(
        for pageIndex: Int
    ) -> AnyPublisher<MoviesResponse, Error> {
        
        let request = MoviesEntity.fetchRequest()
        request.predicate = NSPredicate(
            format: "pageIndex == %d",
            pageIndex
        )
        
        return fetch(request: request, context: persistentContainer.viewContext)
            .map { entities -> MoviesResponse in
                let moviesPage = entities
                    .compactMap {
                        self.decodeJSONString(
                            to: MoviesResponse.self,
                            from: $0.result ?? ""
                        )
                    }
                    .first
                
                return moviesPage ?? MoviesResponse(totalPages: 0, results: [])
            }
            .eraseToAnyPublisher()
    }
    
    public func save(movies: MoviesResponse, pageIndex: Int) {
        
        let context = persistentContainer.newBackgroundContext()
        context.performAndWait {
            let fetchRequest = MoviesEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(
                format: "pageIndex == %d",
                pageIndex
            )
            
            do {
                let results = try context.fetch(fetchRequest)
                let entity = results.first ?? MoviesEntity(context: context)
                entity.pageIndex = Int64(pageIndex)
                entity.result = self.convertToJSONString(from: movies)
                try context.save()
            } catch {
                print("Failed to save movies to core data: \(error)")
            }
        }
    }
    
    private func fetch<T: NSManagedObject>(
        request: NSFetchRequest<T>,
        context: NSManagedObjectContext
    ) -> Future<[T], Error> {
        Future { promise in
            context.perform {
                do {
                    let result = try context.fetch(request)
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
    
    private func convertToJSONString<T: Encodable>(
        from object: T
    ) -> String? {
        guard let jsonData = try? JSONEncoder().encode(object) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
    
    private func decodeJSONString<T: Decodable>(
        to type: T.Type,
        from jsonString: String
    ) -> T? {
        guard let jsonData = jsonString.data(using: .utf8),
              let object = try? JSONDecoder().decode(T.self, from: jsonData) else {
            return nil
        }
        return object
    }
}


public extension MoviesLocalRepository {
    
    func getGenres() -> AnyPublisher<[Genre], Error> {
        let request: NSFetchRequest<GenresEntity> = GenresEntity.fetchRequest()
        return fetch(request: request, context: persistentContainer.viewContext)
            .map { entities in
                entities.map { Genre(entity: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func save(genres: [Genre]) {
        let context = persistentContainer.newBackgroundContext()
        context.performAndWait {
            let request = GenresEntity.fetchRequest()
            
            do {
                let existingEntities = try context.fetch(request)
                let existingIds = Set(existingEntities.map { Int($0.id) })
                
                for genre in genres where !existingIds.contains(genre.id) {
                    let entity = GenresEntity(context: context)
                    entity.id = Int64(genre.id)
                    entity.name = genre.name.rawValue
                }
                
                try context.save()
            } catch {
                print("Failed to save genres to core data: \(error)")
            }
        }
    }
    
}
