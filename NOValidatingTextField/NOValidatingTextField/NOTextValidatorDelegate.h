//
//  NOTextValidatorDelegate.h
//  NOValidatingTextField
//
//  Created by Mike Kavouras on 4/25/14.
//  Copyright (c) 2014 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NOTextValidatorDelegate <NSObject>

@optional

- (void)textFieldDidReachMaximumCharacterCountLimit:(UITextField *)textField characterCount:(NSInteger)aCount;

- (void)textFieldDidExceedMaximumCharacterCountLimit:(UITextField *)textField characterCount:(NSInteger)aCount;


- (void)textFieldDidReachMaximumWordCountLimit:(UITextField *)textField wordCount:(NSInteger)aCount;

- (void)textFieldDidExceedMaximumWordCountLimit:(UITextField *)textField wordCount:(NSInteger)aCount;

- (void)textFieldDidBeginNewWord:(UITextField *)textField wordCount:(NSInteger)aCount;

- (void)textFieldDidRemoveWord:(UITextField *)textField wordCount:(NSInteger)aCount;

- (void)textFieldDidBeginLastWord:(UITextField *)textField wordCount:(NSInteger)aCount;

- (void)textFieldDidFinishLastWord:(UITextField *)textField wordCount:(NSInteger)aCount;


- (void)textFieldDidReachMaximumCharacterPerWordLimit:(UITextField *)textField characterCount:(NSInteger)aCount;

- (void)textFieldDidExceedMaximumCharacterPerWordLimit:(UITextField *)textField characterCount:(NSInteger)aCount;

@end
