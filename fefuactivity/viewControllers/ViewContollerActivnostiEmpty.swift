//
//  ViewContollerActivnostiEmpty.swift
//  fefuactivity
//

//

import UIKit

class ViewControllerActivnosiEmpty: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationItem.setHidesBackButton(true, animated: false);
        self.navigationItem.backButtonTitle = "Назад";
    }
    
}
