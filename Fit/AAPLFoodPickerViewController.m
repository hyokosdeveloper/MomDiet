/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A UIViewController subclass that manages the selection of a food item.
*/

#import "AAPLFoodPickerViewController.h"
#import "AAPLFoodItem.h"

NSString *const AAPLFoodPickerViewControllerTableViewCellIdentifier = @"cell";
NSString *const AAPLFoodPickerViewControllerUnwindSegueIdentifier = @"AAPLFoodPickerViewControllerUnwindSegueIdentifier";

@interface AAPLFoodPickerViewController()

@property (nonatomic, strong) NSArray *foodItems;

@end


@implementation AAPLFoodPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // A hard-coded list of possible food items. In your application, you can decide how these should
    // be represented / created.
    self.foodItems = @[
        [AAPLFoodItem foodItemWithName:@"Apple" joules:240000.0],
        [AAPLFoodItem foodItemWithName:@"Cereal (1 bowl)" joules:190000.0],
        [AAPLFoodItem foodItemWithName:@"CokaCola" joules:1000.0],
        [AAPLFoodItem foodItemWithName:@"Banana" joules:439320.0],
        [AAPLFoodItem foodItemWithName:@"Bagel with CreamCheese" joules:416000.0],
        [AAPLFoodItem foodItemWithName:@"Oatmeal" joules:150000.0],
        [AAPLFoodItem foodItemWithName:@"Fruits Salad" joules:60000.0],
        [AAPLFoodItem foodItemWithName:@"Fish Dinner" joules:200000.0],
        [AAPLFoodItem foodItemWithName:@"Applesouce (1 serving)" joules:190000.0],
        [AAPLFoodItem foodItemWithName:@"Grilled Chicken" joules:170000.0],
        [AAPLFoodItem foodItemWithName:@"Rotessiary Chicken" joules:170000.0],
        [AAPLFoodItem foodItemWithName:@"Coffee with Half & Half" joules:170000.0],
        [AAPLFoodItem foodItemWithName:@"Muffin" joules:370000.0],
        [AAPLFoodItem foodItemWithName:@"Crossoint" joules:370000.0],
        [AAPLFoodItem foodItemWithName:@"Lamb Chops" joules:370000.0],
    ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foodItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:AAPLFoodPickerViewControllerTableViewCellIdentifier forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    AAPLFoodItem *foodItem = self.foodItems[indexPath.row];
    
    cell.textLabel.text = foodItem.name;
    
    NSEnergyFormatter *energyFormatter = [self energyFormatter];
    cell.detailTextLabel.text = [energyFormatter stringFromJoules:foodItem.joules];
}

#pragma mark - Convenience

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:AAPLFoodPickerViewControllerUnwindSegueIdentifier]) {
        NSIndexPath *indexPathForSelectedRow = self.tableView.indexPathForSelectedRow;

        self.selectedFoodItem = self.foodItems[indexPathForSelectedRow.row];
    }
}

- (NSEnergyFormatter *)energyFormatter {
    static NSEnergyFormatter *energyFormatter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        energyFormatter = [[NSEnergyFormatter alloc] init];
        energyFormatter.unitStyle = NSFormattingUnitStyleLong;
        energyFormatter.forFoodEnergyUse = YES;
        energyFormatter.numberFormatter.maximumFractionDigits = 2;
    });
    
    return energyFormatter;
}

@end
