//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Lion User on 01/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand:(double)operand;
- (double) performOperation:(NSString *)operation;


//Public API
@property (readonly) id program;

+ (double) runProgram:(id) program;
+ (NSString *) descriptionOfProgram:(id) program;

@end
