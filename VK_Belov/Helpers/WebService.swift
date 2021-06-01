//
//  WebService.swift
//  VK_Belov
//
//  Created by Алексей Белов on 24.04.2021.
//

import Foundation
import Alamofire

final class UserSession {
    
    static let shared = UserSession()
    
    private init() {}
    
    var token = ""
    var userID = ""
    var client_id = "7823487"
    var expires_in = ""
    let v = "5.130"
    
    let countPhoto = "50"
    let countFrends = "50"
    
    let countNews = "11"
    
}



class WebService{
    
    func frendsRequest(completion: @escaping ([ItemFrends]) -> Void ){
            
        let baseUrl = "https://api.vk.com/method/"
        let path = "friends.get"
        let parameters: Parameters = [
            "user_id": String(UserSession.shared.userID),
            "access_token": UserSession.shared.token,
            "fields": "name,photo_50",
            "count": String(UserSession.shared.countFrends),
            "v": UserSession.shared.v
        ]
        // составляем url из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl+path
        //let url = "https://api.vk.com/method/friends.get?user_id="+id+"&fields=name&count=3&v=5.130&access_token=" + token
        // делаем запрос
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let frends = try! JSONDecoder().decode(FrendsElement.self, from: data)
                completion(frends.response.items)
                insertOrUpdate(itemFrends: frends.response.items)
            } catch {
                print(error)
            }
        }
        
    }
    
    func groupsRequest(completion: @escaping ([Int]) -> Void) {

        let baseUrl = "https://api.vk.com/method/"
        let path = "groups.get"
        let parameters: Parameters = [
            "user_id": String(UserSession.shared.userID),
            "access_token": UserSession.shared.token,
            //"fields": "",
            "count": "3",
            "v": UserSession.shared.v
           
        ]
        // составляем url из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl+path

        // делаем запрос
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let groups = try! JSONDecoder().decode(GroupElement.self, from: data)
                completion(groups.response.items)
                //print(groups.response.items)
            } catch {
                print(error)
            }
        }
    
    }
    
    func groupsFilterRequest(completion: @escaping ([Int]) -> Void ){
        
        let baseUrl = "https://api.vk.com/method/"
        let path = "groups.get"
        let parameters: Parameters = [
            "user_id": String(UserSession.shared.userID),
            "access_token": UserSession.shared.token,
            "filter":"publics,events",
            "count": "3",
            "v": UserSession.shared.v
        ]
        // составляем url из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl+path
        // let url = "https://api.vk.com/method/groups.get?user_id=-" + id + "filter=publics,events&count=3&v=5.130&access_token=" + token

        // делаем запрос
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let groups = try! JSONDecoder().decode(GroupElement.self, from: data)
                completion(groups.response.items)
                
            } catch {
                print(error)
            }
        }
    }
 
    func photosGetAllRequest(idFrend: String, completion: @escaping ([ItemPhotoFrends]) -> Void ){
        let baseUrl = "https://api.vk.com/method/"
        let path = "photos.getAll"
        let parameters: Parameters = [
            "user_id": String(UserSession.shared.userID),
            "access_token": UserSession.shared.token,
            "owner_id":idFrend,
            //"album_id":"profile",
            //"rev":"0",
            "count": String(UserSession.shared.countPhoto),
            "v": UserSession.shared.v
        ]
        // составляем url из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl+path
//        let urlTest = "https://api.vk.com/method/photos.getAll?user_id=-" + String(UserSession.shared.userID) +
//                        "&owner_id="+idFrend+"&count=3&v=5.130&access_token=" + String(UserSession.shared.token)

        // делаем запрос
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let photo = try! JSONDecoder().decode(PhotoFrends.self, from: data)
                completion(photo.response.items)
                insertOrUpdatePhoto(itemPhotoFrends: photo.response.items)
            } catch {
                print(error)
            }
        }
    }
    
    func newsRequest( completion: @escaping ([NewsResponseItem]) -> Void){
            
        let baseUrl = "https://api.vk.com/method/"
        let path = "newsfeed.get"
        let parameters: Parameters = [
            "user_id": String(UserSession.shared.userID),
            "access_token": UserSession.shared.token,
            //"fields": "name,photo_50",
            "count": String(UserSession.shared.countNews),
            "v": UserSession.shared.v
        ]
        // составляем url из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl+path
//        let url = "https://api.vk.com/method/newsfeed.get?user_id="+id+"&v=5.130&access_token=" + token
                
        let urlTest = "https://api.vk.com/method/newsfeed.get?user_id=-" + String(UserSession.shared.userID) +
                                "&v=5.130&access_token=" + String(UserSession.shared.token)
        //
        // делаем запрос
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let news = try! JSONDecoder().decode(NewsElement.self, from: data)
                completion(news.response.items)
                //insertOrUpdate(itemFrends: frends.response.items)
            } catch {
                print(error)
            }
        }
        
    }
    

    
    // MARK: - not Use
    func photosAlbumRequest(idFrend: String, completion: @escaping ([ItemPhotoAlbums]) -> Void ){
        let baseUrl = "https://api.vk.com/method/"
        let path = "photos.getAlbums"
        let parameters: Parameters = [
            "user_id": String(UserSession.shared.userID),
            "access_token": UserSession.shared.token,
            "owner_id":idFrend,
            //"album_id":"profile",
            //"rev":"0",
            "count": "3",
            "v": UserSession.shared.v
        ]
        // составляем url из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl+path
//        let urlTest = "https://api.vk.com/method/photos.getAlbums?user_id=-" + String(UserSession.shared.userID) +
//                        "&owner_id="+"-"+idFrend+"&count=3&v=5.130&access_token=" + String(UserSession.shared.token)

        // делаем запрос
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let photo = try! JSONDecoder().decode(PhotoAlbums.self, from: data)
                completion(photo.response.items)
            } catch {
                print(error)
            }
        }
    }
    
    func photosRequest(idFrend:String, completion: @escaping ([ItemPhoto]) -> Void ){
        let baseUrl = "https://api.vk.com/method/"
        let path = "photos.get"
        let parameters: Parameters = [
            "user_id": String(UserSession.shared.userID),
            "access_token": UserSession.shared.token,
            "owner_id":idFrend,
            "album_id":"profile",
            "rev":"0",
            "count": "3",
            "v": UserSession.shared.v
        ]
        // составляем url из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl+path
//        let urlTest = "https://api.vk.com/method/photos.getAlbums?user_id=-" + String(UserSession.shared.userID) +
//                        "&owner_id="+idFrend+"&count=3&v=5.130&access_token=" + String(UserSession.shared.token)


        // делаем запрос
        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            do {
                let photo = try! JSONDecoder().decode(Photo.self, from: data)
                completion(photo.response.items)
            } catch {
                print(error)
            }
        }
    }
    
    
}
