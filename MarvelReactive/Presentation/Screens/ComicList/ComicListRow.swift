//
//  ComicListRow.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/13/20.
//

import Foundation
import SwiftUI

struct ComicListRow: View {
    
    @State var comic: Comic

    var body: some View {
        VStack {
            AsyncWebImageView(url: comic.thumbnail?.url ?? URL(string: "https://images.dog.ceo/breeds/beagle/n02088364_17553.jpg")!, placeHolder: Image(uiImage: UIImage()).resizable())
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 150, alignment: .topLeading)
            /*
            AsyncImage(
                url: comic.thumbnail?.url ?? URL(string: "https://images.dog.ceo/breeds/beagle/n02088364_17553.jpg")!,
                placeholder: { Text("Loading ...") },
                image: { Image(uiImage: $0).resizable() }
            )
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 150, alignment: .topLeading)
             */
            HStack {
                VStack(alignment: .leading) {
                    Text(comic.title)
                        .font(.headline)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(0)
                    Text(comic.description ?? "")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
                .layoutPriority(100)
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.2), lineWidth: 1)
        )
    }
}

#if DEBUG
//struct RepositoryListRow_Previews : PreviewProvider {
//    static var previews: some View {
//        RepositoryListRow(repository:
//            Repository(
//                id: 1,
//                fullName: "foo",
//                owner: User(id: 1, login: "bar", avatarUrl: URL(string: "baz")!)
//            )
//        )
//    }
//}
#endif
