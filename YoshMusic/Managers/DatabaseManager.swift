//
//  DatabaseManager.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-30.
//

import Foundation
import CoreData


class DatabaseManager: ObservableObject{
    static let shared = DatabaseManager() //singleton
    
    //Databases
    @Published var artists: [String:ArtistEntity] = [:]
    
    //containers
    let artistContainer: NSPersistentContainer
    
    init() {
        //initalize containers
        artistContainer = NSPersistentContainer(name: "ArtistsContainer")
        
        loadContainers()
    }
    
    
    func loadContainers(){
        artistContainer.loadPersistentStores(completionHandler: {_,_ in self.fetchArtists()})
    }
}
