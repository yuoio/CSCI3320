//
//  CalculatorBrain.h
//  hw1Cal
//
//  Created by Wenhan on 2/2/15.
//  Copyright (c) 2015 Wenhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;


@end
