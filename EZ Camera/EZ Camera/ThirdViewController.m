//
//  ThirdViewController.m
//  EZ Camera
//
//  Created by Wenhan on 4/27/15.
//  Copyright (c) 2015 Wenhan&Xiaozheng. All rights reserved.
//

#import "ThirdViewController.h"
#import <Social/Social.h>

@interface ThirdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *finalImage;

@end

@implementation ThirdViewController
@synthesize passedImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.finalImage setImage:passedImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postToFacebook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        
        [controller addImage:self.passedImage];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
}

- (IBAction)postToTwitter:(id)sender {
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        
        [controller addImage:self.passedImage];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
}

- (IBAction)saveImageToAlbum:(id)sender
{
    UIImageWriteToSavedPhotosAlbum(self.passedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *alertTitle;
    NSString *alertMessage;
    
    if(!error)
    {
        alertTitle   = @"Image Saved";
        alertMessage = @"Image saved to photo album successfully.";
    }
    else
    {
        alertTitle   = @"Error";
        alertMessage = @"Unable to save to photo album.";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                    message:alertMessage
                                                   delegate:self
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
    [alert show];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
