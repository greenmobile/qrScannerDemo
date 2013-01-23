//
//  ViewController.m
//  qrScannerDemo
//
//  Created by Tillmann on 18.01.13.
//  Copyright (c) 2013 greenmobile. All rights reserved.
//

#import "ViewController.h"

#ifndef ZXQR
#define ZXQR 1
#endif

#if ZXQR
#import "QRCodeReader.h"
#endif

#ifndef ZXAZ
#define ZXAZ 0
#endif

#if ZXAZ
#import "AztecReader.h"
#endif

@interface ViewController ()<UITextFieldDelegate>
@end

@implementation ViewController 
@synthesize textField = _textField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _textField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark QRScannerMethods

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result{
    [self dismissViewControllerAnimated:YES completion:^{
        _textField.text = result;
    }];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller{
    [self dismissViewControllerAnimated:YES completion:^{
    _textField.text = @"nothing scanned";
}];
    
}

- (IBAction)scanButtonAction:(id)sender {
    NSLog(@"opened method -> scanButtonAction");
    
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    
    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    
#if ZXQR
    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
#endif
    
#if ZXAZ
    AztecReader *aztecReader = [[AztecReader alloc] init];
    [readers addObject:aztecReader];
#endif
    
    widController.readers = readers;
    
    // [self presentModalViewController:widController animated:YES];
    [self presentViewController:widController animated:YES completion:^{
        NSLog(@"opened QR-Scanner-View");
    }];

}

- (IBAction)backgroundTouched:(id)sender {
    [self textFieldShouldReturn:_textField];
}

#pragma mark keyboardMethods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
@end
