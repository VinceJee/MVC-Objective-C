//
//  DemoController.m
//  MVC
//
//  Created by zhumengjiao on 2019/4/20.
//  Copyright © 2019 zmj. All rights reserved.
//

#import "DemoController.h"
#import "DemoCellView.h"
#import "DemoModelStore.h"
#import "DemoModel.h"

static NSString *cellIdentifier = @"DemoCell";

@interface DemoController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DemoController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        [_tableView registerClass:[DemoCellView class] forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
}

#pragma mark - table view delegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[DemoModelStore shared] remove:indexPath.row];
}

#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DemoModelStore shared].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [DemoModelStore shared].items[indexPath.row].title;
    return cell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:(UIBarButtonItemStylePlain) target:self action:@selector(addAction:)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemsDidChange:) name:ChangeNotificationName object:nil];
}


// model changed
- (void)itemsDidChange:(NSNotification *)noti {
    
    NSUInteger behaviour = [noti.userInfo[@"ChangeNotificationNameKey"] integerValue];
    
    switch (behaviour) {
        case Add: {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        case Remove: {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        case Reload:
            [self.tableView reloadData];
        default:
            break;
    }
    
    [self.tableView reloadData];
}

- (void)addAction:(UIBarButtonItem *)butItem {
    DemoModel *model = [[DemoModel alloc] init];
    [[DemoModelStore shared] add:model];
    NSUInteger count = [DemoModelStore shared].items.count;
    model.title = [NSString stringWithFormat:@"title - %@",@(count)];
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
