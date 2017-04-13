//
//  CalculatorBrain.swift
//  calculator
//
//  Created by Adrien on 11/04/2017.
//  Copyright © 2017 Busin. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        switch symbol {
        case "π": accumulator = Double.pi
        case "√": accumulator = sqrt(accumulator)
        default: break
        }
    }
    
    var result: Double{
        get{
            return accumulator
        }
        set{
            
        }
    }
}
