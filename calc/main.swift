import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

// calculate passed arguments and print result
do {
    let calc: ShuntingYardCalc = ShuntingYardCalc();
    let result = try calc.calculate(args);
    print(result);
    exit(0);
} catch Errors.invalidArgument(let error) {
    print("Invalid argument error: \(error).")
} catch Errors.argumentNotSupported(let error) {
    print("Argument not supported error: \(error).")
} catch Errors.divideByZero {
    print("Divide by zero error.")
} catch {
    print("Unexpected error: \(error).")
}
exit(1)

