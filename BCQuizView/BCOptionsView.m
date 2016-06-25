//
//  OptionsView.m
//  QuestionAnswerView-Demo
//
//  Created by Bharat Jagtap on 09/04/16.
//  Copyright © 2016 Bitcode Technologies. All rights reserved.
//

#import "BCOptionsView.h"
#import "BCQuestion.h"






@implementation BCOptionsView

+ (BCOptionsView *)optionsViewForOptionType:(OptionsType)type andQuestion:(BCQuestion*)question  {
    
    if (type == OptionsTypeBoolean) {
        
        BCOptionsView * v = [BCOptionsViewBoolean view];
        v.translatesAutoresizingMaskIntoConstraints = NO;
        return v;
        
    }
    else if (type == OptionsTypeMultiSelect) {
        
        BCOptionsView * v = [BCOptionsViewMultiSelect view];
        v.translatesAutoresizingMaskIntoConstraints = NO;
        return v;
        
    }
    else if (type == OptionsTypeSingleSelect ) {
        
        BCOptionsView * v = [BCOptionsViewSingleSelect view];
        v.translatesAutoresizingMaskIntoConstraints = NO;
        return v;
        
    }
    else if (type == OptionsTypeTextArea ) {
        
        BCOptionsView * v = [BCOptionsViewTextArea view];
        v.translatesAutoresizingMaskIntoConstraints = NO;
        return v;
        
    }
    else if (type == OptionsTypeDropDown ) {
        
        BCOptionsView * v = [BCOptionsViewDropDown view];
        [(BCOptionsViewDropDown*)v ddOptions].items = question.optionsArray;
        v.translatesAutoresizingMaskIntoConstraints = NO;
        return v;
        
    }
    return nil;
}



- (NSArray *)answersArray {
    
    return nil ;
    
}

- (UIImage * )imageForChecked {
    
    return [UIImage imageNamed:imageChecked];
}

- (UIImage * )imageForUnChecked {
 
    return [UIImage imageNamed:imageUnChecked];
}


- (UIImage * )imageForCheckedRadio {
    
    return [UIImage imageNamed:imageCheckedRadio];
}

- (UIImage * )imageForUnCheckedRadio {
    
    return [UIImage imageNamed:imageUnCheckedRadio];
}

@end


@implementation BCOptionsViewBoolean

- (void)awakeFromNib {
    [super awakeFromNib];
    _answer = -1 ;
    [self updateView];
    
}

+ (BCOptionsViewBoolean *)view {
    
    NSArray * array =[[NSBundle mainBundle] loadNibNamed:@"BCOptionsViewBoolean" owner:self options:nil];
    if (array.count) {
        return [array firstObject];
    }
    else {
        return nil ;
    }
}

- (IBAction)yesTapped:(UITapGestureRecognizer *)sender {
    
    _answer = 1 ;
    [self updateView];
}
- (IBAction)noTapped:(UITapGestureRecognizer *)sender {
    
    _answer = 0 ;
    [self updateView];
    
}
- (void)updateView {
    
    if (_answer == 1) {
        
        [self.imgViewYes setImage:[self imageForChecked]];
        [self.imgViewNO setImage:[self imageForUnChecked]];
    }
    else if (_answer == 0 ){
        [self.imgViewYes setImage:[self imageForUnChecked]];
        [self.imgViewNO setImage:[self imageForChecked]];
        
    }
    else {
        
        [self.imgViewYes setImage:[self imageForUnChecked]];
        [self.imgViewNO setImage:[self imageForUnChecked]];

    }
}

- (NSArray *)answersArray {
    
    if(_answer == -1)
        return nil ;
    else {
        
        return @[@(_answer)];
    }
}

@end




@interface BCOptionsViewMultiSelect ()
{
    NSMutableArray * arrayAnswers ;
}
@end


@implementation BCOptionsViewMultiSelect

