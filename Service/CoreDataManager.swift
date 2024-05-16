//
//  CoreDataManager.swift
//  Sports
//
//  Created by Mina on 14/05/2024.
//

import Foundation
import CoreData
import UIKit
class CoreDataManager {
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    var leaguesArr: [NSManagedObject]!
    static let shared = CoreDataManager()
    
    private init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func getFavorites() -> [FavoriteLeague] {
        var leagues: [FavoriteLeague] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "League")
        do {
            leaguesArr = try managedContext.fetch(fetchRequest)
            for league in leaguesArr {
                guard let id = league.value(forKey: "id") as? Int,
                      let title = league.value(forKey: "title") as? String,
                      let type = league.value(forKey: "type") as? String,
                      let img = league.value(forKey: "image") as? Data
                else {
                    return []
                }
                
                let league = FavoriteLeague(id: id, title: title,type:type, img:img)
                leagues.append(league)
            }
        } catch {
            print(error.localizedDescription)
        }
        return leagues
    }
    func removeLeague(leagueId: Int) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "League")
        fetchRequest.predicate = NSPredicate(format: "id == %d", leagueId)
        do{
            let items = try managedContext.fetch(fetchRequest)
            for item in items {
                managedContext.delete(item)
                }
        }catch{
            print("Error accurred while cheking isFav for league id = \(leagueId)")
            
        }
        try! managedContext.save()
    }
    
    func addLeague(league: FavoriteLeague) {
        let entity = NSEntityDescription.entity(forEntityName: "League", in: managedContext)
        let leagueManagedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        leagueManagedObject.setValue(league.id, forKey: "id")
        leagueManagedObject.setValue(league.title, forKey: "title")
        leagueManagedObject.setValue(league.type, forKey: "type")
        leagueManagedObject.setValue(league.img, forKey: "image")
        
        do {
            try managedContext.save()
            print("saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    func checkIfLeagueIsFav(leagueId:Int)->Bool{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "League")
        fetchRequest.predicate = NSPredicate(format: "id == %d", leagueId)
        do{
            let count = try managedContext.count(for: fetchRequest)
            return count > 0
        }catch{
            print("Error accurred while cheking isFav for league id = \(leagueId)")
            return false
        }
    }
}
