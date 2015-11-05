//
//  CoffeeDetailViewController.h
//  ACFinaltest1105
//
//  Created by 廖崇捷 on 2015/11/5.
//  Copyright © 2015年 Dimo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoffeeDetailViewController.h"
#import "parse/parse.h"
@interface CoffeeDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameDetail;
@property (weak, nonatomic) IBOutlet UILabel *addDetail;
@property (weak, nonatomic) IBOutlet UILabel *talDetail;
@property (weak, nonatomic) IBOutlet UILabel *webDetail;
@property (weak, nonatomic) IBOutlet UILabel *introDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewDetail;
@property (strong, nonatomic) NSString *coffeeName;
@property (strong, nonatomic) NSString *coffeeWeb;
@property (strong, nonatomic) NSString *coffeeTel;
@property (strong, nonatomic) NSString *coffeeIntro;
@property (strong, nonatomic) NSString *coffeeadd;
@property (strong, nonatomic) PFFile *coffeePic;
@end
