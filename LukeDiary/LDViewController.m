//
//  LDViewController.m
//  LukeDiary
//
//  Created by ziv yuan on 14-7-26.
//  Copyright (c) 2014年 gem design. All rights reserved.
//

//#import <MapKit/MKUserLocation.h>
//#import <CoreLocation/CLLocation.h>
//#import <CoreLocation/CLLocationManager.h>

#import "LDViewController.h"
#import "LDDiaryEditorView.h"
#import "LDHistoryView.h"
#import "LDDefines.h"
#import "LDDiaryPaperViewController.h"

@interface LDViewController ()
	<UITableViewDelegate>

@property (nonatomic, strong) IBOutlet LDDiaryEditorView      * diaryEditor;
@property (nonatomic, strong) IBOutlet LDHistoryView          * historyList;
//@property (nonatomic, strong)          CLLocationManager      * locationManager;
//@property (nonatomic, strong)          CLLocation             * location;
// @property (nonatomic, strong)


@property (nonatomic, strong)          NSMutableArray         * historyDataList;

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;

-(IBAction)onSaveClick:(id)sender;

@end

@implementation LDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
	NSArray * datalist = [def arrayForKey:key_HISTORY];
 	self.historyDataList = datalist ? [NSMutableArray arrayWithArray:datalist] : [[NSMutableArray alloc] init];
	
	[self.diaryEditor initial];
	self.historyList.historyTable.delegate = self;
	self.historyList.dataList = self.historyDataList;
	
	// user location
//	if ([CLLocationManager locationServicesEnabled])
//	{
//		self.locationManager = [[CLLocationManager alloc] init];
//		self.locationManager.delegate = self;
//
////		if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
//		[self.locationManager startUpdatingLocation];
////		}
//	}else
//	{
//		if ( ! [def boolForKey:@"alert-location"]) {
//			UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
//															 message:@"请开启设备的定位功能"
//															delegate:self cancelButtonTitle:@"确定"
//												   otherButtonTitles:nil];
//			[alert show];
//			[def setBool:YES forKey:@"alert-location"];
//		}
//	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
//	if (self.locationManager) {
//		[self.locationManager startUpdatingLocation];
//	}
}

#pragma mark - Save image

- (void)saveImage{
	UIImage * diaryIMG = [self.diaryEditor getImage];
	// save to disk
	NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString * photolib = [path stringByAppendingPathComponent:@"ldlib"];
	NSFileManager * fm = [NSFileManager defaultManager];
	BOOL isDirectory;
	if ([fm fileExistsAtPath:photolib isDirectory:&isDirectory]) {
		if (!isDirectory) {
			[fm removeItemAtPath:photolib error:nil];
			[fm createDirectoryAtPath:photolib
		  withIntermediateDirectories:YES
						   attributes:nil
								error:nil];
		}
	}else{
		[fm createDirectoryAtPath:photolib
	  withIntermediateDirectories:YES
					   attributes:nil
							error:nil];
	}
	
	NSString * filename = [NSString stringWithFormat:@"%@", [NSDate date]];
	filename = [filename stringByReplacingOccurrencesOfString:@":" withString:@""];
	filename = [filename stringByReplacingOccurrencesOfString:@"-" withString:@""];
	filename = [filename stringByReplacingOccurrencesOfString:@" " withString:@""];
	filename = [filename substringToIndex:14];
	filename = [NSString stringWithFormat:@"%@.png", filename];
	photolib = [photolib stringByAppendingPathComponent:filename];
	if ([UIImagePNGRepresentation(diaryIMG) writeToFile:photolib atomically:YES]) {
		NSLog(@"diary image save success.");
	}else{
		NSLog(@"diary image save error.");
	}
	
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	[dict setObject:filename forKey:@"file"];
	[dict setObject:self.diaryEditor.titleField.text forKey:@"title"];
	[dict setObject:self.diaryEditor.contentField.text forKey:@"content"];
	[dict setObject:self.diaryEditor.commentField.text forKey:@"comment"];
	[dict setObject:[NSDate date] forKey:@"date"];
//	NSString * coord = [NSString stringWithFormat:@"{%f, %f}", self.location.coordinate.latitude, self.location.coordinate.longitude];
//	[dict setObject:coord forKey:@"coord"];
//	[self.historyDataList addObject:dict];
	[self.historyDataList insertObject:dict atIndex:0];
	self.historyList.dataList = self.historyDataList;
	NSLog(@"saved: %@", self.historyDataList);
	// save to library
	UIImageWriteToSavedPhotosAlbum(diaryIMG, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
	
	NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
	[def setObject:self.historyDataList forKey:key_HISTORY];
}

//保存完成回掉方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
	//do something...
	if (error) {
		NSLog(@"image save error: %@", error);
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:[NSString stringWithFormat:@"出错啦"]
                                    message:error
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:true completion:nil];
	}else{
		NSLog(@"image saved!");
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:[NSString stringWithFormat:@"提示"]
                                    message:@"日记保存成功啦"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:true completion:nil];
	}
}

-(void)onSaveClick:(id)sender
{
	NSString * message = [self.diaryEditor validateInputs];
	if (message) {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:[NSString stringWithFormat:@"出错啦"]
                                    message:message
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:true completion:nil];
	}else{
		[self saveImage];
		[self.diaryEditor resetDiary];
	}
}


#pragma mark - Location Service Delegate
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    // 获取经纬度
//    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
//    NSLog(@"经度:%f",newLocation.coordinate.longitude);
//	self.location = newLocation;
//    // 停止位置更新
//    [manager stopUpdatingLocation];
//}
//
//// 定位失误时触发
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    NSLog(@"location service faile:%@",error);
//}

#pragma mark -
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	NSIndexPath * index = [self.historyList.historyTable indexPathForSelectedRow];
	NSDictionary * dict = [self.historyDataList objectAtIndex:[index indexAtPosition:1]];
	LDDiaryPaperViewController * paper = segue.destinationViewController;
	paper.data = dict;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self performSegueWithIdentifier:@"showdiaryboardview" sender:self];
	[self.historyList.historyTable deselectRowAtIndexPath:indexPath animated:YES];
}


@end
