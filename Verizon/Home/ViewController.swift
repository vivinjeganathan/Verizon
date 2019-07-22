//
//  HomeViewController.swift
//  Verizon
//
//  Created by Jeganathan, Vivin on 7/13/19.
//  Copyright © 2019 Jeganathan, Vivin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var homeViewModel = HomeViewModel()
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        
        homeViewModel.getChannelData { [weak self] (success, message, reloadIndexPaths) in
            if success {
                DispatchQueue.main.async {
                    self?.homeTableView.reloadData()
////                    self?.homeTableView.reloadRows(at: reloadIndexPaths, with: .automatic)
//                    self?.homeTableView.beginUpdates()
//                    self?.homeTableView.insertRows(at: reloadIndexPaths, with: .bottom)
//                    self?.homeTableView.endUpdates()
                }
            } else {
                //Display error alert
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.getCountOfHomeCellViewModels()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if homeViewModel.isLoadingCell(indexPath: indexPath) {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell") else {
                fatalError("Cell dequeue error")
            }
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HomeTableViewCell else {
            fatalError("Cell dequeue error")
        }
        
        let homeCellViewModel = homeViewModel.getHomeCellViewModels(indexPath: indexPath)
        cell.configureCell(homeCellViewModel: homeCellViewModel)
        cell.titleLabel.text = String(indexPath.row)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HomeViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        //Prefetching should be implemented here
        if indexPaths.contains(where: homeViewModel.isLoadingCell) {
            loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
    }
}
