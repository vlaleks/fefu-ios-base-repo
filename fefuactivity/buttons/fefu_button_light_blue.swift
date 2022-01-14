//
//  fefu_button_light_blue.swift
//  fefuactivity
//

//

import UIKit

class FEFUButtonType2LightBlue: UIButton{
    required init?(coder: NSCoder){
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit(){
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor.systemBlue;
    }
}

