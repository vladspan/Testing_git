
import SwiftUI

struct ContentView: View {
    @State private var currentNumber: String = ""
    @State private var result: Double = 0
    @State private var accumulatedNumbers: [Double] = []
    @State private var operation: String = ""

    var body: some View {
        VStack {
            Text("Cool calc")
                .foregroundColor(.blue)
                .font(.system(size: 40, weight: .bold))
                .padding()

            Text("Result: \(String(format: "%.2f", result))")
                .foregroundColor(.white)
                .padding()

            // Number Buttons
            GridStack(rows: 3, columns: 3) { row, col in
                Button(action: {
                    self.appendNumber((row * 3) + col + 1)
                }) {
                    Text("\((row * 3) + col + 1)")
                        .buttonStyle()
                }
            }

            HStack {
                Button(action: { self.appendNumber(0) }) {
                    Text("0")
                        .buttonStyle()
                }

                Button(action: { self.reset() }) {
                    Text("C")
                        .buttonStyle()
                }
            }
            .padding()

            // Operation Buttons
            VStack {
                ForEach(["+", "-", "*", "/"], id: \.self) { op in
                    Button(action: { self.performOperation(op) }) {
                        Text(op)
                            .buttonStyle()
                    }
                }
            }
            .padding()

            // Other Operations
            HStack {
                Button(action: { self.performSquare() }) {
                    Text("x^2")
                        .buttonStyle()
                }

                Button(action: { self.performSquareRoot() }) {
                    Text("√")
                        .buttonStyle()
                }
            }
            .padding()

        }
        .padding()
        .background(
            Image("bugatti_divo_00")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }

    func appendNumber(_ number: Int) {
        currentNumber += "\(number)"
        if let num = Double(currentNumber) {
            result = num
        }
    }

    func performOperation(_ op: String) {
        if let number = Double(currentNumber) {
            accumulatedNumbers.append(number)
            currentNumber = ""
        }

        switch operation {
        case "":
            break
        case "+":
            result += accumulatedNumbers.reduce(0, +)
        case "-":
            result -= accumulatedNumbers.reduce(0, +)
        case "*":
            result *= accumulatedNumbers.reduce(1, *)
        case "/":
            if let firstNumber = accumulatedNumbers.first {
                result = accumulatedNumbers.dropFirst().reduce(firstNumber, /)
            }
        default:
            break
        }

        operation = op
    }
    
    func performSquareRoot() {
        if let number = Double(currentNumber) {
            result = sqrt(number)
            currentNumber = ""
            operation = ""
        }
    }

    func performSquare() {
        if let number = Double(currentNumber) {
            result = pow(number, 2)
            currentNumber = ""
            operation = ""
        }
    }

    func reset() {
        result = 0
        currentNumber = ""
        accumulatedNumbers = []
    }
    
}

extension Text {
    func buttonStyle() -> some View {
        self
            .frame(width: 29, height: 29)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue]), startPoint: .top, endPoint: .bottom))
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding()
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}



#Preview {
    ContentView()
}
