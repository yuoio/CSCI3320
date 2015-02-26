//
//  CalculatorBrain.m
//  Project1
//
//  Created by Wenhan on 2/24/15.
//  Copyright (c) 2015 Wenhan. All rights reserved.
//

#import "CalculatorBrain.h"

static NSDictionary *_dictionaryOfOperations;

#define NUMBER_OF_OPERATORS @"The number of the operators"
#define FORMAT_OF_OPERATIONS @"The format of the operation"


@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (!_operandStack)
        _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (void)setOperandStack:(NSMutableArray *)anArray
{
    _operandStack = anArray;
}

- (void)pushOperation:(NSString *)operation
{
    [self.operandStack addObject:operation];
}

- (void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}


// Core of 'Clear' function
- (void)clearOperandStack
{
    [self.operandStack removeAllObjects];
}



// Core of 'Backspace' function
- (void)clearTopOfOperandStack
{
    [self.operandStack removeLastObject];
}

// Store the operations format into NSDictionary
+ (NSDictionary *)dictionaryOfOperations
{
    if (!_dictionaryOfOperations) {
        NSMutableDictionary *index = [[NSMutableDictionary alloc] init];
        
        
        
        NSNumber *TwoOperators = [NSNumber numberWithInt:2];
        NSNumber *OneOperator = [NSNumber numberWithInt:1];
        NSNumber *NoOperator = [NSNumber numberWithInt:0];
    
        // Set up the dictionary of two operators' operation
        [index setValue:[NSDictionary dictionaryWithObjectsAndKeys:TwoOperators, NUMBER_OF_OPERATORS, @"(%@ + %@)", FORMAT_OF_OPERATIONS, nil] forKey:@"+"];
        [index setValue:[NSDictionary dictionaryWithObjectsAndKeys:TwoOperators, NUMBER_OF_OPERATORS, @"(%@ - %@)", FORMAT_OF_OPERATIONS, nil] forKey:@"-"];
        [index setValue:[NSDictionary dictionaryWithObjectsAndKeys:TwoOperators, NUMBER_OF_OPERATORS, @"(%@ * %@)", FORMAT_OF_OPERATIONS, nil] forKey:@"*"];
        [index setValue:[NSDictionary dictionaryWithObjectsAndKeys:TwoOperators, NUMBER_OF_OPERATORS, @"(%@ / %@)", FORMAT_OF_OPERATIONS, nil] forKey:@"/"];
        
        // Set up the dictionary of one operator operation
        [index setValue:[NSDictionary dictionaryWithObjectsAndKeys:OneOperator, NUMBER_OF_OPERATORS, @"Sin(%@)", nil] forKey:@"sin"];
        [index setValue:[NSDictionary dictionaryWithObjectsAndKeys:OneOperator, NUMBER_OF_OPERATORS, @"Cos(%@)", nil] forKey:@"cos"];
        [index setValue:[NSDictionary dictionaryWithObjectsAndKeys:OneOperator, NUMBER_OF_OPERATORS, @"√(%@)", nil] forKey:@"√"];
        
        // Set up the dictionary of no operator operation
        [index setValue:[NSDictionary dictionaryWithObjectsAndKeys:NoOperator, NUMBER_OF_OPERATORS, @"π", nil] forKey:@"π"];
        
        _dictionaryOfOperations = [index copy];
    }
    
    return _dictionaryOfOperations;
}

+ (id)popElementFromStack:(NSMutableArray *)stack
{
    id result;
    
    id element = [stack lastObject];
    if (element) [stack removeLastObject];
    
    if ([element isKindOfClass:[NSNumber class]]) {
        result = element;
    }
    else if ([element isKindOfClass:[NSString class]]) {
        result = [self performOperation:element withStack:stack];
        [self popElementFromStack:result];
    }
    
    return result;
}

