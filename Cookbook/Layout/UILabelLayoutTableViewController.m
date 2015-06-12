//
//  LayoutTableViewController.m
//  Cookbook
//
//  Created by Ching on 2015/6/12.
//  Copyright (c) 2015年 Che-Ching Wu. All rights reserved.
//

#import "MultiLineViewController.h"
#import "TwoDynamicLabelsViewController.h"

#import "UILabelLayoutTableViewController.h"

@interface UILabelLayoutTableViewController ()

@end

@implementation UILabelLayoutTableViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Multi-line UILabel";
            break;
        case 1:
            cell.textLabel.text = @"Two dynamic UILabels";
            break;

        default:
            break;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController;

    switch (indexPath.row) {
        case 0:
            viewController = [[MultiLineViewController alloc] init];
            break;

        default:
            viewController = [[TwoDynamicLabelsViewController alloc] init];
            break;
    }

    [self.navigationController pushViewController:viewController animated:YES];
}

@end
