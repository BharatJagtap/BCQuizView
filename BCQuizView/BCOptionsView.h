//
//  OptionsView.h
//  QuestionAnswerView-Demo
//
//  Created by Bharat Jagtap on 09/04/16.
//  Copyright © 2016 Bitcode Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCQuestion.h"
#import "BCDropDownButton.h"


// These are for the check boxes ( mutiple select )
#define imageChecked @"box_checked"
#define imageUnChecked @"box_unchecked"

// These are for the radio buttons ( single select )
#define imageCheckedRadio @"radio-button-on-icon"
#define imageUnCheckedRadio @"radio-button-off-icon"


@interface BCOptionsView : UIView

@property (nonatomic,strong) NSArray * optionsArray ;
@property (nonatomic) OptionsType optionType ;
@property (nonatomic,readonly) NSArray * answersArray ;

+ (BCOptionsView *)optionsViewForOptionType:(OptionsType)type andQuestion:(BCQuestion*)question ;


@end


@interface BCOptionsViewBoolean : BCOptionsView
@property (nonatomic,weak) IBOutlet UIImageView * imgViewYes ;
@property (nonatomic,weak) IBOutlet UIImageView * imgViewNO ;
@property (nonatomic) int answer ;
+ (BCOptionsViewBoolean *)view ;
@end




@interface BCOptionsViewMultiSelect : BCOptionsView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,weak) IBOutlet UITableView * tableView ;
+ (BCOptionsViewMultiSelect *)view ;
@end



@interface BCOptionsViewSingleSelect : BCOptionsView <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,weak) IBOutlet UITableView * tableView ;
+ (BCOptionsViewSingleSelect *)view ;
@end


@interface BCOptionsViewTextArea : BCOptionsView <UITextViewDelegate>
@property (nonatomic,weak) IBOutlet UITextView * textView ;
+ (BCOptionsViewTextArea *)view ;
@end



@interface BCOptionsViewDropDown : BCOptionsView

+ (BCOptionsViewDropDown *)view ;
@property (nonatomic,weak) IBOutlet BCDropDownButton * ddOptions ;

@end


