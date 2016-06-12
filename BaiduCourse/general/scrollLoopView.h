//
//  scrollLoopView.h
//  BaiduCourse
//
//  Created by apple on 6/6/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>


@class scrollLoopView;
@protocol scrollLoopViewDelegate <NSObject>

@optional

- (void)scrollLoopView:(scrollLoopView *)scrollLoopView didSelectItemAtIndex:(int)index;


@end

@class scrollLoopViewDelegate;
@interface scrollLoopView : UIView


@property (nonatomic, strong) NSArray *images;
@property (nonatomic, weak) id<scrollLoopViewDelegate>delegate;


@end
