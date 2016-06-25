//
//  ViewController.m
//  QuestionAnswerView-Demo
//
//  Created by Bharat Jagtap on 09/04/16.
//  Copyright © 2016 Bitcode Technologies. All rights reserved.
//

#import "ViewController.h"
#import "BCQuestionAnswerView.h"
#import "BCQuestion.h"

@interface ViewController () <BCQuestionAnswerViewDelegate >{
    
    NSMutableArray * arrayQuestions ;
    NSInteger currentQuestionIndex ;
}
@property (weak, nonatomic) IBOutlet BCQuestionAnswerView *qaView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupQuestionAnswerView];
    
    
    BCQuestion * q1 = [[BCQuestion alloc] init];
    q1.questionText = @"This is a boolean type question .";
    q1.optionType = OptionsTypeBoolean ;
    q1.firstQuestion = YES;

    
    BCQuestion * q2 = [[BCQuestion alloc] init];
    q2.questionText = @"This is a single select type question . ";
    q2.optionsArray = @[@"One",@"Two",@"Three"];
    q2.optionType = OptionsTypeSingleSelect ;
    
    
    BCQuestion * q3 = [[BCQuestion alloc] init];
    q3.questionText = @"This is a multiple select type question ";
    q3.optionsArray = @[@"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"Eight"];
    q3.optionType = OptionsTypeMultiSelect ;

    
    BCQuestion * q4 = [[BCQuestion alloc] init];
    q4.questionText = @"This is a Text Area type question";
    q4.optionType = OptionsTypeTextArea ;

    
    BCQuestion * q5 = [[BCQuestion alloc] init];
    q5.questionText = @"This is a drop down type question";
    q5.optionsArray = @[@"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"Eight"];
    q5.optionType = OptionsTypeDropDown ;
    q5.lastQuestion = YES;
    
    
    currentQuestionIndex =  0 ;
    self.qaView.delegate = self;
    arrayQuestions = [@[q1,q2,q3,q4,q5] mutableCopy];
    self.qaView.question = q1 ;
    
}

- (void)setupQuestionAnswerView {
    
    
    self.qaView = [[[NSBundle mainBundle] loadNibNamed:@"BCQuestionAnswerView" owner:self options:nil] firstObject];
    self.qaView.translatesAutoresizingMaskIntoConstraints = NO ;
    
    NSLayoutConstraint * cTop = [NSLayoutConstraint constraintWithItem:_qaView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0];
    
    NSLayoutConstraint * cLeading = [NSLayoutConstraint constraintWithItem:_qaView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint * cTrailing = [NSLayoutConstraint constraintWithItem:_qaView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint * cHeight = [NSLayoutConstraint constraintWithItem:_qaView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-20];
    [self.view addSubview:self.qaView];
    
    [self.view addConstraint:cTop];
    [self.view addConstraint:cLeading];
    [self.view addConstraint:cTrailing];
    [self.view addConstraint:cHeight];
    

}

- (void)qustionAnswerViewShowNextQuestionClicked:(BCQuestionAnswerView *)view {
    
    currentQuestionIndex++ ;
    
    if (currentQuestionIndex >= arrayQuestions.count)
    {
        UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"Finished !" message:@"You are on the last question in the quiz" preferredStyle:UIAlertControllerStyleAlert];
        
        [controller addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:NULL]];
        
        [self presentViewController:controller animated:YES completion:NULL];
        
        
        currentQuestionIndex = arrayQuestions.count;
        return;
    }
    else if(currentQuestionIndex <= arrayQuestions.count-1) {
        
        BCQuestion * q = arrayQuestions[currentQuestionIndex];
        self.qaView.question = q ;
    }
}


- (void)qustionAnswerViewShowPreviousQuestionClicked:(BCQuestionAnswerView *)view {
    
    currentQuestionIndex-- ;
    
    if (currentQuestionIndex < 0 ) {
        currentQuestionIndex = 0 ;
        return ;
    }
    else if (currentQuestionIndex >= 0 ) {

        BCQuestion * q = arrayQuestions[currentQuestionIndex];
        self.qaView.question = q ;
    }
    
}

- (void)qustionAnswerView:(BCQuestionAnswerView *)view didChangeToQuestion:(BCQuestion *)question {
    
    
}


@end
