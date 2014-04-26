//
//  NOValidatingTextField.m
//  NOValidatingTextField
//
//  Created by Mike Kavouras on 4/25/14.
//  Copyright (c) 2014 Mike Kavouras. All rights reserved.
//

#import "NOValidatingTextField.h"
#import "NOTextValidator.h"


////////////////////////////////////////////////////////////////////////////////

#pragma mark - Interface


@interface NOValidatingTextField() <NOTextValidatorDelegate>

@end


////////////////////////////////////////////////////////////////////////////////

#pragma mark - Implementation


@implementation NOValidatingTextField


////////////////////////////////////////////////////////////////////////////////

#pragma mark - Lazy load


- (NOTextValidator *)validator
{
    if ( ! _validator) {
        _validator = [[NOTextValidator alloc] init];
        _validator.delegate = self;
    }
    return  _validator;
}


////////////////////////////////////////////////////////////////////////////////

#pragma mark - Lifecycle


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


////////////////////////////////////////////////////////////////////////////////

#pragma mark - Setup


- (void)setup
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (textFieldDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self];
}


////////////////////////////////////////////////////////////////////////////////

#pragma mark - Notifications


- (void)textFieldDidChange:(NSNotification *)notification
{
    UITextField *textField = (UITextField *)notification.object;
    NSString *text = textField.text;
    [self.validator validateForText:text];
}


////////////////////////////////////////////////////////////////////////////////

#pragma mark - Delegate - SEETextFieldValidation


- (void)textFieldDidReachMaximumCharacterCountLimit:(UITextField *)textField characterCount:(NSInteger)aCount
{
    if ([self.validationDelegate respondsToSelector:@selector(textFieldDidReachMaximumCharacterCountLimit: characterCount:)]) {
        [self.validationDelegate textFieldDidReachMaximumCharacterCountLimit:self characterCount:aCount];
    }
}

- (void)textFieldDidExceedMaximumCharacterCountLimit:(UITextField *)textField characterCount:(NSInteger)aCount
{
    if ([self.validationDelegate respondsToSelector:@selector(textFieldDidExceedMaximumCharacterCountLimit: characterCount:)]) {
        [self.validationDelegate textFieldDidExceedMaximumCharacterCountLimit:self characterCount:aCount];
    }
}

- (void)textFieldDidReachMaximumWordCountLimit:(UITextField *)textField wordCount:(NSInteger)aCount
{
    if ([self.validationDelegate respondsToSelector:@selector(textFieldDidReachMaximumWordCountLimit: wordCount:)]) {
        [self.validationDelegate textFieldDidReachMaximumWordCountLimit:self wordCount:aCount];
    }
}

- (void)textFieldDidExceedMaximumWordCountLimit:(UITextField *)textField wordCount:(NSInteger)aCount
{
    if ([self.validationDelegate respondsToSelector:@selector(textFieldDidExceedMaximumWordCountLimit: wordCount:)]) {
        [self.validationDelegate textFieldDidExceedMaximumWordCountLimit:self wordCount:aCount];
    }
}

- (void)textFieldDidBeginNewWord:(UITextField *)textField wordCount:(NSInteger)aCount
{
    if ([self.validationDelegate respondsToSelector:@selector(textFieldDidBeginNewWord: wordCount:)]) {
        [self.validationDelegate textFieldDidBeginNewWord:self wordCount:aCount];
    }
}

- (void)textFieldDidRemoveWord:(UITextField *)textField wordCount:(NSInteger)aCount
{
    if ([self.validationDelegate respondsToSelector:@selector(textFieldDidRemoveWord: wordCount:)]) {
        [self.validationDelegate textFieldDidRemoveWord:self wordCount:aCount];
    }
}

- (void)textFieldDidBeginLastWord:(UITextField *)textField wordCount:(NSInteger)aCount
{
    if ([self.validationDelegate respondsToSelector:@selector(textFieldDidBeginLastWord: wordCount:)]) {
        [self.validationDelegate textFieldDidBeginLastWord:self wordCount:aCount];
    }
}

- (void)textFieldDidFinishLastWord:(UITextField *)textField wordCount:(NSInteger)aCount
{
    if ([self.validationDelegate respondsToSelector:@selector(textFieldDidFinishLastWord: wordCount:)]) {
        [self.validationDelegate textFieldDidFinishLastWord:self wordCount:aCount];
    }
}

- (void)textFieldDidReachMaximumCharacterPerWordLimit:(UITextField *)textField characterCount:(NSInteger)aCount
{
    if ([self.validationDelegate respondsToSelector:@selector(textFieldDidReachMaximumCharacterPerWordLimit: characterCount:)]) {
        [self.validationDelegate textFieldDidReachMaximumCharacterPerWordLimit:self characterCount:aCount];
    }
}

- (void)textFieldDidExceedMaximumCharacterPerWordLimit:(UITextField *)textField characterCount:(NSInteger)aCount
{
    if ([self.validationDelegate respondsToSelector:@selector(textFieldDidExceedMaximumCharacterPerWordLimit: characterCount:)]) {
        [self.validationDelegate textFieldDidExceedMaximumCharacterPerWordLimit:self characterCount:aCount];
    }
}


@end
