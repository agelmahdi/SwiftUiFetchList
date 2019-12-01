//
//  ProductDetailsView.swift
//  SwiftUiFetchList
//
//  Created by Ahmed El-Mahdi on 11/30/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import SwiftUI

struct ProductDetailsView: View {
   var product: Product
        
        var body: some View {
            NavigationView {
                VStack(alignment: .leading) {
                    ProductRow(product: product)
                    Text("Variants").font(.title).padding()
                    List(product.variants) { variant in
                        VStack(alignment: .leading) {
                            Text(variant.title)
                            Text(variant.price)
                        }
                    }
                }
                .navigationBarTitle(Text("Details"))
            }
        }
    }
