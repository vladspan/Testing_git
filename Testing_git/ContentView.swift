import SwiftUI

struct ContentView: View {
    @State private var operation: String = ""
    @State private var result: Double = 0.0
    @State private var firstNumber: String = ""
    @State private var secondNumber: String = ""
    @State private var isFirstNumberSet: Bool = true
    
    
    var body: some View {
        ZStack{
            Image("bugatti_divo_00")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Cool calc")
                    .foregroundColor(.blue)
                    .font(.system(size: 35, weight: .bold))
                    .padding()
                
                // Grid of numbers in 3x3 format
                VStack {
                    ForEach(0..<3) { row in
                        HStack(spacing:.maximum(0, 0)) {
                            ForEach(0..<3) { column in
                                Button(action: {
                                    self.appendNumberToCurrentNumber("\(row * 3 + column + 1)")
                                }) {
                                    Text("\(row * 3 + column + 1)")
                                        .buttonStyle()
                                }
                                .frame(width: 40, height: 40)
                            }
                        }
                    }
                }
                
                // Additional buttons for 0, =, and comma (,)
                HStack {
                    Button(action: {
                        self.appendNumberToCurrentNumber("0")
                    }) {
                        Text("0")
                            .buttonStyle()
                    }
                    .padding()
                    
                    Button(action: {
                        self.operation
                        self.calculateResult()
                    }) {
                        Text("=")
                            .buttonStyle()
                    }
                    .padding()
                    
                    Button(action: {
                        self.appendNumberToCurrentNumber(".")
                    }) {
                        Text(",")
                            .buttonStyle()
                    }
                    .padding()
                }
                
                // Operations buttons
                HStack{
                    ForEach(["+", "-", "*", "/", "√x", "x^2"], id: \.self) { op in
                        Button(action: {
                            self.operation = op
                            //self.calculateResult()
                        }){ Text(op)
                        }
                        .frame(width: 35, height: 35)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue]), startPoint: .top, endPoint: .bottom))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                    }
                }.padding()
                
                
                // Reset button
                Button(action: {
                    self.reset()
                }) {
                    Text("C")
                        .buttonStyle()
                }
                .padding()
                
                HStack{
                    Text("\(firstNumber)")
                    Text(operation)
                    Text("\(secondNumber)")
                }
                .foregroundColor(.white)
                
                Text("Result: \(String(format: "%.3f", result))")
                    .foregroundColor(.white)
                
            }
            
            .padding()
            
        }
    }
    
    func appendNumberToCurrentNumber(_ number: String) {
        if operation.isEmpty {
            firstNumber.append(number)
        } else {
            secondNumber.append(number)
        }
    }
    
    func calculateResult() {
        let firstNum = Double(firstNumber) ?? 0.0
        let secondNum = Double(secondNumber) ?? 0.0
        
        switch operation {
        case "+":
            result = add(firstNum, secondNum)
        case "-":
            result = subtract(firstNum, secondNum)
        case "*":
            result = multiply(firstNum, secondNum)
        case "/":
            result = divide(firstNum, secondNum)
        case "x^2":
            result = squareClac(firstNum)
        case "√x":
            result = squareRoot(firstNum)
            // Do nothing, the result should already be calculated
            break
        default:
            break
        }
 
    }
    func reset() {
        operation = ""
        result = 0.0
        firstNumber = ""
        secondNumber = ""
        
    }
    func add(_ num1: Double, _ num2: Double) -> Double {
        return num1 + num2
        
    }
    
    func subtract(_ num1: Double, _ num2: Double) -> Double {
        return num1 - num2
    }
    
    func multiply(_ num1: Double, _ num2: Double) -> Double {
        return num1 * num2
    }
    
    func divide(_ num1: Double, _ num2: Double) -> Double {
        if num2 != 0 {
            return num1 / num2
        } else {
            // Handle division by zero
            return 0.0
        }
    }
    
    func squareClac(_ num: Double) -> Double{
        return num * num
    }
    
    func squareRoot(_ num: Double) -> Double {
        return sqrt(num)
    }
}




extension Text {
    func buttonStyle() -> some View {
        self
            .frame(width: 35, height: 35)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue]), startPoint: .top, endPoint: .bottom))
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
