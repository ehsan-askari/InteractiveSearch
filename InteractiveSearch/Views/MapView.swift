//
//  MapView.swift
//  InteractiveSearch
//
//  Created by Ehsan Askari on 8/16/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var fromMapItem: MKMapItem? = nil
    @State private var toMapItem: MKMapItem? = nil
    
    private var regionCenter: CLLocationCoordinate2D {
        if let f = fromMapItem, let _ = toMapItem {
            return f.placemark.coordinate
        }
        return CLLocationCoordinate2D(latitude: 52.3585328, longitude: 13.3956162)
    }
    
    private var coordinates: [CLLocationCoordinate2D] {
        if let f = fromMapItem, let t = toMapItem {
            return [f.placemark.coordinate, t.placemark.coordinate]
        }
        return []
    }
    
    var body: some View {
        
        PolylineMapView(region: MKCoordinateRegion(center: regionCenter, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), coordinates: coordinates)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .sheetWithDetents(
                isPresented: .constant(true),
                detents: [.medium(), .large()]
            ) {
                print("dismissed")
            } content: {
                DetailView(fromMapItem: $fromMapItem, toMapItem: $toMapItem)
            }
        
    }
}
