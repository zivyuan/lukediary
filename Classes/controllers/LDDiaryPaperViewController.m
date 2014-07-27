//
//  LDDiaryPaperViewController.m
//  LukeDiary
//
//  Created by ziv yuan on 14-7-27.
//  Copyright (c) 2014年 gem design. All rights reserved.
//

#import "LDDiaryPaperViewController.h"

@interface LDDiaryPaperViewController ()

@property(nonatomic, strong) IBOutlet UIImageView    * diaryImage;
@property(nonatomic, strong) IBOutlet UILabel        * dateLabel;
@property(nonatomic, strong) IBOutlet UILabel        * locationLabel;

-(IBAction)onShareClick:(id)sender;
-(IBAction)onCloseClick:(id)sender;

@end

@implementation LDDiaryPaperViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pat"]];
	
	if (self.data) {
		NSString * date = [NSString stringWithFormat:@"%@", [self.data objectForKey:@"date"]];
		self.dateLabel.text = [date substringToIndex:19];
		self.locationLabel.text = [self.data objectForKey:@"coord"];
		NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		NSString * filepath = [path stringByAppendingPathComponent:@"ldlib"];
		filepath = [filepath stringByAppendingPathComponent:[self.data objectForKey:@"file"]];
		self.diaryImage.image = [UIImage imageWithContentsOfFile:filepath];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)onShareClick:(id)sender
{
	NSLog(@"share button click");
}

-(void)onCloseClick:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}


@end
