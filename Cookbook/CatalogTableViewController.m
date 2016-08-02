//
//  CatalogTableViewController.m
//  Cookbook
//
//  Created by Ching on 2016/6/23.
//  Copyright © 2016年 Che-Ching Wu. All rights reserved.
//

#import "CatalogTableViewController.h"

//@implementation CatalogEntry
//
//- (instancetype)initWithViewControllerName:(nonnull NSString *)name title:(nonnull NSString *)title {
//    if (self = [super init]) {
//        self.viewControllerName = name;
//        self.title = title;
//    }
//    return self;
//}
//
//@end


@interface CatalogTableViewController ()

@end

@implementation CatalogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.text = self.cells[indexPath.row][@"description"];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UIViewController *viewController = [(UIViewController *)[NSClassFromString(self.cells[indexPath.row][@"class"]) alloc] initWithNibName:self.cells[indexPath.row][@"class"] bundle:nil];
    UIViewController *viewController = [[NSClassFromString(self.cells[indexPath.row][@"class"]) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
