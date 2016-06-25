//
//  BCQuestion.m
//  QuestionAnswerView-Demo
//
//  Created by Bharat Jagtap on 09/04/16.
//  Copyright © 2016 Bitcode Technologies. All rights reserved.
//

#import "BCQuestion.h"

@implementation BCOption

+ (BCOption *)optionWithId:(NSString*)optionID andText:(NSString*)optionText  {
    BCOption * opt = [[BCOption alloc] init];
    opt.optionId = optionID ;
    opt.optionText = optionText;
    return opt;
}

@end

@implementation BCQuestion
@end
