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

#import "DWShortcutsModel.h"

#import "DWGlobalOptions.h"
#import "DWShortcutAction.h"

NS_ASSUME_NONNULL_BEGIN

static NSInteger MAX_SHORTCUTS_COUNT = 4;

@interface DWShortcutsModel ()

@property (strong, nonatomic) NSMutableArray<DWShortcutAction *> *mutableItems;

@end

@implementation DWShortcutsModel

+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    DWShortcutsModel *obj = nil;
    NSSet *keyPaths = @{
        DW_KEYPATH(obj, items) : [NSSet setWithObject:DW_KEYPATH(obj, mutableItems)],
    }[key];
    return keyPaths ?: [super keyPathsForValuesAffectingValueForKey:key];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self reloadShortcuts];
    }
    return self;
}

- (void)dealloc {
    DSLogVerbose(@"☠️ %@", NSStringFromClass(self.class));
}

- (NSArray<DWShortcutAction *> *)items {
    return [self.mutableItems copy];
}

- (void)reloadShortcuts {
    DWGlobalOptions *options = [DWGlobalOptions sharedInstance];
    NSArray<NSNumber *> *shortcutsSettings = options.shortcuts;

    if (shortcutsSettings) {
        self.mutableItems = [self.class userShortcuts];
    }
    else {
        self.mutableItems = [self.class defaultShortcuts];
    }
}

#pragma mark - Private

+ (NSMutableArray<DWShortcutAction *> *)defaultShortcuts {
    DWGlobalOptions *options = [DWGlobalOptions sharedInstance];

    NSMutableArray<DWShortcutAction *> *mutableItems = [NSMutableArray array];

    [mutableItems addObject:[DWShortcutAction action:DWShortcutActionType_CreateUsername]];

    const BOOL walletNeedsBackup = options.walletNeedsBackup;
    if (walletNeedsBackup) {
        [mutableItems addObject:[DWShortcutAction action:DWShortcutActionType_SecureWallet]];
    }

    [mutableItems addObject:[DWShortcutAction action:DWShortcutActionType_ScanToPay]];
    [mutableItems addObject:[DWShortcutAction action:DWShortcutActionType_PayToAddress]];
    [mutableItems addObject:[DWShortcutAction action:DWShortcutActionType_BuySellDash]];

    const BOOL canConfigureShortcuts = !walletNeedsBackup;
    if (canConfigureShortcuts) {
        [mutableItems addObject:[DWShortcutAction action:DWShortcutActionType_ImportPrivateKey]];
    }

    return mutableItems;
}

+ (NSMutableArray<DWShortcutAction *> *)userShortcuts {
    DWGlobalOptions *options = [DWGlobalOptions sharedInstance];
    NSAssert(options.walletNeedsBackup == NO,
             @"User not allowed to configure shortcuts if backup is not done");
    NSParameterAssert(options.shortcuts);

    NSArray<NSNumber *> *shortcutsSettings = options.shortcuts;

    NSMutableArray<DWShortcutAction *> *mutableItems = [NSMutableArray array];

    for (NSNumber *shortcutActionNumber in shortcutsSettings) {
        DWShortcutActionType action = shortcutActionNumber.integerValue;
        BOOL actionValid = (action >= DWShortcutActionType_SecureWallet &&
                            action <= DWShortcutActionType_ReportAnIssue) ||
                           action == DWShortcutActionType_AddShortcut;
        NSAssert(actionValid, @"Invalid shortcut");
        if (!actionValid) {
            continue;
        }

        [mutableItems addObject:[DWShortcutAction action:action]];
    }

    return mutableItems;
}


@end

NS_ASSUME_NONNULL_END
