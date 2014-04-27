//
//  NOViewController.m
//  NOValidatingTextField
//
//  Created by Mike Kavouras on 4/25/14.
//  Copyright (c) 2014 Mike Kavouras. All rights reserved.
//

#import "NOViewController.h"

#import "NOValidatingTextField.h"
#import "NOTextValidator.h"


////////////////////////////////////////////////////////////////////////////////

#pragma mark - Interface


@interface NOViewController ()
<
UITextFieldDelegate,
NOTextValidatorDelegate
>

@property (weak, nonatomic) IBOutlet NOValidatingTextField *textFieldOne;

@property (weak, nonatomic) IBOutlet NOValidatingTextField *textFieldTwo;

@property (weak, nonatomic) IBOutlet NOValidatingTextField *textFieldThree;

@end


////////////////////////////////////////////////////////////////////////////////

#pragma mark - Implementation


@implementation NOViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textFieldOne.delegate = self;
    self.textFieldTwo.delegate = self;
    self.textFieldThree.delegate = self;
    
    [self setValidationRules];
}

- (void)setValidationRules
{
    [self.textFieldOne.validator addValidationRule:NOTextFieldValidationRuleMaxCharacterCount value:24];
    
    [self.textFieldTwo.validator addValidationRule:NOTextFieldValidationRuleMaxWordCount value:3];
    
    [self.textFieldThree.validator addValidationRule:NOTextFieldValidationRuleMaxCharacterPerWordCount value:10];
}


////////////////////////////////////////////////////////////////////////////////

#pragma mark - Delegate - UITextField

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NOValidatingTextField *validatingTextField = (NOValidatingTextField *)textField;
    NSString *potentialString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    return [validatingTextField.validator validateForText:potentialString];
}


@end
