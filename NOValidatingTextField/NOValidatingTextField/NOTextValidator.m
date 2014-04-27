//
//  NOTextValidator.m
//  NOValidatingTextField
//
//  Created by Mike Kavouras on 4/25/14.
//  Copyright (c) 2014 Mike Kavouras. All rights reserved.
//

#import "NOTextValidator.h"

static NSString *NOTextFieldValidatorMaxCharacterCountKey = @"NOTextFieldValidatorMaxCharacterCount";
static NSString *NOTextFieldValidatorMaxWordCountKey = @"NOTextFieldValidatorMaxWordCount";
static NSString *NOTextFieldValidatorMaxCharacterPerWordCountKey = @"NOTextFieldValidatorMaxCharacterPerWordCount";
static NSString *NOTextFieldValidationRuleEmailAddressKey = @"NOTextFieldValidationRuleEmailAddress";

@interface NOTextValidator()

@property (nonatomic, strong) NSMutableDictionary *rules;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) NSInteger wordCount;

@end

@implementation NOTextValidator

- (NSMutableDictionary *)rules
{
    if ( ! _rules) {
        _rules = [[NSMutableDictionary alloc] init];
    }
    return _rules;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.valid = YES;
    }
    return self;
}

- (void)addValidationRule:(NOTextFieldValidationRule)aRule value:(NSInteger)aValue
{
    switch (aRule) {
        case NOTextFieldValidationRuleMaxCharacterCount:
            [self.rules setValue:[NSNumber numberWithInteger:aValue] forKey:NOTextFieldValidatorMaxCharacterCountKey];
            break;
        case NOTextFieldValidationRuleMaxWordCount:
            [self.rules setValue:[NSNumber numberWithInteger:aValue] forKey:NOTextFieldValidatorMaxWordCountKey];
            break;
        case NOTextFieldValidationRuleMaxCharacterPerWordCount:
            [self.rules setValue:[NSNumber numberWithInteger:aValue] forKey:NOTextFieldValidatorMaxCharacterPerWordCountKey];
            break;
        case NOTextFieldValidationRuleEmailAddress:
            [self.rules setValue:[NSNumber numberWithInteger:aValue] forKey:NOTextFieldValidationRuleEmailAddressKey];
            break;
        default:
            break;
    }
}

- (BOOL)validateForText:(NSString *)text
{
    self.text = text;
    self.valid =
        [self validateCharacterCount]
     && [self validateWordCount]
     && [self validateCharacterPerWordCount]
     && [self validateEmailAddress];
    
    return self.valid;
}

- (NSArray *)words
{
    if (self.text.length == 0) {
        return @[];
    }
    
    // replace all excessive white space with " "
    
    NSString *pattern = @"\\W+";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *str = [regex stringByReplacingMatchesInString:self.text options:0 range:NSMakeRange(0, self.text.length) withTemplate:@" "];
    
    
    // remove leading and trailing white space
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    // split on " "
    
    NSArray *words = [str componentsSeparatedByString:@" "];
    
    return words;
}


////////////////////////////////////////////////////////////////////////////////

#pragma mark - Validation

- (BOOL)validateCharacterCount
{
    if ( ! [self.rules valueForKey:NOTextFieldValidatorMaxCharacterCountKey]) {
        return YES;
    }
    
    NSInteger currentCharacterCount = self.text.length;
    NSInteger maxCharacterCount = [[self.rules valueForKey:NOTextFieldValidatorMaxCharacterCountKey] integerValue];
    
    if (currentCharacterCount == maxCharacterCount) {
        if ([self.delegate respondsToSelector:@selector(textFieldDidReachMaximumCharacterCountLimit: characterCount:)]) {
            [self.delegate textFieldDidReachMaximumCharacterCountLimit:nil characterCount:currentCharacterCount];
        }
    }
    else if (currentCharacterCount > maxCharacterCount) {
        if ([self.delegate respondsToSelector:@selector(textFieldDidExceedMaximumCharacterCountLimit: characterCount:)]) {
            [self.delegate textFieldDidExceedMaximumCharacterCountLimit:nil characterCount:currentCharacterCount];
        }
        
        return NO;
    }
    
    return YES;
}

- (BOOL)validateWordCount
{
    if ( ! [self.rules valueForKey:NOTextFieldValidatorMaxWordCountKey]) {
        return YES;
    }
    
    NSInteger currentWordCount = [[self words] count];
    NSInteger maxWordCount = [[self.rules valueForKey:NOTextFieldValidatorMaxWordCountKey] integerValue];
    
    if (currentWordCount == maxWordCount) {
        if ([self.delegate respondsToSelector:@selector(textFieldDidReachMaximumWordCountLimit: wordCount:)]) {
            [self.delegate textFieldDidReachMaximumWordCountLimit:nil wordCount:currentWordCount];
        }
        
        if ([[self.text substringFromIndex:self.text.length -1] isEqualToString:@" "]) {
            if ([self.delegate respondsToSelector:@selector(textFieldDidFinishLastWord: wordCount:)]) {
                [self.delegate textFieldDidFinishLastWord:nil wordCount:currentWordCount];
            }
            
            return NO;
        }
    }
    else if (currentWordCount > maxWordCount) {
        if ([self.delegate respondsToSelector:@selector(textFieldDidExceedMaximumWordCountLimit: wordCount:)]) {
            [self.delegate textFieldDidExceedMaximumWordCountLimit:nil wordCount:currentWordCount];
        }
        
        return NO;
    }
    
    if (currentWordCount > self.wordCount) {
        if ([self.delegate respondsToSelector:@selector(textFieldDidBeginNewWord: wordCount:)]) {
            [self.delegate textFieldDidBeginNewWord:nil wordCount:currentWordCount];
        }
        
        
        if (currentWordCount == maxWordCount) {
            if ([self.delegate respondsToSelector:@selector(textFieldDidBeginLastWord: wordCount:)]) {
                [self.delegate textFieldDidBeginLastWord:nil wordCount:currentWordCount];
            }
        }
    }
    else if (currentWordCount < self.wordCount) {
        if ([self.delegate respondsToSelector:@selector(textFieldDidRemoveWord: wordCount:)]) {
            [self.delegate textFieldDidRemoveWord:nil wordCount:currentWordCount];
        }
    }
    
    self.wordCount = currentWordCount;
    
    return YES;
}

- (BOOL)validateCharacterPerWordCount
{
    if ( ! [self.rules valueForKey:NOTextFieldValidatorMaxCharacterPerWordCountKey]) {
        return YES;
    }
    
    NSInteger maxCharactersPerWord = [[self.rules valueForKey:NOTextFieldValidatorMaxCharacterPerWordCountKey] integerValue];
    
    for (NSString *word in [self words]) {
        NSInteger characterCount = word.length;
        
        if (characterCount == maxCharactersPerWord) {
            if ([self.delegate respondsToSelector:@selector(textFieldDidReachMaximumCharacterPerWordLimit: characterCount:)]) {
                [self.delegate textFieldDidReachMaximumCharacterPerWordLimit:nil characterCount:characterCount];
            }
        }
        else if (characterCount > maxCharactersPerWord) {
            if ([self.delegate respondsToSelector:@selector(textFieldDidExceedMaximumCharacterPerWordLimit: characterCount:)]) {
                [self.delegate textFieldDidExceedMaximumCharacterPerWordLimit:nil characterCount:characterCount];
            }
            return NO;
        }
        
    }
    
    return YES;
}

- (BOOL)validateEmailAddress
{
    if ( ! [self.rules valueForKey:NOTextFieldValidationRuleEmailAddressKey]) {
        return YES;
    }
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self.text];
}

@end
