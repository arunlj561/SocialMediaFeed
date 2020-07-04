//
//  FeedDatasource.swift
//  SocailMediaFeed
//
//  Created by Arun Jangid on 02/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
import CoreData

protocol RefreshViews:class {
    func deleteRows(forindexPath indexPath:IndexPath)
    func updateRows(forindexPath indexPath:IndexPath)
    func insertRows(forindexPath indexPath:IndexPath)
}


class FeedDatasource:NSObject, UITableViewDataSource{
    
    weak var delegate:RefreshViews?
    
    func updateRowAvatar(_ image:UIImage?, forRow row:IndexPath){
        let feed = self._fetchedResultsController?.object(at: row)
        if feed?.avtarImage == nil{
            feed?.updateAvtarImage(image)
        }
    }
    
    func updateRowMedia(_ image:UIImage?, forRow row:IndexPath){
        let feed = self._fetchedResultsController?.object(at: row)
        if feed?.mediaImage == nil{
            feed?.updatemediaImage(image)
        }
    }
        
    func getAvtarImageUrl(_ indexPath:IndexPath) -> URL?{
        let feed = self.fetchedResultsController.object(at: indexPath)
        if let url = URL(string: FeedViewModel.init(feed).userAvatar ?? ""){
            return url
        }
        return nil
    }
    func getMediaImageUrl(_ indexPath:IndexPath) -> URL?{
        let feed = self.fetchedResultsController.object(at: indexPath)
        if let url = URL(string: FeedViewModel.init(feed).mediaUrl ?? ""){
            return url
        }
        return nil
        
    }
    
    var _fetchedResultsController: NSFetchedResultsController<Feeds>? = nil
    var managedObjectContext :NSManagedObjectContext = CoreDataManager.persistentContainer.viewContext
    
    var fetchedResultsController: NSFetchedResultsController<Feeds>
    {
    
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest:NSFetchRequest<Feeds> = Feeds.fetchRequest()
                        
        let sortDescriptor = NSSortDescriptor(key: "addedAt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
                
        let predicate = NSPredicate(format: "id != nil")
        
        
        fetchRequest.predicate = predicate
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
        aFetchedResultsController.delegate = self
        
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier, for: indexPath) as? FeedTableViewCell else{
            return UITableViewCell()
        }
        let feeds = self.fetchedResultsController.object(at: indexPath)        
        cell.configureViewModel(FeedViewModel(feeds))
        return cell
    }
    
    
}

extension FeedDatasource:NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .delete:
                if let deleteIndex = indexPath{
                    delegate?.deleteRows(forindexPath: deleteIndex)
                }
            case .update:
                if let updateIndex = indexPath{
                    delegate?.updateRows(forindexPath: updateIndex)
                }
            case .insert:
                if let insertIndex = newIndexPath{
                    delegate?.insertRows(forindexPath: insertIndex)
                }
            default:
                break
        }
    }
    
    
}
