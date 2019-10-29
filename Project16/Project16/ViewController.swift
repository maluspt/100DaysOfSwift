//
//  ViewController.swift
//  Project16
//
//  Created by Maria Luiza Carvalho Sperotto on 29/10/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

   @IBOutlet weak var mapView: MKMapView!
   
    //challenge 2
    
    let mapTypes = ["hybrid": MKMapType.hybrid, "hybridFlyover": MKMapType.hybridFlyover, "mutedStandard": MKMapType.mutedStandard, "satellite": MKMapType.satellite, "satelliteFlyover": MKMapType.satelliteFlyover, "standard": MKMapType.standard]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics", wikiURL: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago", wikiURL: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the city of lights", wikiURL: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it", wikiURL: "https://en.wikipedia.org/wiki/Rome")
        let brasilia = Capital(title: "Brasília", coordinate: CLLocationCoordinate2D(latitude: -15.4647, longitude: -47.5547), info: "Cidade da robalheira", wikiURL: "https://pt.wikipedia.org/wiki/Bras%C3%ADlia")
        let ottawa = Capital(title: "Ottawa", coordinate: CLLocationCoordinate2D(latitude: 45.424721, longitude: -75.695000), info: "Beautiful city <3", wikiURL: "https://pt.wikipedia.org/wiki/Ottawa")
        let tokyo = Capital(title: "Tokyo", coordinate: CLLocationCoordinate2D(latitude: 35.41, longitude: 139.46), info: "Uma das áreas urbanas mais populosas do mundo", wikiURL: "https://pt.wikipedia.org/wiki/Tokyo")
        
        mapView.addAnnotations([london, paris, rome, oslo, brasilia, ottawa, tokyo])
        
        //challenge 2
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map Type", style: .plain, target: self, action: #selector(selectMapType))
    }
    
    @objc func selectMapType() {
        let alert = UIAlertController(title: "Map type", message: nil, preferredStyle: .actionSheet)
        alert.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        for mapType in Array(mapTypes.keys).sorted(by: <) {
            alert.addAction(UIAlertAction(title: mapType, style: .default, handler: mapTypeSelected))
        }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }
    
    func mapTypeSelected(action: UIAlertAction) {
        guard let title = action.title else { return }
        if let type = mapTypes[title] {
            mapView.mapType = type
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //se a annotation não for uma capital, ira retornar nil, entao iOS usa uma view default
        guard annotation is Capital else { return nil }
        
        //Define a reuse identifier. This is a string that will be used to ensure we reuse annotation view as much as possible
        let identifier = "Capital"
        
        //Try to dequeue an annotation view from the map view's pool of unused views.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            //triggers the popup with the city name.
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            //5
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            //6
            annotationView?.annotation = annotation
            //challenge 1
            if let pinView = annotationView as? MKPinAnnotationView {
                pinView.pinTintColor = UIColor(red: 0.8196, green: 0, blue: 0.5451, alpha: 1.0)
            }
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        
        let alert = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Wikipedia", style: .default, handler: { [weak self] _ in
            self?.openWikipedia(url: capital.wikiURL)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func openWikipedia(url: String) {
        if let vc = storyboard?.instantiateViewController(identifier: "WebViewController") as? WebViewController {
            vc.website = url
            navigationController?.pushViewController(vc, animated: true)
        }
    }



}

