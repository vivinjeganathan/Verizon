//
//  HomeCellViewModelTests.swift
//  VerizonTests
//
//  Created by Jeganathan, Vivin on 7/13/19.
//  Copyright © 2019 Jeganathan, Vivin. All rights reserved.
//

import XCTest
@testable import Verizon

class HomeCellViewModelTests: XCTestCase {
    
    var homeCellViewModel: HomeCellViewModel?
    
    override func setUp() {
        
        homeCellViewModel = HomeCellViewModel(videoModel: VideoModel())
    }
    
    //TODO:- Tests to be added
    override func tearDown() {
        homeCellViewModel = nil
    }
}
