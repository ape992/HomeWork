//
//  BeerService.swift
//  HomeWork
//
//  Created by 근식 on 2021/02/06.
//

import Foundation
import Alamofire

class BeerService {
    
    private var isDownloading = false
    
    private let url = "https://api.punkapi.com/v2/beers"
    
    static let shared = BeerService()
    
    private init() {}
    
    func fetchBeers(page: Int, countPerPage: Int = 20, completion: @escaping ([Beer]?) -> Void) {
        
        if isDownloading { return }
        
        isDownloading = true
        
        var parameters = [String: Int]()
        parameters["page"] = page
        parameters["per_page"] = countPerPage
        
        AF.request(url, parameters: parameters).responseDecodable(of: BeerList.self) { [weak self] response in
            self?.isDownloading = false
            switch response.result {
            case .failure(let error):
                print("DEBUG - Fetch Error: \(error.errorDescription ?? "")")
                completion(nil)
            case .success(let result):
                completion(result)
            }
        }
    }
    
}
