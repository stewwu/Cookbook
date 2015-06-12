//
//  RootViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/2.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "ModalTableViewController.h"
#import "UILabelLayoutTableViewController.h"
#import "CollectionViewController.h"
#import "FlipFlopViewController.h"
#import "SystemViewController.h"

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
        case 0:
            switch (indexPath.row) {
                case 1:
                    [self.navigationController pushViewController:[[ModalTableViewController alloc] init] animated:YES];
                    break;
                    
                default:
                    break;
            }
        case 2:
            switch (indexPath.row) {
                case 0:
                    [self.navigationController pushViewController:[[UILabelLayoutTableViewController alloc] init] animated:YES];
                    break;
                    
                default:
                    break;
            }
            break;
        case 3:
            switch (indexPath.row) {
                case 0:
                    [self.navigationController pushViewController:[[CollectionViewController alloc] initWithNibName:@"CollectionViewController" bundle:nil] animated:YES];
                    break;
                    
                default:
                    break;
            }
            break;
        case 5:
            switch (indexPath.row) {
                case 5:
                    [self.navigationController pushViewController:[[FlipFlopViewController alloc] init] animated:YES];
                    break;
                    
                default:
                    break;
            }
            break;
        case 6:
            switch (indexPath.row) {
                case 0:
                    [self.navigationController pushViewController:[[SystemViewController alloc] init] animated:YES];
                    break;
                    
                default:
                    break;
            }
            
        default:
            break;
    }
}

@end
