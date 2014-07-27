//
//  LDDiaryEditorView.h
//  LukeDiary
//
//  Created by ziv yuan on 14-7-26.
//  Copyright (c) 2014年 gem design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDDiaryEditorView : UIView
	<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) IBOutlet UITextField       * titleField;
@property (nonatomic, strong) IBOutlet UITextField       * commentField;
@property (nonatomic, strong) IBOutlet UITextView        * contentField;

-(void)initial;
-(NSString *)validateInputs;
-(void)resetDiary;
-(UIImage *)getImage;

@end
