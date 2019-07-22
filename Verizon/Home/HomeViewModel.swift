//
//  HomeViewModel.swift
//  Verizon
//
//  Created by Jeganathan, Vivin on 7/13/19.
//  Copyright © 2019 Jeganathan, Vivin. All rights reserved.
//

import UIKit

//TODO: Pagination can be moved to a separate worker

class HomeViewModel: NSObject {
    
    var homeModel : HomeModel?
    var homeCellViewModels = [HomeCellViewModel]()
    
    //TODO:Pagination
    private var currentPage = 0
    private var total = 0
    private var currentCount = 0
    private var isFetchInProgress = false
    
    //Error handling needs to be improvised
    func getChannelData(completionHandler: @escaping ((Bool, String, [IndexPath]) -> Void)) {
        
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true

        NetworkHelper().getChannelData(page: currentPage) { [weak self] (result) in
            
            self?.isFetchInProgress = false
            
            switch result {
                
            case .success(let channelModel):
                
                var indexPaths = [IndexPath]()
                
                self?.currentPage += 1
                
                self?.homeModel = channelModel.channel?.homeModel.first ?? HomeModel()
                if let newHomeCellViewModels = self?.createHomeCellViewModels(videos: self?.homeModel?.videos) {
                    self?.homeCellViewModels.append(contentsOf: newHomeCellViewModels)
                    
                    let startIndex = (self?.homeCellViewModels.count ?? 0) - newHomeCellViewModels.count
                    let endIndex = self?.homeCellViewModels.count ?? 0
                    indexPaths = (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
//                    indexPaths = [IndexPath(row: 0, section: 0)]
                }
                
                completionHandler(true, "", indexPaths)
            case .failure:
                //Message has to come from Localization strings
                completionHandler(false, "Sorry cannot complete the request at this time. Please try again.", [])
            }
        }
    }
    
    func getCountOfHomeCellViewModels() -> Int {
        //+1 is for loading cell
        return homeCellViewModels.count + 1
    }

    func getHomeCellViewModels(indexPath: IndexPath) -> HomeCellViewModel {
        return homeCellViewModels[indexPath.row]
    }
    
    func isLoadingCell(indexPath: IndexPath) -> Bool {
        return indexPath.row >= homeCellViewModels.count
    }

    func createHomeCellViewModels(videos: [VideoModel]?) -> [HomeCellViewModel]? {
        return videos?.map { HomeCellViewModel(videoModel: $0) }
    }
}
