//
//  MultiLineViewController.h
//  Cookbook
//
//  Created by Ching on 14.10.14.
//  Copyright (c) 2014 Che-Ching Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiLineViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *inputTextField;
@property (nonatomic, weak) IBOutlet UILabel *textLabel;
@property (nonatomic, weak) IBOutlet UILabel *calculatedHeightValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *realHeightValueLabel;

@end
