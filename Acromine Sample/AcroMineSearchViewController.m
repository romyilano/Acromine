#import "AcroMineSearchViewController.h"
#import "AcroMineManager.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "AcroResult.h"
#import "AcroMineVariationsViewController.h"
#import "AcromineDesignutility.h"
#import "AcromineTableViewCell.h"
#import "Constants.h"

static NSString *SearchCellIdentifier = @"SearchResultCell";

@interface AcroMineSearchViewController () <MBProgressHUDDelegate>

@property (strong, nonatomic) MBProgressHUD *HUD;
@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, strong) AcroMineManager *manager;

@end

@implementation AcroMineSearchViewController

#pragma mark - accessors

- (AcroMineManager *)manager {
    if (!_manager) {
        _manager = [AcroMineManager shared];
    }
    return _manager;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.delegate = self;
    self.HUD.labelText = @"Loading";
    
    [self.navigationController.navigationBar setTitleTextAttributes:[AcromineDesignUtility mainNavigationBarTitleTextAttributes]];
    [self.segmentedControl setTitleTextAttributes:[AcromineDesignUtility segmentedControlTitleTextAttributes] forState:UIControlStateNormal];
    
}

#pragma mark - Action Method

-(IBAction)segmentedControlClicked:(UISegmentedControl *)sender {
    
    NSUInteger clickedSegment = [sender selectedSegmentIndex];
    
    switch (clickedSegment) {
        case 0:
            self.results = [[[AcroMineManager shared] sortAcroResultsBy:self.results
                                                        bySortingMethod:AcromineManagerSortFrequency] copy];
            break;
        case 1:
            self.results = [[[AcroMineManager shared] sortAcroResultsBy:self.results
                                                        bySortingMethod:AcromineManagerSortDate] copy];
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
}

#pragma mark - Navigation Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueResult]) {
        AcroMineVariationsViewController *acromineVariationsVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        AcroResult *selectedResult = self.results[indexPath.row];
        acromineVariationsVC.acroResult = selectedResult;
    };
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return self.results.count;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView
         cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    AcromineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchCellIdentifier forIndexPath:indexPath];
    AcroResult *result = self.results[indexPath.row];
    cell.acroResult = result;
    if (cell.acroResult.variations.count > 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.userInteractionEnabled = YES;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AcroResult *result = self.results[indexPath.row];
    if (result.variations.count > 1) {
        [self performSegueWithIdentifier:kSegueResult sender:self];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISearchBarDelegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if (!searchBar.text || [searchBar.text isEqualToString:@" "]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                                 message:@"Please enter a url!"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [self.HUD show:YES];
    
    [self.manager updateAcromineResultsWithRequest:searchBar.text
                               acromineRequestType:AcromineRequestTypeShortForm andCompletionBlock:^(NSArray *results, NSError *error) {
                                   if (!error && results.count > 0) {
                                       [weakSelf.HUD hide:YES];
                                       weakSelf.results = [results copy];
                                       weakSelf.segmentedControl.selectedSegmentIndex = 0;
                                       [weakSelf.tableView reloadData];
                                       
                                   } else {
                                       [self.HUD hide:YES];
                                       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                                                                message:@"Unable to find your request"    preferredStyle:UIAlertControllerStyleActionSheet];
                                       UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
                                       [alertController addAction:cancelAction];
                                       [weakSelf presentViewController:alertController animated:YES completion:nil];
                                   }
                               }];
    
    [self.searchBar resignFirstResponder];
}

@end
