//
//  RootViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/2.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "FlipFlopViewController.h"

#import "RootViewController.h"

@interface RootViewController () <UITableViewDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 4:
            switch (indexPath.row) {
                case 5:
                {
                    FlipFlopViewController *flipFlopViewController = [[FlipFlopViewController alloc] init];
                    [self.navigationController pushViewController:flipFlopViewController animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
}

@end
