//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Lion User on 30/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringNumnber;
@property (nonatomic, strong) CalculatorBrain * brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringNumnber = _userIsInTheMiddleOfEnteringNumnber;
@synthesize brain = _brain;

-(CalculatorBrain *) brain
{
    if (_brain == nil)
    {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton * )sender 
{
    NSString * digit = [sender currentTitle];
    NSLog(@"digit pressed = %@ ",digit);
    if (self.userIsInTheMiddleOfEnteringNumnber)
     {
         self.display.text = [self.display.text stringByAppendingString:digit];        
    }
    else 
    {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringNumnber = TRUE;
    }
   
}

- (IBAction)operationPressed:(UIButton *)sender {
    
    if (self.userIsInTheMiddleOfEnteringNumnber)
    {
        [self enterPressed:nil];
    }
    
    double result = [self.brain performOperation:sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g",result];
}

- (IBAction)enterPressed:(id)sender {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringNumnber = NO;
}

- (IBAction)testButtonPressed:(UIButton *)sender {
    CGRect labelRect = CGRectMake(20,20,120,40);
    UILabel * label = [[UILabel alloc] initWithFrame:labelRect];
    label.text = @"Just a test";
    [self.view addSubview:label];
}

@end
