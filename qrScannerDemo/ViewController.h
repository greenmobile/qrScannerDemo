//
//  ViewController.h
//  qrScannerDemo
//
//  Created by Tillmann on 18.01.13.
//  Copyright (c) 2013 greenmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"


@interface ViewController : UIViewController <ZXingDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)scanButtonAction:(id)sender;

@end
