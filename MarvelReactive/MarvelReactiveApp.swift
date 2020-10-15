//
//  MarvelReactiveApp.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/13/20.
//

import SwiftUI

@main
struct MarvelReactiveApp: App {
    var body: some Scene {
        WindowGroup {
            ComicListView(viewModel: ComicListViewModel())
//            ContentView()
        }
    }
}
