//
//  NOTextValidator.h
//  NOValidatingTextField
//
//  Created by Mike Kavouras on 4/25/14.
//  Copyright (c) 2014 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NOTextValidatorDelegate.h"

typedef enum {
    NOTextFieldValidationRuleMaxCharacterCount,
    NOTextFieldValidationRuleMaxWordCount,
    NOTextFieldValidationRuleMaxCharacterPerWordCount,
    NOTextFieldValidationRuleEmailAddress
} NOTextFieldValidationRule;

@interface NOTextValidator : NSObject

@property (nonatomic, strong) id <NOTextValidatorDelegate> delegate;

@property (nonatomic, assign, getter = isValid) BOOL valid;

- (void)addValidationRule:(NOTextFieldValidationRule)aRule value:(NSInteger)aValue;

- (BOOL)validateForText:(NSString *)text;

@end
