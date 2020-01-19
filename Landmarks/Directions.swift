//
//  Directions.swift
//  Landmarks
//
//  Created by Jason Songvilay on 1/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import MapKit

struct Directions: View {
    @State var directions: [CLLocation] = []
    
    var body: some View {
        VStack {
            MapView2(directions: $directions)
            
            Button(action: {
                
                self.directions = [CLLocation(latitude: 32.7737, longitude: -117.0714), CLLocation(latitude: 32.7779, longitude: -117.0722)]
            }) {
                Text("Get Directions").foregroundColor(.red).font(.system(size: 30))
            }
        }
    }
}

struct MapView2: UIViewRepresentable {
    @Binding var directions: [CLLocation]
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView2
        
        init(_ parent: MapView2) {
            self.parent = parent
        }
        
        func mapView(_ view: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 4
            return renderer
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        return MKMapView()
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
        var coordinates = self.directions.map({(location: CLLocation!) -> CLLocationCoordinate2D in return location.coordinate})
        let polyline = MKPolyline(coordinates: &coordinates, count: self.directions.count)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(
            latitude: 32.7737, longitude: -117.0722), latitudinalMeters: 1000, longitudinalMeters: 1000)
    view.setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 500, maxCenterCoordinateDistance: 2000), animated: true)
        view.cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: region)
        
        view.delegate = context.coordinator
        view.addOverlay(polyline)
    }
}


