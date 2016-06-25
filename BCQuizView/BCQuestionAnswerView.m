//
//  QuestionAnswerView.m
//  QuestionAnswerView-Demo
//
//  Created by Bharat Jagtap on 09/04/16.
//  Copyright © 2016 Bitcode Technologies. All rights reserved.
//

#import "BCQuestionAnswerView.h"
#import "BCOptionsView.h"


@interface BCQuestionAnswerView ()
{
    BCOptionsView * optionsView ;
}

@property (nonatomic,weak) IBOutlet UIButton * btnNext ;
@property (nonatomic,weak) IBOutlet UIButton * btnPrevious ;
@property (nonatomic,weak) IBOutlet UIView * optionsContainerView  ;
@property (nonatomic,weak) IBOutlet UILabel * lblQuestionText  ;


@end
@implementation BCQuestionAnswerView

- (void)awakeFromNib {
    
   // self = [[[NSBundle mainBundle] loadNibNamed:@"QuestionAnswerView" owner:self options:nil] firstObject];

    [super awakeFromNib];
    
    [self addObserver:self forKeyPath:@"question" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    NSLog(@"observer call back");
    
    if ([keyPath isEqualToString:@"question"]) {

        if(self.question) {
            [self updateView];
        }
    }
}

- (void)updateView {
    
    self.alpha = 0.0 ;

    [UIView animateWithDuration:0.4 animations:^{
        
        self.alpha = 1.0 ;

        self.lblQuestionText.text = self.question.questionText ;
        if (optionsView) {
            [optionsView removeFromSuperview];
            optionsView = nil ;
        }
        
        optionsView = [BCOptionsView optionsViewForOptionType:self.question.optionType andQuestion:self.question];
        
        optionsView.optionsArray = self.question.optionsArray;
        optionsView.translatesAutoresizingMaskIntoConstraints = NO ;
        
        NSLayoutConstraint * cTop = [NSLayoutConstraint constraintWithItem:optionsView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.optionsContainerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
        NSLayoutConstraint * cLeft = [NSLayoutConstraint constraintWithItem:optionsView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.optionsContainerView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
        NSLayoutConstraint * cRight = [NSLayoutConstraint constraintWithItem:optionsView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.optionsContainerView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
        NSLayoutConstraint * cBottom = [NSLayoutConstraint constraintWithItem:self.optionsContainerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:optionsView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        
        [self.optionsContainerView addSubview:optionsView];
        [self.optionsContainerView addConstraint:cTop];
        [self.optionsContainerView addConstraint:cLeft];
        [self.optionsContainerView addConstraint:cRight];
        [self.optionsContainerView addConstraint:cBottom];
        
        [optionsView setNeedsUpdateConstraints];
        [optionsView setNeedsLayout];
        
        [self.optionsContainerView setNeedsUpdateConstraints];
        [self.optionsContainerView setNeedsLayout];
        
        if (self.question.firstQuestion) {
            self.btnPrevious.enabled = NO ;
            self.btnNext.enabled = YES ;
            [self.btnNext setTitle:@"NEXT" forState:UIControlStateNormal];
        }
        else if (self.question.lastQuestion) {
            self.btnPrevious.enabled = YES ;
            self.btnNext.enabled = YES ;
            [self.btnNext setTitle:@"FINISH" forState:UIControlStateNormal];
        }
        else {
            
            self.btnPrevious.enabled = YES ;
            self.btnNext.enabled = YES ;
            [self.btnNext setTitle:@"NEXT" forState:UIControlStateNormal];
        }
    }
     completion:^(BOOL finished) {
         
         
         if([self.delegate respondsToSelector:@selector(qustionAnswerView:didChangeToQuestion:)]) {
             
             [self.delegate qustionAnswerView:self didChangeToQuestion:self.question];
         }
     }];
    
}


- (IBAction)showNext:(id)sender {
    
    
    if( [self.delegate respondsToSelector:@selector(qustionAnswerViewShowNextQuestionClicked:)] ){
        
        [self.delegate qustionAnswerViewShowNextQuestionClicked:self];
    }
   
}

- (IBAction)showPrevious:(id)sender {
    
    if( [self.delegate respondsToSelector:@selector(qustionAnswerViewShowPreviousQuestionClicked:)] ){
        
        [self.delegate qustionAnswerViewShowPreviousQuestionClicked:self];
    }
    
    
}





@end
