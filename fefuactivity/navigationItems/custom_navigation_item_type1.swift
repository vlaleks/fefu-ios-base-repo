//
//  custom_navigation_item_type1.swift
//  fefuactivity
//

//
import UIKit
class CustomNavigationBar: UINavigationBar {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        CommonInit()
    }
    private func CommonInit(){
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
