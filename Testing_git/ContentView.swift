//
//  ContentView.swift
//  Testing_git
//
//  Created by Vladimir Spanic on 17.02.2024..
//

import SwiftUI

struct ContentView: View {
    @State private var currentNumber: String = ""
    @State private var result: Double = 0
    @State private var accumulatedNumbers: [Double] = []
    @State private var operation: String = ""
   
    
    var body: some View {
        ZStack{
            Image("bugatti_divo_00")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    
            
            VStack {
                HStack{
                    Text("Cool calc")
                        .foregroundColor(.blue)
                        .font(.system(size: 40, weight: .bold))
                        .padding(.leading)
                    Spacer()
                
                }.padding(.bottom)
                Spacer()
                TextField("Enter number", text: $currentNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                //TextField("Enter second number", text: $secondNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                //
                VStack{
                    HStack{
                        Button(action: {
                            self.performOperation("+")}
                               , label: {
                            Text("+")
                                .frame(width: 40, height: 30)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue]), startPoint: .top, endPoint: .bottom))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding()
                            
                        })
                        .padding()
                        
                        
                        Button(action: {
                            self.performOperation("-")}
                               , label: {
                            Text("-")
                                .frame(width: 40, height: 30)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue]), startPoint: .top, endPoint: .bottom))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding()
                            
                        })
                        .padding()
                    }
                    HStack{
                        Button(action: {
                            self.performOperation("*")}
                               , label: {
                            Text("*")
                                .frame(width: 40, height: 30)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue]), startPoint: .top, endPoint: .bottom))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding()
                            
                        })
                        .padding()
                        
                        
                        Button(action: {
                            self.performOperation("/")}
                               , label: {
                            Text("/")
                                .frame(width: 40, height: 30)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue]), startPoint: .top, endPoint: .bottom))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding()
                            
                        })
                        .padding()
                    }
                    HStack{
                        Button(action: {
                            self.performSquare()}
                               , label: {
                            Text("x^2")
                                .frame(width: 40, height: 30)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue]), startPoint: .top, endPoint: .bottom))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding()
                            
                        })
                        .padding()
                        
                        
                        Button(action: {
                            self.performSquareRoot()}
                               , label: {
                            Text("√")
                                .frame(width: 40, height: 30)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue]), startPoint: .top, endPoint: .bottom))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding()
                            
                        })
                        .padding()
                    }
                }
                
                Text("Result: \(String(format: "%.2f",result))")
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack{
                    
                    Spacer()
                    Button(action: {resetNum()}, label:{
                        Text("Reset")
                            .frame(width: 100, height: 40)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue]), startPoint: .top, endPoint: .bottom))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    })
                    
                }.padding()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            }.padding(.horizontal, 500)
                
        }
    }
    
    func performOperation(_ op: String) {
        if let number = Double(currentNumber) {
            switch operation {
            case "":
                accumulatedNumbers.append(number)
                result = number
            case "+":
                accumulatedNumbers.append(number)
                result += number
            case "-":
                accumulatedNumbers.append(number)
                result -= number
            case "*":
                accumulatedNumbers.append(number)
                result *= number
            case "/":
                if number != 0 {
                    accumulatedNumbers.append(number)
                    result /= number
                } else {
                    // Handle division by zero error
                }
            default:
                break
            }
            
            currentNumber = ""
            operation = op
            
        }
    }
    
    func performSquareRoot(){
        if let number = Double(currentNumber){
            result = sqrt(number)
            currentNumber = ""
            operation = ""
        }
    }
    
    func performSquare(){
        if let number = Double(currentNumber){
            result = pow(number, 2)
            currentNumber = ""
            operation = ""
        }
    }
    
    func resetNum(){
        result = 0
        currentNumber = ""
    }
}


#Preview {
    ContentView()
}
