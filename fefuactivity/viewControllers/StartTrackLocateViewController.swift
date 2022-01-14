//
//  StartTrackLocateViewController.swift
//  fefuactivity
//

//

import UIKit
import CoreLocation
import MapKit


class LocationTrackingView: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.requestAlwaysAuthorization()
        another_container_view.isHidden = true
    }
    var long_of_activnosti: Double = 0
    let userLocationIdentifier = "user_location_icon"
    var chosenActivity: String?
    var myTreasure: Run_activity_controller?
    @IBOutlet weak var container_view: UIView!
    @IBOutlet weak var another_container_view: UIView!
    @IBOutlet weak var mapView: MKMapView!
    let CoreDataActivity = FEFUCoreDataContainer.instance
    func start_track_location(typeFromChild: String){
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        container_view.isHidden = true
        another_container_view.isHidden = false
        self.chosenActivity = typeFromChild
        for child in self.children{
            if child is Run_activity_controller{
                myTreasure = child as? Run_activity_controller
            }
        }
        myTreasure!.view_with_buttons.createTimer()
        myTreasure!.view_with_buttons.setSelectedType(type: typeFromChild)
        
    }
    
    func pause_track_location(){
        locationManager.stopUpdatingLocation()
        mapView.showsUserLocation = false
    }
    func continue_updating_location(){
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    func finish_activity(durationFromChild: String){
        container_view.isHidden = false
        another_container_view.isHidden = true
        locationManager.stopUpdatingLocation()
        mapView.showsUserLocation = false
        if userLocationHistory.count > 0{
            let core_data = CDUserActivitys(context: CoreDataActivity.context)
            core_data.long_of_activity = long_of_activnosti / 1000;
            
            core_data.start_date = userLocationHistory[0].timestamp
            core_data.end_date = userLocationHistory.last?.timestamp
            core_data.type_of_activity = self.chosenActivity
            core_data.durationOfActivity = durationFromChild
            CoreDataActivity.saveContext()
        }
        userLocationHistory.removeAll()
        
        
    }
    
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    var userLocation: CLLocation? {
        didSet {
            guard let userLocation = userLocation else {
                return
            }
            let region = MKCoordinateRegion(
                        center:userLocation.coordinate,
                        latitudinalMeters: 500,
                        longitudinalMeters: 500
                )
            sendLongWayToChild()
            mapView.setRegion(region, animated: true)
            userLocationHistory.append(userLocation)
            
        }
    }
    
    fileprivate var userLocationHistory: [CLLocation] = []{
        didSet {
            if mapView.overlays.count > 0{
            mapView.removeOverlay(mapView.overlays[mapView.overlays.count - 1])
            }
            let coordinates = userLocationHistory.map { $0.coordinate }
            
            let route = MKPolyline(coordinates: coordinates,                                         count: coordinates.count)
            route.title = "Ваш маршрут"
            mapView.addOverlay(route)
        }
    }
    func getUserLocationHistory() -> [CLLocation] {
        return userLocationHistory
    }
    
    func sendLongWayToChild(){
        if (myTreasure == nil){
            for child in self.children{
                if child is Run_activity_controller{
                    myTreasure = child as? Run_activity_controller
                }
            }
        }
        if (userLocationHistory.count > 1){
            long_of_activnosti = long_of_activnosti +  userLocationHistory[userLocationHistory.count-2].distance(from: userLocationHistory[userLocationHistory.count-1])
            myTreasure?.view_with_buttons.updateDistance(text: (round(long_of_activnosti)/1000).description + " км")
        }
    }
    
}
extension LocationTrackingView: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else {
            return
        }
        userLocation = currentLocation
    }
}

extension LocationTrackingView: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay)->MKOverlayRenderer{
        if let polyline = overlay as? MKPolyline {
            let render = MKPolylineRenderer(polyline: polyline)
            render.fillColor = UIColor.blue
            render.strokeColor = UIColor.blue
            render.lineWidth = 5
            return render
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKUserLocation {
            
            let dequeView = mapView.dequeueReusableAnnotationView(withIdentifier: userLocationIdentifier)
            
            let view = dequeView ?? MKAnnotationView(
                annotation: annotation, reuseIdentifier: userLocationIdentifier
            )
            view.image = UIImage(named: "user_location_icon")
            return view
        }
        return nil
    }
}
