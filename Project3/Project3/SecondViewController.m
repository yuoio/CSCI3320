//
//  SecondViewController.m
//  Project3
//
//  Created by Wenhan on 4/26/15.
//  Copyright (c) 2015 Wenhan&Xiaozheng. All rights reserved.
//
#import "ViewController.h"
#import "SecondViewController.h"

@interface SecondViewController ()
{
    UIImage *originalImage;
}



@property (strong, nonatomic) IBOutlet UIImageView *view0;



@end

@implementation SecondViewController
@synthesize sourceIsAlbum,sourceIsCamera;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (sourceIsCamera) {
        [self photoFromCamera];
    }
    else if (sourceIsAlbum)
    {
        [self photoFromAlbum];
    }
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)photoFromAlbum
{
    
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:photoPicker animated:YES completion:NULL];
}

- (void)photoFromCamera
{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:photoPicker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)photoPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
 
    
    UIImage *selectedImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.view0 setImage:selectedImage];
    
    [photoPicker dismissModalViewControllerAnimated:YES];
    
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
