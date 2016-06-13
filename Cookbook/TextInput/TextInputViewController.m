//
//  TextInputViewController.m
//  Cookbook
//
//  Created by Ching on 2016/6/7.
//  Copyright © 2016年 Che-Ching Wu. All rights reserved.
//

#import "TextInputViewController.h"

@interface TextInputViewController ()

@property (nonatomic) NSArray *cells;

@end

@implementation TextInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

    self.cells = @[@[@"Keyboard Type List", @"KeyboardTypeViewController"],
                   @[@"Input View above Keyboard", @"FloatingTextInputViewController"]];
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
