//
//  SecondViewController.m
//  Project3
//
//  Created by Wenhan on 4/26/15.
//  Copyright (c) 2015 Wenhan&Xiaozheng. All rights reserved.
//
#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "GPUImage.h"

@interface SecondViewController ()
{
    UIImage *originalImage;
}



@property (strong, nonatomic) IBOutlet UIImageView *view0;
@property (strong, nonatomic) IBOutlet UIImageView *view1;
@property (strong, nonatomic) IBOutlet UIImageView *view2;
@property (strong, nonatomic) IBOutlet UIImageView *view3;
@property (strong, nonatomic) IBOutlet UIImageView *view4;
@property (strong, nonatomic) IBOutlet UIImageView *view5;
@property (strong, nonatomic) IBOutlet UIImageView *view6;
@property (strong, nonatomic) IBOutlet UIImageView *view7;
@property (strong, nonatomic) IBOutlet UIImageView *view8;

@property (strong, nonatomic) UIImage *filteredImage1;
@property (strong, nonatomic) UIImage *filteredImage2;
@property (strong, nonatomic) UIImage *filteredImage3;
@property (strong, nonatomic) UIImage *filteredImage4;
@property (strong, nonatomic) UIImage *filteredImage5;
@property (strong, nonatomic) UIImage *filteredImage6;
@property (strong, nonatomic) UIImage *filteredImage7;
@property (strong, nonatomic) UIImage *filteredImage8;


@end

@implementation SecondViewController
@synthesize sourceIsAlbum,sourceIsCamera,passedImage;
@synthesize view0,view1,view2,view3,view4,view5,view6,view7,view8;
@synthesize filteredImage1,filteredImage2,filteredImage3,filteredImage4,filteredImage5,filteredImage6,filteredImage7,filteredImage8;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gray" ]) {
        ThirdViewController   *vc = [segue destinationViewController];
        vc.passedImage = self.filteredImage1;
    }
    else if ([segue.identifier isEqualToString:@"sepia" ]) {
        ThirdViewController   *vc = [segue destinationViewController];
        vc.passedImage = self.filteredImage2;
    }
    else if ([segue.identifier isEqualToString:@"haze" ]) {
        ThirdViewController   *vc = [segue destinationViewController];
        vc.passedImage = self.filteredImage3;
    }
 
    else if ([segue.identifier isEqualToString:@"original" ]) {
        ThirdViewController   *vc = [segue destinationViewController];
        vc.passedImage = self.passedImage;
    }
    
    else if ([segue.identifier isEqualToString:@"blur" ]) {
        ThirdViewController   *vc = [segue destinationViewController];
        vc.passedImage = self.filteredImage4;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    
    //Grayscale image filter
    self.filteredImage1 = [[[GPUImageGrayscaleFilter alloc] init] imageByFilteringImage:passedImage];
    [self.view1 setImage:self.filteredImage1];
    
    
    //Sepia image filter
    self.filteredImage2 = [[[GPUImageSepiaFilter alloc] init] imageByFilteringImage:passedImage];
    [self.view2 setImage:self.filteredImage2];
    
    //Haze image filter
    self.filteredImage3 = [[[GPUImageHazeFilter alloc] init] imageByFilteringImage:passedImage];
    [self.view3 setImage:self.filteredImage3];
    
    //iOS blur filter
    self.filteredImage4 = [[[GPUImageiOSBlurFilter alloc] init] imageByFilteringImage:passedImage];
    [self.view4 setImage:self.filteredImage4];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the original object to the new view controller.
 }
 */

@end
