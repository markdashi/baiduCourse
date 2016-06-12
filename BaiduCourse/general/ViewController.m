//
//  ViewController.m
//  BaiduCourse
//
//  Created by apple on 6/6/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "ViewController.h"
#import "scrollLoopView.h"
#import "AlbuimModel.h"
#import "HomeTableViewCell.h"
#import "courseListModel.h"
#import "focusListModel.h"
#import "scrollLoopView.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)         RGBA(r, g, b, 1.0f)


@interface ViewController ()<scrollLoopViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *recommendArray;
@property (nonatomic, strong) NSMutableArray *focusArray;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, nonnull, strong) NSMutableArray *AlbumArray;
@property (nonatomic, nonnull, strong) UIView *bgView;

@property (nonatomic, strong) scrollLoopView *loopView;
@end

@implementation ViewController


- (NSMutableArray *)recommendArray
{
    if (!_recommendArray){
        _recommendArray = [NSMutableArray array];
    }
    return _recommendArray;
}


- (NSMutableArray *)focusArray
{
    if (!_focusArray){
        _focusArray = [NSMutableArray array];
    }
    return _focusArray;
}
- (NSMutableArray *)AlbumArray
{
    if (!_AlbumArray) {
        _AlbumArray = [NSMutableArray array];
    }
    return _AlbumArray;
}
- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 49 - 64) style:UITableViewStylePlain];
        _mainTableView.rowHeight = 80;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = self.bgView;
    }

    return _mainTableView;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200 + 90)];
        [_bgView addSubview:self.loopView];
        
    }

    return _bgView;
}


- (scrollLoopView *)loopView
{
    if (!_loopView) {
        _loopView = [[scrollLoopView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
        _loopView.delegate = self;
    }
    return _loopView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.mainTableView];
    
    
    __weak typeof(self) weakself = self;
    [HTTPToolRequest GETURLString:@"http://pop.client.chuanke.com/?mod=recommend&act=mobile&client=2&limit=20" parameters:nil sucessBlock:^(id responseObject) {
        
        
        for (NSInteger i = 0; i< [responseObject[@"CourseList"] count]; i++) {
            
            courseListModel *courseList = [courseListModel mj_objectWithKeyValues:responseObject[@"CourseList"][i]];
            [weakself.recommendArray addObject:courseList];
        }
        
        for (NSInteger i = 0; i< [responseObject[@"FocusList"] count]; i++) {
            focusListModel *focusList = [focusListModel mj_objectWithKeyValues:responseObject[@"FocusList"][i]];
            
            [weakself.focusArray addObject:focusList.PhotoURL];
        }
        
        for (NSInteger i = 0; i < [responseObject[@"AlbumList"] count]; i++) {
            AlbuimModel *album = [AlbuimModel mj_objectWithKeyValues:responseObject[@"AlbumList"][i]];
            
            [weakself.AlbumArray addObject:album.PhotoURL];
        }
        
        weakself.loopView.images = weakself.focusArray;
        [self setupAlubm];
        
        [self.mainTableView reloadData];

        
    } failureBlock:^(NSString *error) {
        
    }];
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.recommendArray.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeTableViewCell *cell = [HomeTableViewCell getTableView:tableView];
    cell.courseList = [self.recommendArray objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tapView:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击了第%zd",tap.view.tag);
}

- (void)setupAlubm
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, SCREENWIDTH, 90)];
    scroll.contentSize = CGSizeMake([self.AlbumArray count] *(SCREENWIDTH - 10*2 - 10)/2 , 0);
    for (NSInteger i = 0; i < [self.AlbumArray count] ; i++) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10+i*(SCREENWIDTH - 10*2 - 10)/2, 5, (SCREENWIDTH - 10*2 - 10)/2 - 10, 80)];
        imageView.tag = i ;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:_AlbumArray[i]]];
        [scroll addSubview:imageView];
    }
    [self.bgView addSubview:scroll];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollLoopView:(scrollLoopView *)scrollLoopView didSelectItemAtIndex:(int)index
{
    NSLog(@"点击了 第%d 个",index);
}


@end
