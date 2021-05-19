//
//  RealmService.swift
//  VK_Belov
//
//  Created by Алексей Белов on 24.04.2021.
//

import Foundation
import RealmSwift

//сохранение друзей в Realm
func saveFrendsRealmData(itemFrendsRealm: [ItemFrendsRealm]) {
    
    let realm = try! Realm()
    try? realm.write(){
        realm.add(itemFrendsRealm)
    }
    
    _ = loadFrendsRealData()
}

func loadFrendsRealData() -> [ItemFrends]{
    
    var itemFrends: [ItemFrends] = []
    
    do{
        let realm = try! Realm()
        let frends: Results<ItemFrendsRealm> = {realm.objects(ItemFrendsRealm.self) }()
            
        for item in frends {
            let frend: ItemFrends = .init(firstName: item.name,
                                                  id: item.id,
                                                  lastName: item.surname,
                                                  canAccessClosed: item.canAccessClosed,
                                                  isClosed: item.isClosed,
                                                  photo50: item.urlFoto!,
                                                  trackCode: item.trackCode)

            // проверка на дубли в базе данных, такое произошло в момент тестирования
            let filterMyNews = itemFrends.filter{
                $0.name.lowercased().contains(frend.name.lowercased())
            }
            
            if filterMyNews.isEmpty {
                itemFrends.append(frend)
            }
        }


        //print(frends)
    }catch{
        print(error)
    }
    
    return itemFrends
}

func insertOrUpdate(itemFrends: [ItemFrends]) {
    let realm = try! Realm()
    try! realm.write({
        for item in itemFrends {
            let itemFrendsRealm = ItemFrendsRealm()
            itemFrendsRealm.name     = item.name

            itemFrendsRealm.id              = item.id
            itemFrendsRealm.surname         = item.surname
            itemFrendsRealm.canAccessClosed = item.canAccessClosed
            itemFrendsRealm.isClosed        = item.isClosed
            //itemFrendsRealm.lists           = item.lists
            //itemFrendsRealm.trackCode       = item.trackCode
            itemFrendsRealm.urlFoto         = item.urlFoto

            realm.add(itemFrendsRealm)
        }
    })

    _ = loadFrendsRealData()
}

func insertOrUpdatePhoto(itemPhotoFrends: [ItemPhotoFrends]) {
    let realm = try! Realm()
    
    try! realm.write({
        for item in itemPhotoFrends {
            
            let itemPhotoFrendsRealm = ItemPhotoFrendsRealm()
            
            
            itemPhotoFrendsRealm.albumID            = item.albumID

            itemPhotoFrendsRealm.id                 = item.id
            itemPhotoFrendsRealm.date               = item.date
            itemPhotoFrendsRealm.ownerID            = item.ownerID
            itemPhotoFrendsRealm.hasTags            = item.hasTags
            
            for itemSizes in item.sizes{
                
                let sizePhotoFrendsRealm = SizePhotoFrendsRealm()
//
                sizePhotoFrendsRealm.height = itemSizes.height
                sizePhotoFrendsRealm.url = itemSizes.url
                sizePhotoFrendsRealm.type = itemSizes.type
                sizePhotoFrendsRealm.width = itemSizes.width
                
                itemPhotoFrendsRealm.sizes.append(sizePhotoFrendsRealm)
                
                
            }
            itemPhotoFrendsRealm.text               = item.text
//            itemPhotoFrendsRealm.lat                = item.lat!
//            itemPhotoFrendsRealm.long               = item.long!
            
            realm.add(itemPhotoFrendsRealm)
        }
    })

//    _ = loadFrendsRealData()
}

func loadItemPhotoFrendsRealData(idFrend: String) -> [ItemPhotoFrends]{
    
    var itemPhotoFrends: [ItemPhotoFrends] = []
    var sizes: [SizePhotoFrends] = []
    
    do{
        let realm = try! Realm()
        let ownerID = NSPredicate(format: " ownerID = "+idFrend)
        let photos: Results<ItemPhotoFrendsRealm> = {realm.objects(ItemPhotoFrendsRealm.self).filter(ownerID) }()
        
        
        for item in photos {

            sizes.removeAll()
            
            for itemSize in item.sizes{
                sizes.append( .init(height: itemSize.height, url: itemSize.url, type: itemSize.type, width: itemSize.width) )
            }
            
            let photo: ItemPhotoFrends = .init( albumID: item.albumID,
                                               date: item.date,
                                               id: item.id,
                                               ownerID: item.ownerID,
                                               hasTags: item.hasTags,
                                               sizes: sizes,
                                               text: item.text,
                                               lat: item.lat,
                                               long: item.long)
            

            // проверка на дубли в базе данных, такое произошло в момент тестирования
            let filterPhoto = itemPhotoFrends.filter{
                $0.id == photo.id
            }
            
            if filterPhoto.isEmpty {
                itemPhotoFrends.append(photo)
            }
            
        }
        
        print(" файл с данными фото ")
        print(realm.configuration.fileURL as Any)

        //print(frends)
    }catch{
        print(error)
    }
    
    return itemPhotoFrends
}

func loadNewsRealData() -> [ItemFrends]{
    
    var itemFrends: [ItemFrends] = []
    
    do{
        let realm = try! Realm()
        let frends: Results<ItemFrendsRealm> = {realm.objects(ItemFrendsRealm.self) }()
            
        for item in frends {
            let frend: ItemFrends = .init(firstName: item.name,
                                                  id: item.id,
                                                  lastName: item.surname,
                                                  canAccessClosed: item.canAccessClosed,
                                                  isClosed: item.isClosed,
                                                  photo50: item.urlFoto!,
                                                  trackCode: item.trackCode)

            // проверка на дубли в базе данных, такое произошло в момент тестирования
            let filterMyNews = itemFrends.filter{
                $0.name.lowercased().contains(frend.name.lowercased())
            }
            
            if filterMyNews.isEmpty {
                itemFrends.append(frend)
            }
        }


        //print(frends)
    }catch{
        print(error)
    }
    
    return itemFrends
}
