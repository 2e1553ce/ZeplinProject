//
//  AVGSettingsViewController.m
//  ZeplinProject
//
//  Created by aiuar on 27.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "AVGSettingsViewController.h"
#import "AVGSettingsCell.h"

@interface AVGSettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *settingsTableView;
@property (nonatomic, copy) NSArray *cellTitles;

@end

@implementation AVGSettingsViewController

#pragma mark - Life cycle of view controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViewController];
    [self configureTableView];
    [self addBackButton];
}

#pragma mark - Actions

- (void)backButtonAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View controller configuration

- (void)configureViewController {
    self.view.backgroundColor = UIColor.customLightHoarColor;
    self.navigationController.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:UIColor.blackColor,
       NSFontAttributeName:UIFont.settingsTitle}];
    self.navigationItem.title = @"Настройки";
}

#pragma mark - Table view configuration

- (void)configureTableView {
    self.cellTitles = @[@"Темы", @"Хранилище"];
    self.settingsTableView = [UITableView new];
    self.settingsTableView.backgroundColor = UIColor.customLightHoarColor;
    self.settingsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.settingsTableView registerClass:[AVGSettingsCell class] forCellReuseIdentifier:settingsCellIdentifier];
    self.settingsTableView.dataSource = self;
    self.settingsTableView.delegate = self;
    [self.view addSubview:self.settingsTableView];
    
    UIView *superview = self.view;
    [self.settingsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(36);
        make.left.equalTo(superview).with.offset(0);
        make.right.equalTo(superview).with.offset(0);
        make.bottom.equalTo(superview).with.offset(0);
    }];
}

#pragma mark - Adding back button

- (void)addBackButton {
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonAction:)];
    barBtn.tintColor = UIColor.customLightBlueColor;
    self.navigationItem.leftBarButtonItem = barBtn;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AVGSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:settingsCellIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = self.cellTitles[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AVGSettingsCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
