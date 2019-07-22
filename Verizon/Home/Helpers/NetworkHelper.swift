//
//  NetworkHelper.swift
//  Verizon
//
//  Created by Jeganathan, Vivin on 7/13/19.
//  Copyright © 2019 Jeganathan, Vivin. All rights reserved.
//

import UIKit

enum VerizonError: Error {
    case badURL
    case networkError
    case responseError
    case downloadError
}

class NetworkHelper: NSObject, URLSessionDelegate {
    
    static var verizonVideosUrl = "https://video.media.yql.yahoo.com/v1/video/alias/channels/wf-channel=related-videos?dev_type=smartphone-app&video_uuid=eeaa1d1e-8840-39de-a488-ea444e7c832b&site=vsdk-demo-app&offnetwork=false&region=US&lang=en-US&image_sizes=640x360" //This has to come from plist/config file
    static let numberOfRecords = 5
    
    func getChannelData(page: Int, completionHandler: @escaping ((Result<ChannelModel, VerizonError>) -> Void)) {
        
        NetworkHelper.verizonVideosUrl = NetworkHelper.verizonVideosUrl + "&count=\(NetworkHelper.numberOfRecords)"
        NetworkHelper.verizonVideosUrl = NetworkHelper.verizonVideosUrl + "&start=\((NetworkHelper.numberOfRecords * page))"
        
        guard let url = URL(string: NetworkHelper.verizonVideosUrl) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        urlSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completionHandler(.failure(.networkError))
                return
            }
            
            if let data = data {
                do {
                    let channelModel = try JSONDecoder().decode(ChannelModel.self, from: data)
                    completionHandler(.success(channelModel))
                } catch {
                    completionHandler(.failure(.responseError))
                }
                
            } else {
                completionHandler(.failure(.responseError))
            }
            
            }.resume()
    }
    
    func getThumbnailImage(url: String, completionHandler: @escaping (Result<UIImage?, VerizonError>) -> Void) {

        guard let url = URL(string: url) else {
            return
        }

        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        let request = URLRequest(url: url)
        urlSession.dataTask(with: request) { (data, response, error) in

            if let error = error {
                if error._code == NSURLErrorCancelled {
                    return
                }
                completionHandler(.failure(.downloadError))
                return
            }

            if let data = data, let response = response {
                URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
                completionHandler(.success(UIImage(data: data)))
            } else {
                completionHandler(.failure(.responseError))
            }
        }.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, urlCredential)
    }
}
