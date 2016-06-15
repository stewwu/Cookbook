//
//  TransitioningTableViewController.m
//  Cookbook
//
//  Created by Ching on 2016/6/14.
//  Copyright © 2016年 Che-Ching Wu. All rights reserved.
//

#import "TransitioningTableViewController.h"

@interface TransitioningTableViewController ()

@property (nonatomic) NSArray *cells;

@end

@implementation TransitioningTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

    self.cells = @[@[@"Customized Presentation Controller", @"CustomizedPresentationViewController"]];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.cells[indexPath.row][0];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [[NSClassFromString(self.cells[indexPath.row][1]) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
