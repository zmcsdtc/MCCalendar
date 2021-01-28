//
//  MCCalendarCell.h
//  MCCalendar
//
//  Created by ZMC on 2021/1/28.
//

#import <UIKit/UIKit.h>
#import "MCCalendarDateModel.h"

NS_ASSUME_NONNULL_BEGIN
@class MCCalendarCell;
@protocol MCCalendarCellDelegate <NSObject>

- (void)didSelectMCCalendarCell:(MCCalendarCell*)cell;

@end

@interface MCCalendarCell : UICollectionViewCell

@property (strong,nonatomic) MCCalendarDateModel*model;
@property (weak  ,nonatomic) id<MCCalendarCellDelegate>delegate;

@end


@class MCCalerdarDateButton;

typedef void(^MCCalerdarDateButtonBlock)(MCCalerdarDateButton*btn);

@interface MCCalerdarDateButton : UIButton

@property (strong,nonatomic) UIColor*titleColor;
@property (copy,  nonatomic) MCCalerdarDateButtonBlock block;
@property (copy  ,nonatomic) NSString *title;
@property (strong,nonatomic) UIColor*selectBgColor;

+(instancetype)createMCCalerdarDateButtonFrame:(CGRect)frame title:(NSString*)title clickBlock:(MCCalerdarDateButtonBlock)block;

@end

NS_ASSUME_NONNULL_END
