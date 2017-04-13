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
    
    private var operations: Dictionary<String, Operation> = [
        "±": Operation.UnaryOperation({-$0}),
        "AC": Operation.Reset,
        "%": Operation.UnaryOperation({$0/100}),
        "e": Operation.Constant(M_E),
        ",": Operation.BinaryOperation({$0 + ($1/10)}),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "×": Operation.BinaryOperation({$0 * $1}),
        "÷": Operation.BinaryOperation({$0 / $1}),
        "+": Operation.BinaryOperation({$0 + $1}),
        "−": Operation.BinaryOperation({$0 - $1}),
        "=": Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Reset
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firsOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            case .Reset:
                pending = nil
                accumulator = 0
                
            }
        }
    }
    
    private func executePendingBinaryOperation(){
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firsOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending : PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction:(Double, Double) -> Double
        var firsOperand: Double
    }
    
    var result: Double{
        get{
            return accumulator
        }
        set{
            
        }
    }
}
