//
//  CatalogTableViewController.h
//  Cookbook
//
//  Created by Ching on 2016/6/23.
//  Copyright © 2016年 Che-Ching Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface CatalogEntry : NSObject
//
//@property (nonatomic, nonnull) NSString *viewControllerName;
//@property (nonatomic, nonnull) NSString *title;
//
//- (instancetype)initWithViewControllerName:(nonnull NSString *)name title:(nonnull NSString *)title;
//
//@end

@interface CatalogTableViewController : UITableViewController

@property (nonatomic) NSArray<NSDictionary<NSString *, NSString *> *> *cells;

@end
