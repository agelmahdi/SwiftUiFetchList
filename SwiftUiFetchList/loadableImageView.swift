//
//  loadableImageView.swift
//  SwiftUiFetchList
//
//  Created by Ahmed El-Mahdi on 11/30/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import SwiftUI

struct loadableImageView: View {
    
    @ObservedObject var imageFetcher : ImageFetcher
    
     init(with urlString: String) {
          imageFetcher = ImageFetcher(url: urlString)
      }
    var body: some View {
            if let image = UIImage(data: imageFetcher.data) {
                return AnyView(
                    Image(uiImage: image).resizable()
                )
            } else {
                return AnyView(
                    ActivityIndicator(style: .medium)
                )
            }
        }
    }