// The core calculating part of the program
+ (id)performOperation:(NSString *)operation withStack:(NSMutableArray *)stack{
    
    id result, leftObject, rightObject;
    double leftValue = 0, rightValue = 0;
    unichar symbol;
    
    if ([operation length] > 0) symbol = [operation characterAtIndex:0];
    switch (symbol) {
        case '/':
            rightObject = [self popElementFromStack:stack];
            leftObject  = [self popElementFromStack:stack];
            if (!leftObject || !rightObject) {
                result = [@"ERROR: Not enough operands for " stringByAppendingString:operation];
            
                if (!result) {
                    if ([rightObject isKindOfClass:[NSNumber class]]) rightValue = [rightObject doubleValue];
                    if ([leftObject  isKindOfClass:[NSNumber class]]) leftValue  = [leftObject  doubleValue];
                    
                    if (rightValue == 0) {
                        result = @"ERROR: Divide by 0";
                    } else {
                        result = [NSNumber numberWithDouble:leftValue / rightValue];
                    }
                }
            }
            break;
            
        case '*':
            rightObject = [self popElementFromStack:stack];
            leftObject  = [self popElementFromStack:stack];
            if (!leftObject || !rightObject) {
                result = [@"ERROR: Not enough operands for " stringByAppendingString:operation];

                if (!result) {
                    if ([rightObject isKindOfClass:[NSNumber class]]) rightValue = [rightObject doubleValue];
                    if ([leftObject  isKindOfClass:[NSNumber class]]) leftValue  = [leftObject  doubleValue];
                    result = [NSNumber numberWithDouble:leftValue * rightValue];
                }
            }
            break;
            
        case '-':
            rightObject = [self popElementFromStack:stack];
            leftObject  = [self popElementFromStack:stack];
            if (!leftObject || !rightObject) {
                result = [@"ERROR: Not enough operands for " stringByAppendingString:operation];
   
                if (!result) {
                    if ([rightObject isKindOfClass:[NSNumber class]]) rightValue = [rightObject doubleValue];
                    if ([leftObject  isKindOfClass:[NSNumber class]]) leftValue  = [leftObject  doubleValue];
                    result = [NSNumber numberWithDouble:leftValue - rightValue];
                }
            }
            break;
            
        case '+':
            rightObject = [self popElementFromStack:stack];
            leftObject  = [self popElementFromStack:stack];
            if (!leftObject || !rightObject) {
                result = [@"ERROR: Not enough operands for " stringByAppendingString:operation];
            
                if (!result) {
                    if ([rightObject isKindOfClass:[NSNumber class]]) rightValue = [rightObject doubleValue];
                    if ([leftObject  isKindOfClass:[NSNumber class]]) leftValue  = [leftObject  doubleValue];
                    result = [NSNumber numberWithDouble:leftValue + rightValue];
                }
            }
            break;
            
        case 's':
            leftObject  = [self popElementFromStack:stack];
            if (!leftObject) {
                result = [@"ERROR: Not enough operands for " stringByAppendingString:operation];
            } else {
                    if ([leftObject isKindOfClass:[NSNumber class]]) leftValue = [leftObject doubleValue];
                    result = [NSNumber numberWithDouble:sin(leftValue)];
                }
            break;
            
        case 'c':
            leftObject  = [self popElementFromStack:stack];
            if (!leftObject) {
                result = [@"ERROR: Not enough operands for " stringByAppendingString:operation];
            } else {
                    if ([leftObject isKindOfClass:[NSNumber class]]) leftValue = [leftObject doubleValue];
                    result = [NSNumber numberWithDouble:cos(leftValue)];
                }
            break;
            
        case 0x221A: // √
            leftObject  = [self popElementFromStack:stack];
            if (!leftObject) {
                result = [@"ERROR: Not enough operands for " stringByAppendingString:operation];
            }
            else {
                    if ([leftObject isKindOfClass:[NSNumber class]]) leftValue = [leftObject doubleValue];
                    if (leftValue < 0)
                        result = @"ERROR: Negative √";
                    else
                        result = [NSNumber numberWithDouble:sqrt(leftValue)];
                
                }
            break;
            
        case 0x03C0: // π
            result = [NSNumber numberWithDouble:M_PI];
            break;
            
        default:
            result = [NSString stringWithFormat:@"ERROR: Unsupported operation %@", operation];
            break;
    }
    
    return result;
    
}


+ (NSString *)unwrapParenthesis:(NSString *)text
{
    NSString *result = text;
    
    if ([text hasPrefix:@"("] && [text hasSuffix:@")"]) {
        result = [text substringWithRange:NSMakeRange(1, [text length]-2)];
    }
    
    return result;
}


+ (NSString *)descriptionOfTopOfStack:(NSMutableArray *)stack
{
    NSString *result = @"";
    NSUInteger operands;
    NSString *format, *left, *right;
    
    id element = [stack lastObject];
    if (element) {
        [stack removeLastObject];
        
        NSDictionary *operation = [[self dictionaryOfOperations] objectForKey:element];
        if (operation) {
            // If the element is an operation...
            operands = [[operation objectForKey:NUMBER_OF_OPERATORS] unsignedIntegerValue];
            format = [operation objectForKey:FORMAT_OF_OPERATIONS];
            switch (operands) {
                case 2:
                    right = [self descriptionOfTopOfStack:stack];
                    left  = [self descriptionOfTopOfStack:stack];
                    if ([right isEqualToString:@""]) right = @"0";
                    if ([left isEqualToString:@""]) left = @"0";
                    result = [NSString stringWithFormat:format, left, right];
                    break;
                    
                case 1:
                    left  = [self descriptionOfTopOfStack:stack];
                    if ([left isEqualToString:@""]) left = @"0";
                    result = [NSString stringWithFormat:format, [self unwrapParenthesis:left]];
                    break;
                    
                case 0:
                    result = format;
                    break;
                    
                default:
                    NSLog(@"ERROR: Unsupported number of operands for operation %@: %@", operation, operands);
                    break;
            }
        } else {
            // If it is a regular element...
            result = [element description];
        }
    }
    
    return result;
}


+ (NSString *)descriptionOfProgram:(id)program
{
    NSMutableArray *stack;
    NSString *result;
    
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    result = [self unwrapParenthesis:[self descriptionOfTopOfStack:stack]];
    while ([stack count] != 0) {
        result = [[self unwrapParenthesis:[self descriptionOfTopOfStack:stack]] stringByAppendingFormat:@", %@", result];
    }
    
    return result;
}

- (id)program
{
    return [self.operandStack copy];
}

+ (id)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popElementFromStack:stack];
}


@end
