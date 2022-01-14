//
//  Run_activity_controller.swift
//  fefuactivity
//

//

import UIKit

class Run_activity_controller: UIViewController {
    @IBOutlet var view_with_buttons: Active_activity!
    var distance = Float()
    @IBOutlet weak var time_of_activity: UILabel!
    @IBOutlet weak var distance_activity: UILabel!
    @IBOutlet weak var type_activity: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
