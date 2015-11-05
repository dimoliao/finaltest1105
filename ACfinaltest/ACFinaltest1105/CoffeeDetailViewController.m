//
//  CoffeeDetailViewController.m
//  ACFinaltest1105
//
//  Created by 廖崇捷 on 2015/11/5.
//  Copyright © 2015年 Dimo. All rights reserved.
//

#import "CoffeeDetailViewController.h"
#import "MapViewController.h"
#import "PicViewController.h"

@interface CoffeeDetailViewController ()

@end

@implementation CoffeeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameDetail.text = self.coffeeName;
    self.addDetail.text = self.coffeeadd;
    self.talDetail.text = self.coffeeTel;
    self.webDetail.text = self.coffeeWeb;
    self.introDetail.text = self.coffeeIntro;
    [self.coffeePic getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if(error == nil){
            UIImage *image = [[UIImage alloc] initWithData:data];
           self.imageViewDetail.image = image;
        }
    }];

    
// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)contactPhone:(UITapGestureRecognizer *)sender {

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"聯絡我們" message:self.coffeeTel preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:
                       [NSURL URLWithString:self.talDetail.text]];
        }];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"否"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                                       }];
    [alertController addAction:cancelButton];
    [alertController addAction:okButton];
    [self presentViewController:alertController animated:YES completion:nil];
    

}
- (IBAction)contactUrl:(UITapGestureRecognizer *)sender {
    [[UIApplication sharedApplication] openURL:
                   [NSURL URLWithString:self.webDetail.text]];
}

- (IBAction)contactMap:(UITapGestureRecognizer *)sender {
    MapViewController *controller =
    [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];

//    [self performSegueWithIdentifier:@"toShowMap" sender:nil];
//    MapViewController *controller = [[MapViewController alloc] init];
    controller.addressOfCoffee = self.addDetail.text;
    controller.nameOfCoffee = self.coffeeName;
    [self presentViewController:controller animated:YES completion:nil];

}

- (IBAction)contactPic:(UITapGestureRecognizer *)sender {
    
//    [self performSegueWithIdentifier:@"toShowPic" sender:nil];
//    PicViewController  *controller = [[PicViewController alloc] init];
//    controller.bigPicOfCoffee = self.imageViewDetail.image;
 
    PicViewController *controller =
    [self.storyboard instantiateViewControllerWithIdentifier:@"PicViewController"];
    
    controller.bigPicOfCoffee = self.imageViewDetail.image;

    
    
    
    [self presentViewController:controller animated:YES completion:nil];
    
    
    
    
    
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
