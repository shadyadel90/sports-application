//
//  coreDataManager.swift
//  SportsApp
//
//  Created by Shady Adel on 25/08/2024.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavLeagueDB")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Save Data
    func saveLeague(_ league: League) {
        let entity = LeagueEntity(context: context)
        entity.leagueName = league.leagueName
        entity.leagueLogo = league.leagueLogo
        entity.leagueKey = league.leagueKey!
        
        saveContext()
    }
    
    // MARK: - Fetch Data
    func fetchLeagues() -> [LeagueEntity]? {
        let request: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching leagues: \(error)")
            return nil
        }
    }
    
    // MARK: - Remove League
    func removeLeague(_ league: League) {
        let fetchRequest: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()
            
            do {
                let leagues = try context.fetch(fetchRequest)
                for leagueEntity in leagues {
                    if leagueEntity.leagueKey == league.leagueKey {
                        context.delete(leagueEntity)
                    }
                }
                try context.save()
            } catch {
                print("Failed to delete league: \(error)")
            }
    }
    
    // MARK: - Save Context
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
