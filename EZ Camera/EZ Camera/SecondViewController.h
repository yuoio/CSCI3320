//
//  SecondViewController.h
//  EZ Camera
//
//  Created by Wenhan on 4/26/15.
//  Copyright (c) 2015 Wenhan&Xiaozheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property BOOL sourceIsCamera, sourceIsAlbum;
@property (weak, nonatomic) UIImage *passedImage;
@end
