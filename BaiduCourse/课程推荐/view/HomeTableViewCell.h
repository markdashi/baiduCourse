//
//  HomeTableViewCell.h
//  BaiduCourse
//
//  Created by apple on 7/6/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>



@class courseListModel;
@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *courseImg;
@property (weak, nonatomic) IBOutlet UILabel *courseName;

@property (weak, nonatomic) IBOutlet UILabel *couseIntro;

@property (nonatomic, strong) courseListModel *courseList;


+ (instancetype)getTableView:(UITableView *)tableView;



@end
