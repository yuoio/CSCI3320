//
//  ViewController.m
//  Project1
//
//  Created by Wenhan on 2/24/15.
//  Copyright (c) 2015 Wenhan. All rights reserved.
//


#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation ViewController
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize display;
@synthesize history;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (void)updateDisplay:(NSString *)text
{
    [self updateDisplay:text status:NO];
}

- (void)updateDisplay:(NSString *)text status:(BOOL)status
{
    if (status)
        self.display.text = [self.display.text stringByAppendingString:text];
    else
        self.display.text = text;
}

- (IBAction)digitPressed:(UIButton *)sender {
    
    NSString *digit = [sender currentTitle];
    
    // Detecting if the point is first pressed or not.
    
    if ([digit isEqualToString:@"."]) {
        BOOL pointPressed = ([self.display.text rangeOfString:@"."].location != NSNotFound);
        if (self.userIsInTheMiddleOfEnteringANumber && pointPressed ) {
            return;
        }
    }
    
    self.userIsInTheMiddleOfEnteringANumber = YES;
    [self updateDisplay:digit status:userIsInTheMiddleOfEnteringANumber];
}
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(id)sender {
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    //self.display.text = [NSString stringWithFormat:@"%g", result];
}

@end
