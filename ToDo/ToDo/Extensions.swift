//
//  Extensions.swift
//  ToDo
//
//  Created by Ahamed Muqthar M K on 14/03/17.
//  Copyright © 2017 Privin. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func anchors(topAnchor : NSLayoutAnchor<NSLayoutYAxisAnchor>?, bottomAnchor : NSLayoutAnchor<NSLayoutYAxisAnchor>?, leftAnchor : NSLayoutAnchor<NSLayoutXAxisAnchor>?, rightAnchor : NSLayoutAnchor<NSLayoutXAxisAnchor>?, topConstant : CGFloat, bottomConstant : CGFloat, leftConstant : CGFloat, rightConstant : CGFloat, width : CGFloat, height : CGFloat){
        if  topAnchor != nil {
            self.topAnchor.constraint(equalTo: topAnchor!, constant: topConstant).isActive = true
        }
        if bottomAnchor != nil{
            self.bottomAnchor.constraint(equalTo: bottomAnchor!, constant: -(bottomConstant)).isActive = true
        }
        if leftAnchor != nil {
            self.leftAnchor.constraint(equalTo: leftAnchor!, constant: leftConstant).isActive = true
        }
        if rightAnchor != nil {
            self.rightAnchor.constraint(equalTo: rightAnchor!, constant: -(rightConstant)).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
}
