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
                      let img = league.value(forKey: "image") as? Data
                else {
                    return []
                }
                
                let league = FavoriteLeague(id: id, title: title, img: img)
                leagues.append(league)
            }
        } catch {
            print(error.localizedDescription)
        }
        return leagues
    }
    func removeLeague(index: Int) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "League")
        do {
            leaguesArr = try managedContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        managedContext.delete(leaguesArr[index])
        try! managedContext.save()
    }
    func addLeague(league: FavoriteLeague) {
        let entity = NSEntityDescription.entity(forEntityName: "League", in: managedContext)
        let leagueManagedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        leagueManagedObject.setValue(league.id, forKey: "id")
        leagueManagedObject.setValue(league.title, forKey: "title")
        leagueManagedObject.setValue(league.img, forKey: "image")
        
        do {
            try managedContext.save()
            print("saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}
