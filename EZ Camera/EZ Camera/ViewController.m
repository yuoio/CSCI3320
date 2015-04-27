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
{
    UIImage *originalImage;
}
- (IBAction)photoFromAlbum;
- (IBAction)photoFromCamera;
@property BOOL sourceIsCamera, sourceIsAlbum;

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
        vc.passedImage = originalImage;
    }
    else if ([segue.identifier isEqualToString:@"album"]) {
        
        SecondViewController *vc = [segue destinationViewController];
        vc.passedImage = originalImage;
        NSLog(@"album");
    }
}

- (IBAction)photoFromAlbum
{
    
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:photoPicker animated:YES completion:NULL];
    
    self.sourceIsAlbum = YES;
    
    
}

- (IBAction)photoFromCamera
{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:photoPicker animated:YES completion:NULL];
    
     self.sourceIsCamera = YES;
    
}

-(void)imagePickerController:(UIImagePickerController *)photoPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [photoPicker dismissModalViewControllerAnimated:YES];
    if (self.sourceIsAlbum) {
        [self performSegueWithIdentifier:@"album" sender:self];
    }
    else if (self.sourceIsCamera)
    {
        [self performSegueWithIdentifier:@"camera" sender:self];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
