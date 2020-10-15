//
//  AsyncWebImageView.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/15/20.
//

import Foundation
import SwiftUI

struct AsyncWebImageView: View {
    private var url: URL
    private var placeHolder: Image
    @ObservedObject var binder = AsyncImageBinder()

    init(url: URL, placeHolder: Image) {
        self.url = url
        self.placeHolder = placeHolder
        self.binder.load(url: self.url)
    }
    var body: some View {
            VStack {
                // 3
                if binder.image != nil {
                    Image(uiImage: binder.image!)
                        .renderingMode(.original)
                        .resizable()
                } else {
                    placeHolder
                }
            }
            .onAppear {  }
            .onDisappear { self.binder.cancel() }
        
        }

}
