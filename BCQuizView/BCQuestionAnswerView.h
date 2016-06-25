//
//  QuestionAnswerView.h
//  QuestionAnswerView-Demo
//
//  Created by Bharat Jagtap on 09/04/16.
//  Copyright © 2016 Bitcode Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCQuestion.h"

@class BCQuestionAnswerView;

@protocol BCQuestionAnswerViewDelegate <NSObject>

@optional
- (void)qustionAnswerViewShowNextQuestionClicked:(BCQuestionAnswerView*)view;
- (void)qustionAnswerViewShowPreviousQuestionClicked:(BCQuestionAnswerView*)view;
- (void)qustionAnswerView:(BCQuestionAnswerView*)view didChangeToQuestion:(BCQuestion *)question ;


@end

@interface BCQuestionAnswerView : UIView
@property (nonatomic,strong) BCQuestion * question ;
@property (nonatomic,weak) id<BCQuestionAnswerViewDelegate> delegate ;
@end
