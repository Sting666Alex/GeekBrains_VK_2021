//
//  NewsClass.swift
//  VK_Belov
//
//  Created by Алексей Белов on 02.04.2021.
//


import Foundation

class NewsClass: CustomStringConvertible {

    var textLable: String
    var titleLable: String
    var who: String
    var date: Date
    var numberOfViewsText: Int
    var urlFoto: String
    var likeNumber: Int
    
    var description: String {
        return textLable
    }
    
    init(textLable:String, titleLable: String, who:String, date:Date, likeNumber: Int, numberOfViewsText:Int , urlFoto:String) {
        self.textLable = textLable
        self.titleLable = titleLable
        self.who = who
        self.date = date
        self.likeNumber = likeNumber
        self.urlFoto = urlFoto
        self.numberOfViewsText = numberOfViewsText
    }
    
}

extension NewsClass {
    static var arrNewsClass:[NewsClass]{
    
        return [
            NewsClass(textLable: "John",
                      titleLable: "",
                      who: "Alex",
                      date: stringToDate("2021-03-01T00:00:00+0000"),
                      likeNumber: 0,
                      numberOfViewsText: randomInt(),
                      urlFoto: ""),
            
            NewsClass(textLable: "John",
                      titleLable: "",
                      who: "Bob",
                      date: stringToDate("2021-04-01T00:00:00+0000"),
                      likeNumber: 0,
                      numberOfViewsText: randomInt(),
                      urlFoto: "")
            ]
    }

    static func stringToDate(_ dateString: String) -> Date{
        // Взято из одного форума
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"//"yyyy-MM-dd HH:mm:ss ZZZ"
        if let date = dateFormatter.date(from: dateString)
        {
            return date
        }
        print("Invalid arguments ! Returning Current Date . ")
        return Date()
    }
    
    static func randomInt() -> Int{
        return Int.random(in: 1...6)
    }
    
}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

// MARK: - Welcome
struct NewsElement: Codable {
    let response: NewsResponse
}

// MARK: - Response
struct NewsResponse: Codable {
    let items: [NewsResponseItem]
    let profiles: [NewsProfile]
    let groups: [NewsGroup]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct NewsGroup: Codable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

// MARK: - ResponseItem
struct NewsResponseItem: Codable {
    let sourceID, date: Int
    let canDoubtCategory, canSetCategory: Bool?
    let topicID: Int?
    let postType, text: String?
    let markedAsAds: Int?
    let attachments: [NewsAttachment]?
    let postSource: NewsPostSource?
    let comments: NewsComments?
    let likes: NewsPurpleLikes?
    let reposts: NewsReposts?
    let views: NewsViews?
    let isFavorite: Bool?
    let donut: NewsDonut?
    let shortTextRate: Double?
    let postID: Int
    let type: String
    let photos: NewsPhotos?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case topicID = "topic_id"
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts, views
        case isFavorite = "is_favorite"
        case donut
        case shortTextRate = "short_text_rate"
        case postID = "post_id"
        case type, photos
    }
}

// MARK: - Attachment
struct NewsAttachment: Codable {
    let type: String
    let photo: Photo?
    let video: NewsVideo?
}

// MARK: - Photo
struct NewsPhoto: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let accessKey: String
    let postID: Int
    let sizes: [NewsSize]
    let text: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case accessKey = "access_key"
        case postID = "post_id"
        case sizes, text
        case userID = "user_id"
    }
}

// MARK: - Size
struct NewsSize: Codable {
    let height: Int
    let url: String
    let type: String?
    let width: Int
    let withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case height, url, type, width
        case withPadding = "with_padding"
    }
}

// MARK: - Video
struct NewsVideo: Codable {
    let accessKey: String
    let canComment, canLike, canRepost, canSubscribe: Int
    let canAddToFaves, canAdd, comments, date: Int
    let videoDescription: String
    let duration: Int
    let image, firstFrame: [NewsSize]
    let width, height, id, ownerID: Int
    let title: String
    let isFavorite: Bool
    let trackCode, type: String
    let views: Int

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case videoDescription = "description"
        case duration, image
        case firstFrame = "first_frame"
        case width, height, id
        case ownerID = "owner_id"
        case title
        case isFavorite = "is_favorite"
        case trackCode = "track_code"
        case type, views
    }
}

// MARK: - Comments
struct NewsComments: Codable {
    let count, canPost: Int

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}

// MARK: - Donut
struct NewsDonut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - PurpleLikes
struct NewsPurpleLikes: Codable {
    let count, userLikes, canLike, canPublish: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - Photos
struct NewsPhotos: Codable {
    let count: Int
    let items: [NewsPhotosItem]
}

// MARK: - PhotosItem
struct NewsPhotosItem: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let accessKey: String
    let postID: Int?
    let sizes: [NewsSize]
    let text: String
    let userID: Int
    let likes: NewsFluffyLikes
    let reposts: NewsReposts
    let comments: NewsViews
    let canComment, canRepost: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case accessKey = "access_key"
        case postID = "post_id"
        case sizes, text
        case userID = "user_id"
        case likes, reposts, comments
        case canComment = "can_comment"
        case canRepost = "can_repost"
    }
}

// MARK: - Views
struct NewsViews: Codable {
    let count: Int
}

// MARK: - FluffyLikes
struct NewsFluffyLikes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct NewsReposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - PostSource
struct NewsPostSource: Codable {
    let type: String
}

// MARK: - Profile
struct NewsProfile: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let canAccessClosed, isClosed: Bool
    let sex: Int
    let screenName: String
    let photo50, photo100: String
    let onlineInfo: NewsOnlineInfo
    let online: Int

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online
    }
}

// MARK: - OnlineInfo
struct NewsOnlineInfo: Codable {
    let visible, isOnline, isMobile: Bool

    enum CodingKeys: String, CodingKey {
        case visible
        case isOnline = "is_online"
        case isMobile = "is_mobile"
    }
}
