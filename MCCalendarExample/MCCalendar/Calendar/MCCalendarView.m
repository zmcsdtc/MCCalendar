//
//  MCCalendarView.m
//  MCCalendar
//
//  Created by ZMC on 2021/1/28.
//

#import "MCCalendarView.h"
#import "UIView+Extension.h"

@interface MCCalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource,MCCalendarCellDelegate>

@property (strong,nonatomic) UICollectionView*collectView;
@property (strong,nonatomic) MCCalendarDateHeaderView*headerview;

//data
@property (strong,nonatomic) NSMutableArray*dateArray;
@property (strong,nonatomic) NSDate*date;
@property (strong,nonatomic) NSDate*selectDate;

//other
//@property (strong,nonatomic) 

@end

@implementation MCCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.date = [NSDate date];
        [self setupSubviews];
        [self addGestureRecognizers];
    }
    return self;
}

- (void)setupSubviews {
    
    self.headerview = [MCCalendarDateHeaderView createMCCalendarDateHeaderViewChangeMonthBlock:^(ChangeMonth changeMonth) {
        if (changeMonth == ChangeMonthLast) {
            [self gotoLast];
        }
        else {
            [self gotoNext];
        }
    }];
    [self addSubview: self.headerview];
    
    MCCalendarWeekView*mv = [MCCalendarWeekView createWeekView];
    mv.mc_y = self.headerview.mc_height;
    [self addSubview:mv];
    [self addSubview:self.collectView];
    
    self.mc_height = self.collectView.mc_maxY;
    [self reloadDate];
}

- (void)addGestureRecognizers {
    UISwipeGestureRecognizer*panright = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoLast)];
    panright.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.collectView addGestureRecognizer:panright];
    
    UISwipeGestureRecognizer*panleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoNext)];
    panleft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.collectView addGestureRecognizer:panleft];
    
}

#pragma mark - 翻页

- (void)gotoNext {
    [self performAnimations:kCATransitionFromRight];
    self.date = [self.date nextMonth];
    [self reloadDate];
}

- (void)gotoLast {
    [self performAnimations:kCATransitionFromLeft];
    self.date = [self.date lastMonth];
    [self reloadDate];
}

#pragma mark - Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dateArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MCCalendarCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MCCalendarCellID" forIndexPath:indexPath];
    cell.model = self.dateArray[indexPath.item];
    cell.delegate = self;
    return cell;
}

- (void)reloadDate {
    [self getDateData];
    self.headerview.date = self.date;
    [self.collectView reloadData];
}

- (void)getDateData {
    self.dateArray = [NSMutableArray array];
    for (int i = 0; i < 42; i++) {
        MCCalendarDateModel*model = [[MCCalendarDateModel alloc] init];
        NSInteger monthTotalDays = [self.date totaldaysInThisMonth];
        NSInteger firstDayInthisMonth = [self.date firstWeekdayInThisMonth];
        //当月
        if (i >= firstDayInthisMonth&&i < monthTotalDays+firstDayInthisMonth) {
            model.isCurrentMonth = YES;
            model.dateDay = 1 + (i - firstDayInthisMonth);
            
            if ((i == self.date.day + firstDayInthisMonth-1)&&(self.date.month == [NSDate date].month)) {
                model.isToday = YES;
            }
            else {
                model.isToday = NO;
            }
            NSString*dateStr = [NSString stringWithFormat:@"%zd-%zd-%zd",self.date.year,self.date.month,model.dateDay];
            model.date = [NSDate dateFromString:dateStr format:@"yyyy-M-d"];
            
           
        }
        //下月
        else if (i >= monthTotalDays+firstDayInthisMonth) {
            NSDate*nextDate = [self.date nextMonth];
            model.dateDay = i - monthTotalDays - firstDayInthisMonth + 1;
            NSString*dateStr = [NSString stringWithFormat:@"%zd-%zd-%zd",nextDate.year,nextDate.month,model.dateDay];
            model.date = [NSDate dateFromString:dateStr format:@"yyyy-M-d"];
        }
        //上个月
        else {
            NSDate*lastDate = [self.date lastMonth];
            NSInteger thisMonthDays = [lastDate totaldaysInThisMonth];
            model.dateDay = thisMonthDays - firstDayInthisMonth + i +1;
            NSString*dateStr = [NSString stringWithFormat:@"%zd-%zd-%zd",lastDate.year,lastDate.month,model.dateDay];
            model.date = [NSDate dateFromString:dateStr format:@"yyyy-M-d"];
        }
        
        [self.dateArray addObject:model];
    }
    [self.dateArray enumerateObjectsUsingBlock:^(MCCalendarDateModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([self.selectDate isSameDayWithDate:obj.date]) {
            obj.isSelectDate = YES;
        }
    }];
}

- (void)didSelectMCCalendarCell:(MCCalendarCell *)cell {

    NSString*dateStr = [NSString stringWithFormat:@"%zd-%zd-%zd",self.date.year,self.date.month,cell.model.dateDay];
    NSLog(@"dateStr = %@",dateStr);
   self.selectDate = [NSDate dateFromString:dateStr format:@"yyyy-M-d"];
    [self reloadDate];
    
}

#pragma mark - animation

- (void)performAnimations:(NSString *)transition{
    CATransition *catransition = [CATransition animation];
    catransition.duration = 0.5;
    [catransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    catransition.type = kCATransitionPush; //choose your animation
    catransition.subtype = transition;
    [self.collectView.layer addAnimation:catransition forKey:nil];
}


#pragma mark - Lazy init

- (UICollectionView *)collectView {
    if (!_collectView) {
        UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        layout.itemSize = CGSizeMake(kWindowWidth/7.0, kWindowWidth/7.0);
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44+40, kWindowWidth, 6.0*kWindowWidth/7.0) collectionViewLayout:layout];
        _collectView.backgroundColor = [UIColor whiteColor];
        [_collectView registerClass:[MCCalendarCell class] forCellWithReuseIdentifier:@"MCCalendarCellID"];
        _collectView.delegate = self;
        _collectView.dataSource = self;
    }
    return _collectView;
}


@end
