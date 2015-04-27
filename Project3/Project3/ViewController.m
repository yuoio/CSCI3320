//
//  ViewController.m
//  Project3
//
//  Created by Wenhan on 4/25/15.
//  Copyright (c) 2015 Wenhan&Xiaozheng. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"camera"]) {
        
        SecondViewController *vc = [segue destinationViewController];
        vc.sourceIsCamera = YES;
    }
    else if ([segue.identifier isEqualToString:@"album"]) {
        
        SecondViewController *vc = [segue destinationViewController];
        vc.sourceIsAlbum = YES;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
