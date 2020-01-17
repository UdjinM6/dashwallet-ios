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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DWTabBarViewButtonType) {
    DWTabBarViewButtonType_Home,
    DWTabBarViewButtonType_Contacts,
    DWTabBarViewButtonType_Others,
};

extern CGFloat const DW_TABBAR_HEIGHT;

@class DWTabBarView;

@protocol DWTabBarViewDelegate <NSObject>

- (void)tabBarView:(DWTabBarView *)tabBarView didTapButtonType:(DWTabBarViewButtonType)buttonType;
- (void)tabBarViewDidOpenPayments:(DWTabBarView *)tabBarView;
- (void)tabBarViewDidClosePayments:(DWTabBarView *)tabBarView;

@end

@interface DWTabBarView : UIView

@property (nullable, nonatomic, weak) id<DWTabBarViewDelegate> delegate;

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)setPaymentsButtonOpened:(BOOL)opened;
- (void)updateSelectedTabButton:(DWTabBarViewButtonType)type;

- (void)togglePaymentsOpenState;

@end

NS_ASSUME_NONNULL_END
