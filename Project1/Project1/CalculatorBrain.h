//
//  CalculatorBrain.h
//  Project1
//
//  Created by Wenhan on 2/24/15.
//  Copyright (c) 2015 Wenhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (void)pushOperation:(NSString *)operation;
- (void)clearOperandStack;
- (void)clearTopOfOperandStack;


@property (readonly) id program;

+ (id)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;

@end
