//
//  BCQuestion.h
//  QuestionAnswerView-Demo
//
//  Created by Bharat Jagtap on 09/04/16.
//  Copyright © 2016 Bitcode Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    OptionsTypeUnknown = 0 ,
    OptionsTypeBoolean ,
    OptionsTypeSingleSelect ,
    OptionsTypeMultiSelect ,
    OptionsTypeTextArea ,
    OptionsTypeDropDown 
    
} OptionsType ;


@interface BCOption : NSObject
@property (nonatomic,strong) NSString * optionId ;
@property (nonatomic,strong) NSString * optionText ;
+ (BCOption *)optionWithId:(NSString*)optionID andText:(NSString*)optionText ;
@end



@interface BCQuestion : NSObject

@property (nonatomic,strong) NSString * questionId ;
@property (nonatomic,strong) NSString * questionText ;
@property (nonatomic) OptionsType optionType ;
@property (nonatomic,strong) NSArray<BCOption *> * optionsArray;
@property (nonatomic,strong) NSArray<BCOption *> * rightOptionsArray ;
@property (nonatomic,strong) NSArray<BCOption *> * userAnswersArray  ;
@property (nonatomic) BOOL firstQuestion ;
@property (nonatomic) BOOL lastQuestion ;

@end
