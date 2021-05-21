//
//  LDDiaryEditorView.m
//  LukeDiary
//
//  Created by ziv yuan on 14-7-26.
//  Copyright (c) 2014年 gem design. All rights reserved.
//

#import "LDDiaryEditorView.h"

@interface LDDiaryEditorView ()

@property(nonatomic, strong) IBOutlet UILabel      * contentFieldPlaceholder;
@property(nonatomic, strong)          UIResponder  * activeInput;
@end

@implementation LDDiaryEditorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)initial
{
	CGAffineTransform trans = CGAffineTransformMakeScale(1, 1.04);
	self.titleField.transform = trans;
	self.titleField.delegate = self;
	self.contentField.transform = trans;
	self.contentField.delegate = self;
	self.contentField.text = @"";
	self.contentField.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
	self.commentField.transform = trans;
	self.commentField.delegate = self;
}

-(BOOL)isValidate
{
	if (self.titleField.text.length == 0) {
		return NO;
	}
	if (self.contentField.text.length == 0) {
		return NO;
	}
	
	return YES;
}
-(NSString *)validateInputs
{
	if (self.titleField.text.length == 0) {
		return @"请输入日记主题.";
	}
	if (self.contentField.text.length == 0) {
		return @"请输入日记内容.";
	}
	return nil;
}

-(UIImage *)getImage
{
	if (![self.commentField hasText]) {
		self.commentField.hidden = YES;
	}
	if(UIGraphicsBeginImageContextWithOptions != NULL)
	{
		UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 2);
	} else {
		UIGraphicsBeginImageContext(self.frame.size);
	}
	//	UIGraphicsBeginImageContextWithOptions(self.diaryEditor.frame.size, YES, 1);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage * diaryIMG = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	self.commentField.hidden = NO;
	
	return diaryIMG;
}

-(void)resetDiary
{
	self.titleField.text = @"";
	self.contentField.text = @"";
	self.contentFieldPlaceholder.alpha = 1;
	self.commentField.text = @"";
	
	if (self.activeInput) {
		[self.activeInput resignFirstResponder];
	}
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self endEditing:YES];
}

#pragma mark - TextField Delegate
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
	return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	self.activeInput = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
	if (textField == self.commentField && self.commentField.text.length > 0) {
		NSRange r = [self.commentField.text rangeOfString:@"-"];
		if (r.location == NSNotFound || r.location != 0) {
			self.commentField.text = [NSString stringWithFormat:@"-%@", self.commentField.text];
		}
	}
	self.activeInput = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark - TextView Delegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
	self.activeInput = textView;
	if (textView == self.contentField) {
		if (![self.contentField hasText]) {
			[UIView animateWithDuration:0.2 animations:^{
//				self.contentField.alpha = 1;
				self.contentFieldPlaceholder.alpha = 0;
			}];
		}
	}
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
	if (textView == self.contentField) {
		if (![textView hasText]) {
			[UIView animateWithDuration:0.2 animations:^{
//				self.contentField.alpha = 0;
				self.contentFieldPlaceholder.alpha = 1;
			}];
		}
	}
	self.activeInput = nil;
}
-(void)textViewDidChange:(UITextView *)textView
{
	if (textView == self.contentField) {
//		CGSize constraintSize;
//		constraintSize.width = 300;
//		constraintSize.height = MAXFLOAT;
////		CGSize sizeFrame =[textView sizeWithFont:textView.font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
//		CGRect newframe = [textView.text boundingRectWithSize:constraintSize
//													  options:NSStringDrawingUsesLineFragmentOrigin
//												   attributes:textView.typingAttributes
//													  context:nil];
//		
//		textView.frame = CGRectMake(textView.frame.origin.x,
//									textView.frame.origin.y,
//									newframe.size.width,
//									newframe.size.height);
//		NSLog(@"new heighr: %f", newframe.size.height);
	}
}

@end
