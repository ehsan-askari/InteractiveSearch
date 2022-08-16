//
//  SearchView.swift
//  InteractiveSearch
//
//  Created by Ehsan Askari on 8/16/22.
//

import SwiftUI
import MapKit

struct SearchView: View {
    
    @Binding var mapItem: MKMapItem?
    @StateObject private var searchViewModel = SearchViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(searchViewModel.mapItems, id: \.placemark) { item in
                    Button {
                        mapItem = item
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.name ?? "")
                            Text(item.placemark.title ?? "")
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            .searchable(text: $searchViewModel.text)
            .navigationTitle("")
        }
        
    }
}
