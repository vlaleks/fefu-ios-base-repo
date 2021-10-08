//
//  ButtonSign.swift
//  fefuactivity
//ы
//  Created by wsr5 on 08.10.2021.
//


import UIKit

class FEFUButtonSign: UIButton{
    required init?(coder: NSCoder){
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit(){
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(named: "ButtonSigner" )
        
    }
}

