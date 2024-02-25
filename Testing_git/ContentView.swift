import SwiftUI

struct ContentView: View {
    @State private var operation: String = ""
    @State private var result: Double = 0.0
    @State private var firstNumber: String = ""
    @State private var secondNumber: String = ""
    @State private var isFirstNumberSet: Bool = true
    @State private var minusFlag = false
    @State private var answer: Double = 0.0
    
    
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
                    
                    
                    Button(action: {
                        self.calculateResult()
                    }) {
                        Text("=")
                            .buttonStyle()
                    }
                    
                    
                    Button(action: {
                        self.appendNumberToCurrentNumber(".")
                    }) {
                        Text(",")
                            .buttonStyle()
                    }
                    
                    
                    Button(action: {
                        self.answr()
                        self.reset()
                    }){
                        Text("ANS")
                            .buttonStyle()
                    }
                }.padding()
                
                
                // Operations buttons
                HStack{
                    ForEach(["+", "-", "*", "/", "√x", "x²"], id: \.self) { op in
                        Button(action: {
                            if answer == 0.0{
                                if self.firstNumber == "" {
                                    if op == "-" {
                                        minusFlag = true
                                    }
                                } else {
                                    self.operation = op
                                }
                            }else {
                                if self.firstNumber == "" {
                                    self.operation = op
                                } else {
                                    self.operation = op
                                }
                            }
                        }){ Text(op)
                        }
                        .frame(width: 35, height: 35)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue]), startPoint: .top, endPoint: .bottom))
                        .foregroundColor(.white)
                        .cornerRadius(5)
                    }
                }.padding()
                
                
                HStack{
                    Button(action: {
                        self.reset()
                    }) {
                        Text("C")
                            .buttonStyle()
                    }
                    
                    Button(action:{
                        self.clearAll()
                    }) {
                        Text("AC")
                            .buttonStyle()
                    }
                    
                }
                
                if answer == 0.0 {
                    HStack{
                        if minusFlag{
                            Text("- \(firstNumber)")
                            Text(operation)
                            Text("\(secondNumber)")
                        }else {
                            Text("\(firstNumber)")
                            Text(operation)
                            Text("\(secondNumber)")
                        }
                    }
                    .foregroundColor(.white)
                } else {
                    HStack{
                        
                            Text("\(String(format: "%.3f", answer))")
                            Text(operation)
                            Text("\(firstNumber)")
                        }
                    .foregroundColor(.white)

                    }
                                
                
                if operation == "√x" && minusFlag {
                    Text("Result: \(String(format: "%.3f", result))i")
                        .foregroundColor(.white)
                } else {
                    Text("Result: \(String(format: "%.3f", result))")
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
    
    func appendNumberToCurrentNumber(_ number: String) {
        if answer == 0.0 {
            if operation.isEmpty {
                if firstNumber.isEmpty && number == "-" {
                    firstNumber.append(number)
                }else {
                    firstNumber.append(number)
                }
            }
            
            else {
                if operation == "x²" || operation == "√x"{
                    secondNumber = ""
                }else {
                    secondNumber.append(number)
                }
                
            }
            
        } else {
            if operation.isEmpty {
                if answer != 0.0 && answer < 0 {
                    firstNumber.append(number)
                }else {
                    firstNumber.append(number)
                }
            } else {
                if operation == "x²" || operation == "√x"{
                    firstNumber = ""
                    secondNumber = ""
                }else {
                    firstNumber.append(number)
                }
                
            }
        }
    }
    
    func calculateResult() {
        let firstNum = Double(firstNumber) ?? 0.0
        let secondNum = Double(secondNumber) ?? 0.0
        
        if answer == 0.0 {
            
            switch operation {
            case "+":
                if minusFlag {
                    result = add(negNum(firstNum), secondNum)
                    
                }else {
                    result = add(firstNum, secondNum)
                    
                }
                
            case "-":
                if minusFlag {
                    result = subtract(negNum(firstNum), secondNum)
                    
                }else {
                    result = subtract(firstNum, secondNum)
                    
                }
            case "*":
                if minusFlag{
                    result = multiply(negNum(firstNum), secondNum)
                    
                }else {
                    result = multiply(firstNum, secondNum)
                    
                }
                
            case "/":
                if minusFlag{
                    result = divide(negNum(firstNum), secondNum)
                    
                }else {
                    result = divide(firstNum, secondNum)
                    
                }
                
            case "x²":
                result = squareClac(firstNum)
                
                
            case "√x":
                result = squareRoot(firstNum)
                
                // Do nothing, the result should already be calculated
                break
            default:
                break
            }
        } else if answer != 0 {
            switch operation {
            case "+":
                if minusFlag {
                    result = add(negNum(answer), firstNum)
                    
                }else {
                    result = add(answer, firstNum)
                    
                }
                
            case "-":
                    result = subtract(answer, firstNum)
                    
            case "*":
                if minusFlag{
                    result = multiply(negNum(answer), firstNum)
                    
                }else {
                    result = multiply(answer, firstNum)
                    
                }
                
            case "/":
                if minusFlag{
                    result = divide(negNum(answer), firstNum)
                    
                }else {
                    result = divide(answer, firstNum)
                    
                }
                
            case "x²":
                result = squareClac(answer)
                
                
            case "√x":
                result = squareRoot(answer)
                
                // Do nothing, the result should already be calculated
                break
            default:
                break
            }
        }
 
    }
    func reset() {
        operation = ""
        firstNumber = ""
        secondNumber = ""
        minusFlag = false
        
    }
    
    func clearAll() {
        operation = ""
        firstNumber = ""
        secondNumber = ""
        minusFlag = false
        result = 0.0
        answer = 0.0
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
    
    func negNum(_ num: Double) -> Double {
        return -num
    }
    
    func answr() -> Double {
        answer = result
        return answer
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
