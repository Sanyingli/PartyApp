//
//  MapViewController.swift
//  PartyApp
//
//  Created by 李原平 on 16/12/5.
//  Copyright © 2016年 SanyingLi. All rights reserved.
//

import UIKit
import Social
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var partyInfo: PartyAnnotation?
    let persistence = Persistence()
    
    var cellIndexPath: Int = 0
    var centerLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //share bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,target: self, action: #selector(shareTapped))
        
        //get party info from userDefault, then change it into annotation data, then shows in the map
        getPartyInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //shows the annotation in the map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("mapview_viewFor run")//for test if viewFor run or not
        
        let identifier = "Party"
        
        if annotation is PartyAnnotation
        {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil { //set detail in the annotation
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                                let btn = UIButton(type: .detailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            } else {
                annotationView!.annotation = annotation
            }
            return annotationView
        }
        
        return nil
        
    }
    
    //info show when tab the annotation
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let party = view.annotation as! PartyAnnotation
        let placeName = party.title
        let placeInfo = party.address
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    //func to zoom the map
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //share func, share address to facebook,being called in the navigationBarButton
    func shareTapped()
    {
        if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook){
            vc.setInitialText("join this party! Address: \(partyInfo?.address)")
            present(vc, animated: true)}
    }
    
    
    //func to get party info then called other func to show the party
    func getPartyInfo(){
        let index = persistence.fetchIndex()
        let parties = persistence.fetchParty()
        var coord: CLLocationCoordinate2D?
        
        let partyShow = parties[index]
        let geo = CLGeocoder()
        let location = partyShow.address
        
        //use to transfer address to CLLocationCoordinate2D.
        geo.geocodeAddressString(location) {placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                coord = location.coordinate
                print(coord.debugDescription)
                
                //after get the coordinate, run func to show the party in the map
                self.partyInfo = PartyAnnotation.init(title: partyShow.name, coordinate: coord!, address: partyShow.address)
                self.centerLocation = CLLocation(latitude: (coord?.latitude)!, longitude: (coord?.longitude)!)
                self.centerMapOnLocation(location: self.centerLocation!)
                self.mapView.addAnnotation(self.partyInfo!)
            }
            if (error != nil) {
                //if address cannot transfer into coordinate, show error message
                let ac = UIAlertController(title: "Error Party Address", message: "Cannot find this address, please check the address", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            }
        }
 
    }
}