+ (BCOptionsViewMultiSelect *)view {
    
    NSArray * array =[[NSBundle mainBundle] loadNibNamed:@"BCOptionsViewMultiSelect" owner:self options:nil];
    if (array.count) {
        return [array firstObject];
    }
    else {
        return nil ;
    }

}


- (void)awakeFromNib {
    arrayAnswers = [[NSMutableArray alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.tableView reloadData];
    [self.tableView sizeToFit];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.optionsArray.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.optionsArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    if ([arrayAnswers containsObject:@(indexPath.row)]) {
        cell.imageView.image = [self imageForChecked];
    }
    else {
        cell.imageView.image = [self imageForUnChecked];
    }
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([arrayAnswers containsObject:@(indexPath.row)]) {
        [arrayAnswers removeObject:@(indexPath.row)];
    }
    else {
        [arrayAnswers addObject:@(indexPath.row)];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (CGSize)intrinsicContentSize {
    
    [self.tableView sizeToFit];
    CGSize size = [self.tableView contentSize];
    return size;
}


@end














@interface BCOptionsViewSingleSelect ()
{

    NSNumber * currentSelection ;
    
}
@end


@implementation BCOptionsViewSingleSelect

+ (BCOptionsViewMultiSelect *)view {
    
    NSArray * array =[[NSBundle mainBundle] loadNibNamed:@"BCOptionsViewSingleSelect" owner:self options:nil];
    if (array.count) {
        return [array firstObject];
    }
    else {
        return nil ;
    }
    
}


- (void)awakeFromNib {

    currentSelection = @(-1);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.tableView reloadData];
    [self.tableView sizeToFit];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.optionsArray.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.optionsArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    if ([currentSelection isEqualToNumber:@(indexPath.row)] ) {
        cell.imageView.image = [self imageForCheckedRadio];
    }
    else {
        cell.imageView.image = [self imageForUnCheckedRadio];
    }
    
    
    if (indexPath.row % 2 ) {
        
        [cell setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
    }
    else {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    

    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSNumber * lastSelection = currentSelection ;
    currentSelection = @(indexPath.row) ;
    
    if(lastSelection.intValue >= 0) {
    
        [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:lastSelection.intValue inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (CGSize)intrinsicContentSize {
    
    [self.tableView sizeToFit];
    CGSize size = [self.tableView contentSize];
    return size;
}

@end














@interface BCOptionsViewTextArea ()
{
    UIToolbar * toolbar ;
}
@end

@implementation BCOptionsViewTextArea

+ (BCOptionsViewTextArea *)view {
    
    NSArray * array =[[NSBundle mainBundle] loadNibNamed:@"BCOptionsViewTextArea" owner:self options:nil];
    if (array.count) {
        return [array firstObject];
    }
    else {
        return nil ;
    }
    
}


- (void)awakeFromNib {
    
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth = 2.0 ;
    self.textView.textColor = [UIColor lightGrayColor];
    self.textView.text = @"Enter Answer Here...";
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (toolbar == nil ) {
        toolbar = [[UIToolbar alloc] init];
        toolbar.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44);
        toolbar.tintColor = [UIColor darkGrayColor];
        UIBarButtonItem * doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
        UIBarButtonItem * flexBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        toolbar.items = @[flexBtn , doneBtn];
        
    }
    
    textView.inputAccessoryView = toolbar ;
    return YES;
}

- (void)doneClicked:(id)sender {
    
    [self.textView resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"Enter Answer Here..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    else {
        
        
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@""] || textView.text == nil ) {
        textView.text = @"Enter Answer Here...";
        textView.textColor = [UIColor lightGrayColor];
    }
    else {
        
        
    }
}

@end








@implementation BCOptionsViewDropDown

- (void)awakeFromNib {
    [super awakeFromNib];

}

+ (BCOptionsViewDropDown *)view {
    
    NSArray * array =[[NSBundle mainBundle] loadNibNamed:@"BCOptionsViewDropDown" owner:self options:nil];
    if (array.count) {
        return [array firstObject];
    }
    else {
        return nil ;
    }
    
}





@end






