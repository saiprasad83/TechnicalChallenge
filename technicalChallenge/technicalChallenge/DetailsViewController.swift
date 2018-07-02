//
//  DetailsViewController.swift
//  technicalChallenge
//
//  Created by Sasikumar on 7/3/18.
//  Copyright © 2018 Sai prasad Soma. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var profile:Results?
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var dob: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = profile else {
            return
        }
        if let thum = user.picture?.medium, let url = URL.init(string: thum) {
            imageViewUser?.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "HQwHI"), options: .cacheMemoryOnly, completed: nil)
        }
        if let fname = (user.name?.first) {
            name.text = fname
        }
        
        if let emails = (user.email) {
            email.text =  emails
        }
        if let dobs = (user.dob?.date) {
            dob.text =  dobs
        }
        
        if let city = user.location?.city, let coor = user.location?.coordinates, let lat = coor.latitude, let lon = coor.longitude, let laat =  Double(lat), let loon = Double(lon){
            let locationMap = CLLocationCoordinate2D.init(latitude: laat, longitude: loon)
            mapView.setCenter(locationMap, animated: true)
            let london = MKPointAnnotation()
            london.title = city
            london.coordinate = locationMap
            mapView.addAnnotation(london)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    @IBAction func call(_ sender: Any) {
        if let number = profile?.cell, let url = URL(string: "tel://" + number), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }


}
