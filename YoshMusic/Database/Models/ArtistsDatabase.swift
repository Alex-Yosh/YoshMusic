//
//  ArtistsDatabase.swift
//  YoshMusic
//
//  Created by Alex Yoshida on 2024-04-30.
//

import Foundation
import CoreData

extension DatabaseManager{
    
    func addArtist(artist: ArtistItem) {
        let newArtist = ArtistEntity(context: artistContainer.viewContext)
        newArtist.name = artist.name
        newArtist.total_followers = Int32(artist.followers.total)
        newArtist.image_url = artist.images[0].url
        newArtist.image_width = Int32(artist.images[0].width)
        newArtist.image_height = Int32(artist.images[0].height)
        saveArtistsData()
    }
    
    func deleteArtist(name: String){
        if let entity = artists[name]{
            artistContainer.viewContext.delete(entity)
            saveArtistsData()
        }
    }
    
    func deleteArtistData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ArtistEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try artistContainer.viewContext.execute(deleteRequest)
        } catch let error{
            print("Error deleting. \(error)")
        }
    }
    
    
    //private helpers
    
    func fetchArtists(){
        let request = NSFetchRequest<ArtistEntity>(entityName: "ArtistEntity")
        
        do {
            let artists:[ArtistEntity] = try artistContainer.viewContext.fetch(request)
            self.artists = [:]
            for artist in artists {
                if let name = artist.name{
                    self.artists[name] = artist
                }
            }
        } catch let error{
            print("Error fetching. \(error)")
        }
    }
    
    private func saveArtistsData(){
        do {
            try artistContainer.viewContext.save()
            fetchArtists()
        } catch let error{
            print("Error saving. \(error)")
        }
    }
}
