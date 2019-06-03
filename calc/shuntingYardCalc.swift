import Foundation

class ShuntingYardCalc {
    var queue: [Token] = []
    var stack: [Token] = []
    
    // calculate an expression using the Shunting Yard algorithm
    func calculate(_ args: [String]) throws -> Int {
        try convertInfixToPostfix(args);
        try computePostfixExpression();

        if (stack.count == 1) { // there can only be 1 token left
            return Int(stack[0].value)!
        } else {
            throw Errors.invalidArgument("There was more than one value remaining in the stack at the end of calculation.");
        }
    }
    
    // pop the lasr 2 tokens(numbers) from the stack. Perform operation then append the result back to stack
    func performOperationOnStack(_ stack: inout [Token], _ operation: Token) throws {
        let lastToken: Token = stack.popLast()!;
        let secondlastTokem: Token = stack.popLast()!;
        
        let result: Int = try operation.performOperation(Int(secondlastTokem.value)!, Int(lastToken.value)!)
        let newToken = try Token(String(result));
        
        stack.append(newToken);
    }
    
    // convert Infix notation expression into Postfix (Reverse Polish) notation
    func convertInfixToPostfix(_ args: [String]) throws {
        for i in 0..<args.count {
            let token: Token = try Token(args[i])
            if token.type == TokenType.Number {
                queue.append(token)
            } else {
                while stack.count > 0 &&
                    stack.last!.presedence >= token.presedence {
                        queue.append(stack.last!)
                        stack.removeLast()
                }
                stack.append(token)
            }
        }
        
        // move the rest of the stack to the queue
        while stack.count > 0 {
            queue.append(stack.last!)
            stack.removeLast()
        }
    }
    
    // compute Postfix (Reverse Polish) expression
    func computePostfixExpression() throws {
        for i in 0..<queue.count {
            if ((queue[i]).type == TokenType.Number) {
                stack.append(queue[i])
            } else {
                try performOperationOnStack(&stack, queue[i])
            }
        }
    }
}
