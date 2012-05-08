//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Lion User on 01/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()
@property (nonatomic,strong) NSMutableArray * programStack;

@end

@implementation CalculatorBrain
@synthesize programStack = _programStack;

- (NSMutableArray *) programStack
{
    if(_programStack == nil)
    {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

- (id)program
{
    return [self.programStack copy];
}

+ (NSString *) descriptionOfProgram:(id)program
{
    NSString * result = @"Hello program : (";
    
    for( id topItem in program)
    {
        if ( [topItem isKindOfClass:[NSNumber class]])
        {
            result = [result stringByAppendingFormat:@"%g ",[topItem doubleValue]];
        }
        else if ( [topItem isKindOfClass:[NSString class]])
        {
            result = [result stringByAppendingFormat:@"%@ )(", topItem];
        }
    }
    return result;
    
}
 
+ (double) popOperandOffStack:(NSMutableArray *) stack
{
    double calculateResult = 0;
    id topOfStack = [stack lastObject];
    
    if (topOfStack)//pop the last one
    {
        [stack removeLastObject];
    }
    
    if ( [topOfStack isKindOfClass:[NSNumber class]])
    {
        // if the last one is number , just return it
        calculateResult = [topOfStack doubleValue];
    }
    else if ( [topOfStack isKindOfClass:[NSString class]])
    {
        // if the last one is operation, return the result
        NSString * operation = topOfStack;
        if ([operation isEqualToString:@"+"])
        {
            calculateResult = [self popOperandOffStack:stack] + 
            [self popOperandOffStack:stack];
        }
        else if ([operation isEqualToString:@"*"])
        {
            calculateResult = [self popOperandOffStack:stack] * 
            [self popOperandOffStack:stack];
        }
        else if ([operation isEqualToString:@"-"])
        {
            double subA = [self popOperandOffStack:stack];            
            calculateResult = [self popOperandOffStack:stack] - subA;
        }
        else if ([operation isEqualToString:@"/"])
        {
            double divA = [self popOperandOffStack:stack];
            if (divA)
            {
                calculateResult = [self popOperandOffStack:stack] / divA;
            }
        }
    }    
  
    return calculateResult;

}

+ (double) runProgram:(id)program
{
    NSLog(@": %@",[self descriptionOfProgram:program]);
    
    NSMutableArray * stack = nil;
    if ([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
        
    }
    return [self popOperandOffStack:stack];
}


- (void) pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
    
}

- (double) performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];    
    
    return[CalculatorBrain runProgram:self.program];;
        
}


@end;
