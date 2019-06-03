import Foundation

class Token {
    var value: String
    var type: TokenType = TokenType.Number
    var presedence: Int = 0

    init (_ value: String) throws {
        self.value = value;
        if isOperator(value) {
            self.type = TokenType.Operator
            self.presedence = try getPresedence(value)
        } else if !isNumber(value) {
            throw Errors.invalidArgument("\(value) token is neither a valid Number nor Operator");
        }
    }
    
    func isNumber(_ token: String) -> Bool {
        return Int(token) != nil
    }

    func isOperator(_ token: String) -> Bool {
        let operators = ["+", "-", "x", "/", "%",]
        return operators.contains(token)
    }
    
    func getPresedence(_ token: String) throws -> Int {
        switch (token) {
        case "+", "-":
            return 0
        case "x", "/", "%":
            return 1
        default:
            throw Errors.argumentNotSupported("No presedence for token: \(token)")
        }
    }
    
    func performOperation(_ num1: Int, _ num2: Int) throws -> Int {
        switch (value) {
        case ("+"):
            return num1 + num2
        case ("-"):
            return num1 - num2
        case ("x"):
            return num1 * num2
        case ("/"):
            if (num2 == 0) {
                throw Errors.divideByZero()
            }
            return num1 / num2
        case ("%"):
            return num1 % num2
        default:
            throw Errors.argumentNotSupported("No operation defined for: \(value)")
        }
    }
}
