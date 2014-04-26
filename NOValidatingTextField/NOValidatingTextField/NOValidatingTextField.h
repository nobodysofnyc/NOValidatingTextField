//
//  NOValidatingTextField.h
//  NOValidatingTextField
//
//  Created by Mike Kavouras on 4/25/14.
//  Copyright (c) 2014 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NOTextValidatorDelegate.h"

@class NOTextValidator;

@interface NOValidatingTextField : UITextField

@property (nonatomic, strong) id <NOTextValidatorDelegate> validationDelegate;

@property (nonatomic, strong) NOTextValidator *validator;

@end
