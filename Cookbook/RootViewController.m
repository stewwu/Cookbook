//
//  RootViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/2.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "CatalogTableViewController.h"
#import "ModalTableViewController.h"
#import "CollectionViewController.h"
#import "AnimatedInsertionCollectionViewController.h"
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
    CatalogTableViewController *viewController = [[CatalogTableViewController alloc] init];
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
                    viewController.cells = @[@{@"class": @"MultiLineViewController",
                                               @"description": @"Multi-line UILabel"},
                                             @{@"class": @"TwoDynamicLabelsViewController",
                                               @"description": @"Two dynamic UILabels"}];
                    [self.navigationController pushViewController:viewController animated:YES];
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
                case 1:
                    [self.navigationController pushViewController:[[AnimatedInsertionCollectionViewController alloc] initWithNibName:@"AnimatedInsertionCollectionViewController" bundle:nil] animated:YES];
                    break;
                    
                default:
                    break;
            }
            break;
        case 4:
            switch (indexPath.row) {
                case 0:
                    viewController.cells = @[@{@"class": @"KeyboardTypeViewController",
                                               @"description": @"Keyboard Type List"}];
                    [self.navigationController pushViewController:viewController animated:YES];
                    break;
                case 1:
                    viewController.cells = @[@{@"class": @"CustomizedPresentationViewController",
                                               @"description": @"Customized Presentation Controller"}];
                    [self.navigationController pushViewController:viewController animated:YES];
                    break;

                default:
                    break;
            }
            break;
        case 6:
            switch (indexPath.row) {
                case 5:
                    [self.navigationController pushViewController:[[FlipFlopViewController alloc] init] animated:YES];
                    break;
                    
                default:
                    break;
            }
            break;
        case 7:
            switch (indexPath.row) {
                case 0:
                    viewController.cells = @[@{@"class": @"VersionViewController",
                                               @"description": @"Version"},
                                             @{@"class": @"ScreenViewController",
                                               @"description": @"Screen"},
                                             @{@"class": @"FontViewController",
                                               @"description": @"Font"}];
                    [self.navigationController pushViewController:viewController animated:YES];
                    break;
                    
                default:
                    break;
            }
            
        default:
            break;
    }
}

@end
