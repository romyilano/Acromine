#import "AcroMineVariationsViewController.h"
#import "AcromineManager.h"
#import "AcromineDesignutility.h"
#import "AcromineTableViewCell.h"
#import "AcroResult.h"

static NSString *VariationCellIdentifier = @"VariationCell";

@interface AcroMineVariationsViewController () 

@property (strong, nonatomic) NSArray *variations;

// custom back bar button so that we don't have to include the root view controller's length
// title in the back button text
- (void)goBack:(id)sender;

@end

@implementation AcroMineVariationsViewController

#pragma mark - Accessors

- (void)setAcroResult:(AcroResult *)acroResult {
    if (![_acroResult isEqual:acroResult]) {
        _acroResult = acroResult;
        _variations = _acroResult.variations;
    }
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* backBtn =  [[UIBarButtonItem alloc] initWithTitle:@"<"
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:[AcromineDesignUtility mainNavigationBarTitleTextAttributes]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.segmentedControl.selectedSegmentIndex = 0;
    self.title = self.acroResult.longForm;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.variations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AcromineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VariationCellIdentifier forIndexPath:indexPath];
    AcroResult *result = self.variations[indexPath.row];
    cell.acroResult = result;
    
    // customize for the variations
    cell.userInteractionEnabled = NO;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.infoLabel.text = [NSString stringWithFormat:@"Frequency: %@ appearing since: %@", result.frequency, [result dateString]];
    return cell;
}

#pragma mark - Custom Methods

- (void)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Action Methods

- (IBAction)segmentedControlClicked:(UISegmentedControl *)sender {
    NSUInteger clickedSegment = [sender selectedSegmentIndex];
    
    switch (clickedSegment) {
        case 0:
            self.variations = [[[AcroMineManager shared] sortAcroResultsBy:self.variations
                                                        bySortingMethod:AcromineManagerSortFrequency] copy];
            break;
        case 1:
            self.variations = [[[AcroMineManager shared] sortAcroResultsBy:self.variations
                                                        bySortingMethod:AcromineManagerSortDate] copy];
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
};

@end
