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
@property (nonatomic) BOOL isPositive;
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

- (IBAction)clearAll:(id)sender {
    
    [self.brain clearOperandStack];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self updateDisplay:@"0"];
    [self updateHistory];
}

- (IBAction)clearLast:(id)sender {
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self updateDisplay:[self.display.text substringToIndex:[self.display.text length] - 1]];
        if ([self.display.text isEqual:@""]) {
            [self updateDisplay:@"0"];
            self.userIsInTheMiddleOfEnteringANumber = NO;
        }
    }
    else
    {
        [self.brain clearOperandStack];
        [self runProgram];
    }
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
    [self updateHistory];
}

- (IBAction)operationPressed:(id)sender {
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    [self.brain pushOperation:[sender currentTitle]];
    [self runProgram];
    
}

- (void)runProgram
{
  id result = [CalculatorBrain runProgram:self.brain.program];

  if ([result isKindOfClass:[NSNumber class]]) {
  [self updateDisplay:[NSString stringWithFormat:@"%@", result]];
  [self updateHistory];
  } else if ([result isKindOfClass:[NSString class]]) {
      [self.brain clearTopOfOperandStack];
      self.history.text = result;
  }
}
@end
