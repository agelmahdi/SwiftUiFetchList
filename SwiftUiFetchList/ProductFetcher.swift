//
//  ProductFetcher.swift
//  SwiftUiFetchList
//
//  Created by Ahmed El-Mahdi on 11/29/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

enum LoadableState<T> {
    case loading
    case fetched(Result<T, FetchError>)
}

enum FetchError: Error {
    case error(String)
    
    var localizedDescription: String {
        switch self {
        case .error(let message):
            return message
        }
    }
}

class ProductFetcher: ObservableObject {
    
    
    private static let apiUrlString = "https://gist.githubusercontent.com/schmidyy/02fdec9b9e05a71312a550fc50f948e6/raw/7fc2facbbf9c3aa526f35a32d0c7fe74a4fc29a1/products.json"

   var didObserve = PassthroughSubject<ProductFetcher, Never>()
//    @Published var  = [Root]()

@Published  var state: LoadableState<Root> = .loading {
        didSet{
            didObserve.send(self)
        }
    }
    init() {
        guard let apiUrl = URL(string: ProductFetcher.apiUrlString) else {
            state = .fetched(.failure(.error("Malformed API URL.")))
            return
        }
        
        URLSession.shared.dataTask(with: apiUrl) { [weak self] (data, _, error) in
            if let error = error{
                self?.state = .fetched(.failure(.error(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                self?.state = .fetched(.failure(.error("Malformed response data")))
                return
            }
            let root = try! JSONDecoder().decode(Root.self, from: data)
            
            DispatchQueue.main.async {[weak self] in
                self?.state = .fetched(.success(root))
            }
            
        }.resume()
    }
    
    
}

class ImageFetcher: ObservableObject {
    var didObserved = PassthroughSubject<Data, Never>()
    
    
  @Published  var data : Data = Data(){
        didSet{
            didObserved.send(data)
        }
    }
    
    init(url: String) {
        guard  let imageUrl = URL(string: url) else{
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
        
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {[weak self] in
                self?.data = data
            }
        }.resume()
        
    }
    
    
    
}
