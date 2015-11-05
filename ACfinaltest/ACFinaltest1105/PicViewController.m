//
//  PicViewController.m
//  ACFinaltest1105
//
//  Created by 廖崇捷 on 2015/11/5.
//  Copyright © 2015年 Dimo. All rights reserved.
//

#import "PicViewController.h"

@interface PicViewController ()<UIScrollViewDelegate>
{
    UIImageView *imageView;
}

@end

@implementation PicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    imageView =
    [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height - 20)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = self.bigPicOfCoffee;
    [self.add addSubview:imageView];


}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView; }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
