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

#import "DWTitleDetailCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DWTitleDetailCellModel

@synthesize style = _style;
@synthesize title = _title;
@synthesize plainDetail = _plainDetail;
@synthesize attributedDetail = _attributedDetail;
@synthesize copyableData = _copyableData;

- (instancetype)initWithStyle:(DWTitleDetailItemStyle)style
                        title:(nullable NSString *)title
                  plainDetail:(NSString *)plainDetail {
    return [self initWithStyle:style title:title plainDetail:plainDetail attributedDetail:nil copyableData:nil];
}

- (instancetype)initWithStyle:(DWTitleDetailItemStyle)style
                        title:(nullable NSString *)title
             attributedDetail:(NSAttributedString *)attributedDetail {
    return [self initWithStyle:style
                         title:title
                   plainDetail:nil
              attributedDetail:attributedDetail
                  copyableData:nil];
}

- (instancetype)initWithStyle:(DWTitleDetailItemStyle)style
                        title:(nullable NSString *)title
             attributedDetail:(NSAttributedString *)attributedDetail
                 copyableData:(nullable NSString *)copyableData {
    return [self initWithStyle:style
                         title:title
                   plainDetail:nil
              attributedDetail:attributedDetail
                  copyableData:copyableData];
}

- (instancetype)initWithStyle:(DWTitleDetailItemStyle)style
                        title:(nullable NSString *)title
                  plainDetail:(nullable NSString *)plainDetail
             attributedDetail:(nullable NSAttributedString *)attributedDetail
                 copyableData:(nullable NSString *)copyableData {
    self = [super init];
    if (self) {
        _style = style;
        _title = [title copy];
        _plainDetail = [plainDetail copy];
        _attributedDetail = [attributedDetail copy];
        _copyableData = [copyableData copy];
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
