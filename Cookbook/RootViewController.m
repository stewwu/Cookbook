//
//  RootViewController.m
//  Cookbook
//
//  Created by Ching on 2014/8/2.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "CatalogTableViewController.h"
#import "ScrollableViewController.h"
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
                    [self.navigationController pushViewController:[[ScrollableViewController alloc] init] animated:YES];
                    break;
                    
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
//                case 0:
//                    viewController.cells = @[@{@"class": @"LayerAnimationViewController",
//                                               @"description": @"Layer Animation"},
//                                             @{@"class": @"LayerTimingViewController",
//                                               @"description": @"Layer Timing Functions"}];
//                    [self.navigationController pushViewController:viewController animated:YES];
//                    break;
                case 0:
                    viewController.cells = @[@{@"class": @"MultiLineViewController",
                                               @"description": @"Multi-line UILabel layout"},
                                             @{@"class": @"TwoDynamicLabelsViewController",
                                               @"description": @"Two dynamic UILabel layout"}];
                    [self.navigationController pushViewController:viewController animated:YES];
                    break;
                case 1:
                    viewController.cells = @[@{@"class": @"CollectionViewController",
                                               @"description": @"Variable height content"},
                                             @{@"class": @"AnimatedInsertionCollectionViewController",
                                               @"description": @"Animated insertion"}];
                    [self.navigationController pushViewController:viewController animated:YES];
                    break;
                case 2:
                    viewController.cells = @[@{@"class": @"KeyboardTypeViewController",
                                               @"description": @"Keyboard type list"}];
                    [self.navigationController pushViewController:viewController animated:YES];
                    break;
                case 3:
                    [self.navigationController pushViewController:[[ModalTableViewController alloc] init] animated:YES];
                    break;
                case 4:
                    viewController.cells = @[@{@"class": @"CustomizedPresentationViewController",
                                               @"description": @"Customized presentation controller"}];
                    [self.navigationController pushViewController:viewController animated:YES];
                    break;
                case 5:
                    viewController.cells = @[@{@"class": @"WhereAmIViewController",
                                               @"description": @"Where am I"},
//                                             @{@"class": @"ViewController",
//                                               @"description": @"Map by distance"},
//                                             @{@"class": @"ViewController",
//                                               @"description": @"Map by annotations"},
//                                             @{@"class": @"ViewController",
//                                               @"description": @"Map with carrousel"},
//                                             @{@"class": @"ViewController",
//                                               @"description": @"CLGeocoder"},
                                             @{@"class": @"FlipFlopViewController",
                                               @"description": @"Flip between UICollectionView"}];
                    [self.navigationController pushViewController:viewController animated:YES];
                    break;
                case 6:
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
            break;
        default:
            break;
    }
}

@end
