//
//  AddCoffeeShopViewController.m
//  ACFinaltest1105
//
//  Created by 廖崇捷 on 2015/11/5.
//  Copyright © 2015年 Dimo. All rights reserved.
//
#import "parse/parse.h"
#import "AddCoffeeShopViewController.h"

@interface AddCoffeeShopViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation AddCoffeeShopViewController
- (IBAction)addPicButPressed:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.allowsEditing = true;
        [self presentViewController:picker animated:true completion:nil];
    }

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.addPicOfCoffee.image = image;
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)addCompletePressed:(id)sender {
    PFObject *addCoffee = [PFObject objectWithClassName:@"coffeeshop"];
    addCoffee[@"nameOfCoffeeShop"] = self.addNameOfCoffee.text;
    addCoffee[@"addOfCoffeeShop"] = self.addAddressOfCoffee.text;
    addCoffee[@"telOfCoffeeShop"] = self.addTelOfCoffee.text;
    addCoffee[@"introOfCoffeeShop"] = self.addIntroOfCoffee.text;
    addCoffee[@"webOfCoffeeShop"] = self.addWebsiteOfCoffee.text;
    UIImage *image = self.addPicOfCoffee.image;
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    PFFile *imageFile = [PFFile fileWithName:@"coffee.jpg" data:imageData];
    addCoffee[@"picOfCoffeeShop"] = imageFile;
    NSDictionary *dicObj = @{@"Object":addCoffee};
    [addCoffee saveInBackgroundWithBlock:^(BOOL succeeded, NSError
                                          *error) {
        if (succeeded) {
            NSLog(@"succeed");
        } else {
            NSLog(@"fail");
        }
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddCoffeeNoti" object:nil userInfo:dicObj];
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    // Pass the selected object to the new view controller.
}
*/

@end
