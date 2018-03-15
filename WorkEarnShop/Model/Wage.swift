//
//  Wage.swift
//  WorkEarnShop
//
//  Created by Saif Khan on 3/14/18.
//  Copyright © 2018 SaifSide Inc. All rights reserved.
//

import Foundation

class Wage {
    
    class func getHours(wage: Double, cost: Double) -> Int {
        return Int(ceil(cost / wage))
    }
}
