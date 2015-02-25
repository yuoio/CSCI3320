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

+ (id)performOperation:(NSString *)operation withStack:(NSMutableArray *)stack
{
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
        [index setValue:[NSDictionary dictionaryWithObjectsAndKeys:OneOperator, NUMBER_OF_OPERATORS, @"Sqrt(%@)", nil] forKey:@"sqrt"];
        
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


@end
