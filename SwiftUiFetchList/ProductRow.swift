//
//  ProductRow.swift
//  SwiftUiFetchList
//
//  Created by Ahmed El-Mahdi on 11/30/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import SwiftUI

struct ProductRow: View {
   var product: Product
        
        var body: some View {
            HStack {
                loadableImageView(with: product.image.src).frame(width: 60, height: 60)
                VStack(alignment: .leading) {
                    Text(product.title)
                    Text(product.body_html).font(.caption)
                }
            }
        }
    }
