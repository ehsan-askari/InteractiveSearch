//
//  PolylineMapView.swift
//  InteractiveSearch
//
//  Created by Ehsan Askari on 8/16/22.
//

import SwiftUI
import MapKit

struct PolylineMapView: UIViewRepresentable {
    
    let region: MKCoordinateRegion
    let coordinates: [CLLocationCoordinate2D]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.region = region
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        guard coordinates.count > 0 else {
            return
        }
        
        let pointAnnotation1 = MKPointAnnotation()
        pointAnnotation1.coordinate = coordinates[0]
        pointAnnotation1.title = "From"
        mapView.addAnnotation(pointAnnotation1)
        
        let pointAnnotation2 = MKPointAnnotation()
        pointAnnotation2.coordinate = coordinates[1]
        pointAnnotation2.title = "To"
        mapView.addAnnotation(pointAnnotation2)
        
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polyline)
        
        mapView.setVisibleMapRect(polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 50.0, left: 50.0, bottom: 50.0, right: 50.0), animated: true)
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

class Coordinator: NSObject, MKMapViewDelegate {
    
    var parent: PolylineMapView
    
    init(_ parent: PolylineMapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let polylineRenderer = MKPolylineRenderer(polyline: polyline)
            polylineRenderer.strokeColor = UIColor.systemRed
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    
}
