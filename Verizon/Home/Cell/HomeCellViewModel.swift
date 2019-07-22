//
//  HomeCellViewModel.swift
//  Verizon
//
//  Created by Jeganathan, Vivin on 7/13/19.
//  Copyright © 2019 Jeganathan, Vivin. All rights reserved.
//

import UIKit

//TODO:-Session Task's instance can be held here and cancelled or resumed as and when the cell comes/disappears to/from view.

class HomeCellViewModel: NSObject {
    var videoModel: VideoModel?
    var thumbnailImage: UIImage?
    
    init(videoModel : VideoModel) {
        self.videoModel = videoModel
    }
    
    func getTitle() -> String {
        return videoModel?.title ?? ""
    }
    
    func getDuration() -> String {
        return String(videoModel?.duration ?? 0)
    }
    
    func getImage(completionHandler:@escaping ((UIImage?) -> Void)) {
        if let image = thumbnailImage {
            //Cached image is returned
            completionHandler(image)
            return
        }
        
        NetworkHelper().getThumbnailImage(url: getUrl()) { [weak self] result in
            
            switch result {
            case .success(let image):
                self?.thumbnailImage = image
                completionHandler(image)
            case .failure:
                completionHandler(nil)
            }
        }
    }
    
    func getUrl() -> String {
        
        //Hardcoded for now, depends on business logic
        return videoModel?.thumbnails?[1].url ?? ""
    }
}
