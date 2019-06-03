import Foundation

enum TokenType {
    case Number
    case Operator
    // expand for additional functionality. Eg. variables
}

enum Errors: Error {
    case invalidArgument(String)
    case argumentNotSupported(String)
    case divideByZero()
}
