//
//  ComicListView.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/13/20.
//

import Foundation
import SwiftUI

struct ComicListView : View {
    @ObservedObject var viewModel: ComicListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.comics) { comic in
                NavigationLink(destination: ComicDetailView()) {
                    ComicListRow(comic: comic)
                }
            }
            .alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
            })
            .navigationBarTitle(Text("Comic List"))
        }
        .onAppear(perform: { self.viewModel.apply(.onAppear) })
    }
}

#if DEBUG
struct ComicListView_Previews : PreviewProvider {
    static var previews: some View {
        ComicListView(viewModel: .init())
    }
}
#endif
