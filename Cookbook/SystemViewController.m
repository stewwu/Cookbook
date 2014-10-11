//
//  SystemViewController.m
//  Cookbook
//
//  Created by Ching on 2014/10/12.
//  Copyright (c) 2014年 Che-Ching Wu. All rights reserved.
//

#import "VersionViewController.h"
#import "ScreenViewController.h"
#import "FontViewController.h"

#import "SystemViewController.h"

@interface SystemViewController ()

@property (nonatomic) NSArray *cells;

@end

@implementation SystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.title = @"System & Device";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.cells = @[@"Version", @"Screen", @"Font"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.cells[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [[NSClassFromString([NSString stringWithFormat:@"%@ViewController", self.cells[indexPath.row]]) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
