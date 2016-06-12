//
//  HomeTableViewCell.m
//  BaiduCourse
//
//  Created by apple on 7/6/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "courseListModel.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setCourseList:(courseListModel *)courseList
{
    _courseList = courseList;
    [self.courseImg sd_setImageWithURL:[NSURL URLWithString:courseList.PhotoURL]];
    self.courseName.text = courseList.CourseName;
    self.couseIntro.text = courseList.Brief;
}




+ (instancetype)getTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:@"homecell"];
    return [tableView dequeueReusableCellWithIdentifier:@"homecell"];
}

@end
