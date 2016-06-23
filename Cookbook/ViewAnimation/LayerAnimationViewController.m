//
//  LayerAnimationViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/8.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "LayerAnimationViewController.h"

@interface LayerAnimationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UIView *square;
@property (nonatomic) IBOutlet UITableView *animationTypePicker;
@property (nonatomic) NSArray *animationKeys;

@end

@implementation LayerAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.animationKeys = @[@"byValue", @"toValue", @"mantain final state at end of animation", @"autoreverses", @"cornerRadius", @"transform.translation", @"transform.rotation"];
    
    self.animationTypePicker.dataSource = self;
    self.animationTypePicker.delegate = self;
}

- (void)dealloc
{
    self.animationTypePicker.delegate = nil;
    self.animationTypePicker.dataSource = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.animationKeys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.animationKeys[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CABasicAnimation *animation;
    
    // NOTE: CALayer Animatable Properties - https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html#//apple_ref/doc/uid/TP40004514-CH11-SW1
    // NOTE: Setting Interpolation Values - https://developer.apple.com/library/mac/documentation/graphicsimaging/reference/CABasicAnimation_class/Introduction/Introduction.html#//apple_ref/doc/uid/TP40004496-CH1-SW4
    if ([self.animationKeys[indexPath.row] isEqualToString:@"byValue"]) {
        animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        animation.byValue = @(10.0f);
    } else if ([self.animationKeys[indexPath.row] isEqualToString:@"toValue"]) {
        animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        animation.toValue = @(self.square.layer.position.x + 10.0f);
    } else if ([self.animationKeys[indexPath.row] isEqualToString:@"mantain final state at end of animation"]) {
        animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        animation.fromValue = @(self.square.layer.position.x);
        animation.byValue = @(10.0f);
        self.square.layer.position = CGPointMake(self.square.layer.position.x + 10.0f, self.square.layer.position.y);
    } else if ([self.animationKeys[indexPath.row] isEqualToString:@"autoreverses"]) {
        animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.square.layer.position.x + 20.0f, self.square.layer.position.y + 20.0f)];
        animation.autoreverses = YES;
    } else if ([self.animationKeys[indexPath.row] isEqualToString:@"cornerRadius"]) {
        animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        animation.byValue = @(20.0f);
    } else if ([self.animationKeys[indexPath.row] isEqualToString:@"transform.translation"]) {
        animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, 0.0f, 0.0f)];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(10.0f, 0.0f, 0.0f)];
        self.square.layer.transform = CATransform3DMakeTranslation(10.0f, 0.0f, 0.0f);
    } else if ([self.animationKeys[indexPath.row] isEqualToString:@"transform.rotation"]) {
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];;
        animation.toValue = @(45.0f * M_PI);
    }

    animation.duration = 1.0f;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.square.layer addAnimation:animation forKey:nil];
}

@end
