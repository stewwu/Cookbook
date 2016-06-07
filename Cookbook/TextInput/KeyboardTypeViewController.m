//
//  KeyboardTypeViewController.m
//  Cookbook
//
//  Created by Ching on 2016/6/2.
//  Copyright © 2016年 Che-Ching Wu. All rights reserved.
//

#import "KeyboardTypeViewController.h"

@interface KeyboardTypeViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation KeyboardTypeViewController

static NSString *keyboardTypeStrings[] = {@"Default", @"ASCII", @"Numbers And Punctuation", @"URL", @"Number", @"Phone", @"Name Phone", @"Email Address", @"Decimal", @"Twitter", @"Web Search"};

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.textView becomeFirstResponder];
}

#pragma mark - <UIPickerViewDataSource>, <UIPickerViewDelegate>

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return sizeof(keyboardTypeStrings) / sizeof(NSString *);
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return keyboardTypeStrings[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.textView resignFirstResponder];
    self.textView.keyboardType = row;
    [self.textView becomeFirstResponder];
}

@end
