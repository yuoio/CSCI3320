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

- (void)updateHistory
{
    self.history.text = [CalculatorBrain descriptionOfProgram:self.brain.program];
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
    
    [self updateDisplay:digit status:userIsInTheMiddleOfEnteringANumber];
    self.userIsInTheMiddleOfEnteringANumber = YES;

}
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(id)sender {
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    [self.brain pushOperation:[sender currentTitle]];
    [self runProgram];
    //self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (void)runProgram
{
  id result = [CalculatorBrain runProgram:self.brain.program];

  if ([result isKindOfClass:[NSNumber class]]) {
  [self updateDisplay:[NSString stringWithFormat:@"%@", result]];
  [self updateHistory];
}
}
@end
