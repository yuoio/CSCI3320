//
//  CalculatorBrain.m
//  hw1Cal
//
//  Created by Wenhan on 2/2/15.
//  Copyright (c) 2015 Wenhan. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;


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

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    }
    else if ([@"*" isEqualToString:operation])
    {
        result = [self popOperand] * [self popOperand];
    }
    else if ([@"-" isEqualToString:operation])
    {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }
    else if ([operation isEqualToString:@"/"])
    {
        double divisor = [self popOperand];
        if (divisor) {
            result = [self popOperand] / divisor;
        }
    }
    
    [self pushOperand:result];
    
    return result;
}

@end
