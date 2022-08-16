//
//  DetailView.swift
//  InteractiveSearch
//
//  Created by Ehsan Askari on 8/16/22.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    @Binding var fromMapItem: MKMapItem?
    @Binding var toMapItem: MKMapItem?
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 0) {
                
                Image("Airplane")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 75)
                    .padding(.top, 32)
                
                HStack(spacing: 32) {
                    
                    VStack(alignment: .center, spacing: 32) {
                        Text("From")
                        NavigationLink(destination: SearchView(mapItem: $fromMapItem)) {
                            Text(fromMapItem?.name ?? "-----")
                                .frame(height: 50)
                        }
                    }.frame(maxWidth: .infinity)
                    
                    VStack(alignment: .center, spacing: 32) {
                        Text("To")
                        NavigationLink(destination: SearchView(mapItem: $toMapItem)) {
                            Text(toMapItem?.name ?? "-----")
                                .frame(height: 50)
                        }
                    }.frame(maxWidth: .infinity)
                    
                }
                .padding([.leading, .trailing], 16)
                .frame(maxHeight: .infinity)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            
        }
        
    }
    
}
