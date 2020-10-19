//
//  RandomUtils.swift
//  GoHome
//
//  Created by Fernando on 01/05/2020.
//  Copyright © 2020 Fernando Salvador. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGFloat {
    
    // Devuelve un número aleatorio entre 0 y 1
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    
    // Devuelve un número aleatorio entre un minimo y un maximo
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
           return random() * (max - min) + min
         }
    
    
}
