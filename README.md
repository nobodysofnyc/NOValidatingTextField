NOValidatingTextField
=====================

A self validating UITextField

NOValidatingTextField inherits from UITextField. Each instance has an associated text validator.

```

NOValidatingTextField *textfield = [[NOValidatingTextField alloc] init];

[textfield.validator addValidationRule:NOTextFieldValidationRuleMaxCharacterCount value:24];
[textfield.validator addValidationRule:NOTextFieldValidationRuleMaxWordCount value:3];
[textfield.validator addValidationRule:NOTextFieldValidationRuleMaxCharacterPerWordCount value:10];

```

Instances of NOTextValidator can also be used on their own.

```

NSString *thisisanunnecessarilylongstring;

NOTextValidator *validator = [[NoTextValidator alloc] init];
BOOL isValid = [validator addValidationRule:NOTextFieldValidationRuleMaxCharacterCount value:10]; 
NSLog(isValid ? @"yes" : @"no"); // => NO

```



