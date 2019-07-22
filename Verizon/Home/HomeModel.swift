//
//  HomeModel.swift
//  Verizon
//
//  Created by Jeganathan, Vivin on 7/13/19.
//  Copyright © 2019 Jeganathan, Vivin. All rights reserved.
//

import UIKit

//TODO:- Add other properties

class ChannelModel: Codable {
    var channel: ChannelResultModel?
    var error: String?
}

class ChannelResultModel: Codable {
    let homeModel: [HomeModel]
    
    private enum CodingKeys: String, CodingKey {
        case homeModel = "result"
    }
}

class HomeModel: Codable {
    var name: String?
    var videos: [VideoModel]?
}

class VideoModel: Codable {
    var title: String?
    var duration: Int?
    var thumbnails: [ThumbnailModel]?
}

class ThumbnailModel: Codable {
    var url: String?
    var width: Int
    var height: Int
}
