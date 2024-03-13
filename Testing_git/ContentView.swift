import SwiftUI

struct ContentView: View {
    @State private var operation: String = ""
    @State private var result: Double = 0.0
    @State private var firstNumber: String = ""
    @State private var secondNumber: String = ""
    @State private var isFirstNumberSet: Bool = true
    @State private var minusFlag = false
    @State private var answer: Double = 0.0
    @State private var imageIndex = 4
    @State private var colorIndex = 0
    let brutalIamge = ["2020-Gordon-Murray-Automotive-T50-4","2022-Gordon-Murray-Automotive-T50-45","Murray-T50-7","bugatti_divo_00","RIMAC_NEVERA_FRONT_HIGH-2880x1920"]
    let customNames = ["P1", "P2", "P3", "P4", "P5"]
    let colors: [Color] = [Color.red, Color.green, Color.blue, Color.purple, Color.brown]
    let colorNames = ["Red", "Green", "Blue", "Purple", "Brown"]
    
    var body: some View {
        ZStack{
    
            Image(brutalIamge[imageIndex])
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack{
                    Spacer()
                        .frame(width: 350)
                    Menu {
                        ForEach(0..<customNames.count) { index in
                            Button(action: {
                                self.imageIndex = index
                            })
                            {
                                Text(self.customNames[index])
                            }
                        }
                    } label: {
                        Text("Background")
                            .frame(width: 65, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [colors[colorIndex]]), startPoint: .top, endPoint: .bottom))
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .padding()
                    }
                    .frame(width: 60, height: 12)
                    .padding()
                   
                    Menu{
                        ForEach(0..<colors.count){ index in
                            Button(action: {
                                self.colorIndex = index
                            })
                            {
                                Text(self.colorNames[index])
                            }
                        }
                    }label: {
                        Text("Button color")
                            .frame(width: 65, height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [colors[colorIndex]]), startPoint: .top, endPoint: .bottom))
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .padding()
                    }
                    .frame(width: 60, height: 12)
                    .padding()
                    
                    Spacer()
                        .frame(width: 150)
                }
                .padding()
                .navigationBarTitle("Dropdown Menu")
                
                Spacer()
                    .frame(height: 100)
                
                if answer == 0.0 {
                    HStack{
                        if minusFlag{
                            Text("- \(firstNumber)")
                                .calculationStyle()
                            Text(operation)
                                .calculationStyle()
                            Text("\(secondNumber)")
                                .calculationStyle()
                        }else {
                            Text("\(firstNumber)")
                                .calculationStyle()
                            Text(operation)
                                .calculationStyle()
                            Text("\(secondNumber)")
                                .calculationStyle()
                        }
                    }
                    .padding(.horizontal)
                    .background(.white)
                    .cornerRadius(10)
                    
                    
                } else {
                    HStack{
                        Text("\(String(format: "%.3f", answer))")
                            .calculationStyle()
                        Text(operation)
                            .calculationStyle()
                        if operation == "√x" || operation == "x²"{
                            Text("")
                        } else{
                            Text("\(firstNumber)")
                                .calculationStyle()
                        }
                    }
                    .padding(.horizontal)
                    .background(.white)
                    .cornerRadius(10)
                    
                    }
                
                Spacer()
                    .frame(height: 20)
    
                if operation == "√x" && minusFlag {
                    Text("\(String(format: "%.2f", result))i")
                        .resultStyle()
                        .padding(.horizontal)
                        .background(.white)
                        .cornerRadius(10)
                        
                } else {
                    Text("\(String(format: "%.2f", result))")
                        .resultStyle()
                        .padding(.horizontal)
                        .background(.white)
                        .cornerRadius(10)
                }
                    
                
                Spacer()
                    .frame(height: 50)
                
                VStack {
                    ForEach(0..<3) { row in
                        HStack(spacing:.maximum(15, 5)) {
                            ForEach(0..<3) { column in
                                Button(action: {
                                    self.appendNumberToCurrentNumber("\(row * 3 + column + 1)")
                                }) {
                                    Text("\(row * 3 + column + 1)")
                                        .buttonStyle(backgroundColors: [colors[colorIndex]])
                                }
                                .frame(width: 55, height: 55)
                            }
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 15)
            
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.appendNumberToCurrentNumber("0")
                    }) {
                        Text("0")
                            .buttonStyle(backgroundColors: [colors[colorIndex]])
                    }
                    Button(action: {
                        self.appendNumberToCurrentNumber(".")
                    }) {
                        Text(",")
                            .buttonStyle(backgroundColors: [colors[colorIndex]])
                    }
                    .frame(width: 35)
                
                    Button(action: {
                        self.calculateResult()
                    }) {
                        Text("=")
                            .buttonStyle(backgroundColors: [colors[colorIndex]])
                    }
                    Spacer()
                }
                .frame(width: 10, height: 10)
                .padding()
                
                Spacer()
                    .frame(height: 20)
                
                HStack(spacing:.maximum(0, 23)){
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
                        })
                        { Text(op)
                                .buttonStyle(backgroundColors: [colors[colorIndex]])
                        }
                        
                    }
                    .frame(width: 40, height: 40)
                }
                .padding()
                
                HStack{
                    Button(action: {
                        self.reset()
                    }) {
                        Text("C")
                            .buttonStyle(backgroundColors: [colors[colorIndex]])
                    }
                    
                    Button(action:{
                        self.clearAll()
                    }) {
                        Text("AC")
                            .buttonStyle(backgroundColors: [colors[colorIndex]])
                    }
                    
                    Button(action: {
                        self.answr()
                        self.reset()
                    }){
                        Text("M")
                            .buttonStyle(backgroundColors: [colors[colorIndex]])
                    }
                }
                .frame(width: 10, height: 40)
                .padding()
                
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
        result = 0.0
        return answer
    }
}

extension Text {
    func buttonStyle(backgroundColors: [Color]) -> some View {
        self
            .frame(width: 55, height: 55)
            .background(LinearGradient(gradient: Gradient(colors: backgroundColors), startPoint: .top, endPoint: .bottom))
            .font(.system(size: 20))
            .foregroundColor(.white)
            .cornerRadius(15)
            .padding()
    }
    
    func resultStyle() -> some View{
        self
            .foregroundColor(.black)
            .font(.system(size: 30))
            .fontWeight(.regular)
            .background(.white)
            .cornerRadius(3.0)
    }
    
    func calculationStyle() -> some View{
        self
            .foregroundColor(.black)
            .font(.system(size: 30))
            .fontWeight(.regular)
            .cornerRadius(3.0)
    }
}

extension Color {
    init(hex: UInt32, alpha: Double = 1.0){
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}


#Preview {
    ContentView()
}
