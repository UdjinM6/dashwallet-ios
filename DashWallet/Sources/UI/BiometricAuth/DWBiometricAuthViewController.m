//
//  Created by Andrew Podkovyrin
//  Copyright © 2019 Dash Core Group. All rights reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  https://opensource.org/licenses/MIT
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "DWBiometricAuthViewController.h"

#import "DWBiometricAuthModel.h"
#import "UIFont+DWFont.h"

@interface DWBiometricAuthViewController ()

@property (nonatomic, strong) DWBiometricAuthModel *model;

@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *enableBiometricButton;
@property (strong, nonatomic) IBOutlet UIButton *skipBiometricButton;

@end

@implementation DWBiometricAuthViewController

+ (instancetype)controller {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BiometricAuth" bundle:nil];
    DWBiometricAuthViewController *controller = [storyboard instantiateInitialViewController];
    controller.model = [[DWBiometricAuthModel alloc] init];

    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];
}

#pragma mark - DWRootNavigationFullscreenable

- (BOOL)requiresNoNavigationBar {
    return YES;
}

#pragma mark - Actions

- (IBAction)enableBiometricButtonAction:(id)sender {
    self.view.userInteractionEnabled = NO;

    __weak typeof(self) weakSelf = self;
    [self.model enableBiometricAuth:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }

        [strongSelf.delegate biometricAuthViewControllerDidFinish:strongSelf];
    }];
}

- (IBAction)skipBiometricButtonAction:(id)sender {
    [self.delegate biometricAuthViewControllerDidFinish:self];
}

#pragma mark - Private

- (void)setupView {
    switch (self.model.biometryType) {
        case LABiometryTypeTouchID: {
            self.logoImageView.image = [UIImage imageNamed:@"icon_touchid"];
            self.titleLabel.text = NSLocalizedString(@"Login with Touch ID", nil);
            [self.enableBiometricButton setTitle:NSLocalizedString(@"Enable Touch ID", nil)
                                        forState:UIControlStateNormal];
            break;
        }
        case LABiometryTypeFaceID: {
            self.logoImageView.image = [UIImage imageNamed:@"icon_faceid"];
            self.titleLabel.text = NSLocalizedString(@"Login with Face ID", nil);
            [self.enableBiometricButton setTitle:NSLocalizedString(@"Enable Face ID", nil)
                                        forState:UIControlStateNormal];
            break;
        }
        default: {
            NSAssert(NO, @"Biometry is not supported");
            break;
        }
    }

    self.titleLabel.font = [UIFont dw_fontForTextStyle:UIFontTextStyleTitle2];

    [self.skipBiometricButton setTitle:NSLocalizedString(@"Skip", nil)
                              forState:UIControlStateNormal];
}

@end
