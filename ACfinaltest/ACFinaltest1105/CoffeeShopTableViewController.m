//
//  CoffeeShopTableViewController.m
//  ACFinaltest1105
//
//  Created by 廖崇捷 on 2015/11/5.
//  Copyright © 2015年 Dimo. All rights reserved.
//

#import "CoffeeShopTableViewController.h"
#import "parse/parse.h"
#import "CoffeeShopTableViewCell.h"
#import "CoffeeDetailViewController.h"
#import "AddCoffeeShopViewController.h"
#import "ParseUI/ParseUI.h"


@interface CoffeeShopTableViewController (){
    NSMutableArray *arrayOfCoffeeShop;
}

@end

@implementation CoffeeShopTableViewController
- (IBAction)addCoffeeShop:(id)sender {
    [self performSegueWithIdentifier:@"toShowAddCoffeeShop" sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downloadCoffeeShopInfo];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



-(void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(addcoffee:)
     name:@"AddCoffeeNoti" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadCoffeeShopInfo{
    arrayOfCoffeeShop = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"coffeeshop"];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:
     ^(NSArray * _Nullable objects, NSError * _Nullable error) {
         if (error == nil) {
             arrayOfCoffeeShop = [NSMutableArray arrayWithArray:objects];
             [self.tableView reloadData];
         }else{
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"未連接到網路" message:@"" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
               
             }];
             [alertController addAction:cancelButton];
             [self presentViewController:alertController animated:YES completion:nil];
             [self.tableView reloadData];
             
             };
     }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return arrayOfCoffeeShop.count;
}


- (CoffeeShopTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CoffeeShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"coffeeCell" forIndexPath:indexPath];
    
    PFObject *coffeeShop = arrayOfCoffeeShop[indexPath.row];
    
    PFFile *picOfCoffee = coffeeShop[@"picOfCoffeeShop"];
    [picOfCoffee getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if(error == nil){
                UIImage *image = [[UIImage alloc] initWithData:data];
                cell.picOfCoffee.image = image;
            }
    }];
    
    cell.nameOfCoffee.text = coffeeShop[@"nameOfCoffeeShop"];
    cell.addOfCoffee.text = coffeeShop[@"addOfCoffeeShop"];
    // Configure the cell...
    
    return cell;
}

-(void)addcoffee:(NSNotification*)noti {
    
    NSDictionary *coffeeDic = noti.userInfo;
    [arrayOfCoffeeShop insertObject:coffeeDic[@"Object"] atIndex:0];
    [self.tableView reloadData];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toShowDetailCoffeeShop"]) {
        NSIndexPath *indexpath = (NSIndexPath *)sender;
        CoffeeDetailViewController *controller = [segue destinationViewController];
        PFObject *coffee = arrayOfCoffeeShop[indexpath.row];
//        controller.coffeeArray = coffee;
        controller.coffeeName = coffee[@"nameOfCoffeeShop"];
        controller.coffeeadd = coffee[@"addOfCoffeeShop"];
        controller.coffeeTel = coffee[@"telOfCoffeeShop"];
        controller.coffeeIntro = coffee[@"introOfCoffeeShop"];
        controller.coffeeWeb = coffee[@"webOfCoffeeShop"];
        PFFile *picOfCoffee = coffee[@"picOfCoffeeShop"];
        controller.coffeePic = picOfCoffee;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toShowDetailCoffeeShop" sender:indexPath];
}


//delete
- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:
(NSIndexPath *)indexPath
{
    

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFQuery *deleteObject = [PFQuery queryWithClassName:@"coffeeshop"];
        NSLog(@"%@", arrayOfCoffeeShop[indexPath.row][@"nameOfCoffeeShop"]);
        [deleteObject whereKey:@"nameOfCoffeeShop" equalTo:arrayOfCoffeeShop[indexPath.row][@"nameOfCoffeeShop"]];
        
        [deleteObject getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            
            if (!object) {
                NSLog(@"無資料");
                
            } else {
                
                [object deleteInBackground];
                
                NSLog(@"刪除成功");
                
            }
        }];
        [arrayOfCoffeeShop removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }


}

-(void)refresh {
    // do something here to refresh.
    [arrayOfCoffeeShop removeAllObjects];
    [self downloadCoffeeShopInfo];
    
    [self.refreshControl endRefreshing];
    
    [self.tableView reloadData];
    
    
}
         
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
