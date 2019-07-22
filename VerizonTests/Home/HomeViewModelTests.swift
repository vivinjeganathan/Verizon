//
//  HomeViewModelTests.swift
//  VerizonTests
//
//  Created by Jeganathan, Vivin on 7/13/19.
//  Copyright © 2019 Jeganathan, Vivin. All rights reserved.
//

import XCTest
@testable import Verizon

class HomeViewModelTests: XCTestCase {
    
    var homeViewModel: HomeViewModel?
    
    override func setUp() {
        
        homeViewModel = HomeViewModel()
        
        let homeCellViewModel1 = HomeCellViewModel(videoModel: VideoModel())
        homeCellViewModel1.videoModel?.title = "Video 1"
        
        let homeCellViewModel2 = HomeCellViewModel(videoModel: VideoModel())
        homeCellViewModel2.videoModel?.title = "Video 1"
        
        homeViewModel?.homeCellViewModels = [homeCellViewModel1, homeCellViewModel2]
    }
    
    func testGetCountOfNumberModels() {
        XCTAssertEqual(2, homeViewModel?.getCountOfHomeCellViewModels())
    }
    
    //TODO:- Tests to be added
    
    override func tearDown() {
        homeViewModel = nil
    }
}

