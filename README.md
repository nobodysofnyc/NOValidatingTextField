NOValidatingTextField
=====================

A self validating UITextField

```

NOValidatingTextField *textfield = [[NOValidatingTextField alloc] init];

[textfield.validator addValidationRule:NOTextFieldValidationRuleMaxCharacterCount value:24];
[textfield.validator addValidationRule:NOTextFieldValidationRuleMaxWordCount value:3];
[textfield.validator addValidationRule:NOTextFieldValidationRuleMaxCharacterPerWordCount value:10];

```
