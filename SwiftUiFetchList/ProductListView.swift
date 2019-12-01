//
//  ProductListView.swift
//  SwiftUiFetchList
//
//  Created by Ahmed El-Mahdi on 11/29/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var productFetcher = ProductFetcher()

  private var stateContent: AnyView {
            switch productFetcher.state {
            case .loading:
                return AnyView(
                    ActivityIndicator(style: .medium)
                )
            case .fetched(let result):
                switch result {
                case .failure(let error):
                    return AnyView(
                        Text(error.localizedDescription)
                    )
                case .success(let root):
                    return AnyView(
                        List(root.products) { product in
                            NavigationLink(destination: ProductDetailsView(product: product)) {
                                ProductRow(product: product)
                            }
                        }
                    )
                }
            }
        }
        
        var body: some View {
            NavigationView {
                stateContent
                .navigationBarTitle(Text("Products"))
            }
        }
    
    }

#if DEBUG
struct stateContent_Previews : PreviewProvider {
    static var previews: some View {
       ProductListView()
    }
}
#endif
