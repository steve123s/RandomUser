//
//  RandomUser+CoreLocation.swift
//  RandomUser
//
//  Created by Daniel Esteban Salinas on 28/03/21.
//

import UIKit
import MapKit

extension CLLocationCoordinate2D: CustomStringConvertible {
    public var description: String {
        return "lat: \(self.latitude.description), lon: \(self.longitude.description)"
    }
    
    func getSnapshot(completion: @escaping (UIImage) -> Void) {

        let mapSnapshotOptions = MKMapSnapshotter.Options()
        var meters = 1000000
        var region = MKCoordinateRegion(center: self,
                                        latitudinalMeters: CLLocationDegrees(meters),
                                        longitudinalMeters: CLLocationDegrees(meters))
        
        while !CLLocationCoordinate2DIsValid(region.center) {
            meters /= 10
            region = MKCoordinateRegion(center: self,
                                        latitudinalMeters: CLLocationDegrees(meters),
                                        longitudinalMeters: CLLocationDegrees(meters))
        }
        
        mapSnapshotOptions.region = region

        let snapshot = MKMapSnapshotter(options: mapSnapshotOptions)
        snapshot.start { snapshot, error in
            guard let snapshot = snapshot else {
                completion(UIImage(systemName: "mappin.slash") ?? UIImage())
                return
            }

            let image = UIGraphicsImageRenderer(size: mapSnapshotOptions.size).image { _ in
                snapshot.image.draw(at: .zero)

                let pinView = MKPinAnnotationView(annotation: nil, reuseIdentifier: nil)
                let pinImage = pinView.image

                var point = snapshot.point(for: self)

                point.x -= pinView.bounds.width / 2
                point.y -= pinView.bounds.height / 2
                point.x += pinView.centerOffset.x
                point.y += pinView.centerOffset.y
                pinImage?.draw(at: point)
            }
            
            completion(image)
            
        }
        
    }
    
}
