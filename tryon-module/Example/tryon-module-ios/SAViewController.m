//
//  SAViewController.m
//  tryon-module-ios
//
//  Created by supermariobean on 03/06/2018.
//  Copyright (c) 2018 supermariobean. All rights reserved.
//

#import "SAViewController.h"

#import <PromiseKit/PromiseKit.h>
#import <libextobjc/extobjc.h>
#import <SEPFoundation/SEPFoundation.h>

#import <tryon_module_ios_debug/SEPTryon.h>

@import FMTFoundation;

@interface SAViewController () <UITextFieldDelegate>

@property (readwrite, nonatomic, strong) UILabel *skuCodeTitle;
@property (readwrite, nonatomic, strong) UITextField *textField;
@property (readwrite, nonatomic, strong) UILabel *label;

@property (readwrite, nonatomic, strong) UILabel *skinClearTitle;
@property (readwrite, nonatomic, strong) UISlider *skinClearSlider;
@property (readwrite, nonatomic, strong) UILabel *skinClearValue;

@property (readwrite, nonatomic, strong) UILabel *skinWhiteTitle;
@property (readwrite, nonatomic, strong) UISlider *skinWhiteSlider;
@property (readwrite, nonatomic, strong) UILabel *skinWhiteValue;

@end

@implementation SAViewController

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.placeholder = @"请在输入框中输入 skuCode";
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textField;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:10];
        _label.text = @"匹配结果";
    }
    return _label;
}

- (UILabel *)skinClearTitle {
    if (!_skinClearTitle) {
        _skinClearTitle = [[UILabel alloc] init];
        _skinClearTitle.text = @"磨皮(skin clear)";
        _skinClearTitle.font = [UIFont systemFontOfSize:10];
    }
    return _skinClearTitle;
}

- (UISlider *)skinClearSlider {
    if (!_skinClearSlider) {
        _skinClearSlider = [[UISlider alloc] init];
        _skinClearSlider.minimumValue = 0.0;
        _skinClearSlider.maximumValue = 1.0;
    }
    return _skinClearSlider;
}

- (UILabel *)skinClearValue {
    if (!_skinClearValue) {
        _skinClearValue = [[UILabel alloc] init];
        _skinClearValue.font = [UIFont systemFontOfSize:10];
    }
    return _skinClearValue;
}

- (UILabel *)skinWhiteTitle {
    if (!_skinWhiteTitle) {
        _skinWhiteTitle = [[UILabel alloc] init];
        _skinWhiteTitle.text = @"美肤(skin white)";
        _skinWhiteTitle.font = [UIFont systemFontOfSize:10];
    }
    return _skinWhiteTitle;
}

- (UISlider *)skinWhiteSlider {
    if (!_skinWhiteSlider) {
        _skinWhiteSlider = [[UISlider alloc] init];
        _skinWhiteSlider.minimumValue = 0.0;
        _skinWhiteSlider.maximumValue = 1.0;
    }
    return _skinWhiteSlider;
}

- (UILabel *)skinWhiteValue {
    if (!_skinWhiteValue) {
        _skinWhiteValue = [[UILabel alloc] init];
        _skinWhiteValue.font = [UIFont systemFontOfSize:10];
    }
    return _skinWhiteValue;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.skinClearSlider];
    [self.skinClearSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide).offset(20);
        make.width.mas_equalTo(200);
    }];
    
    [self.view addSubview:self.skinClearTitle];
    [self.skinClearTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.skinClearSlider);
        make.trailing.equalTo(self.skinClearSlider.mas_leading).offset(-10);
    }];
    
    [self.view addSubview:self.skinClearValue];
    [self.skinClearValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.skinClearSlider);
        make.leading.equalTo(self.skinClearSlider.mas_trailing).offset(10);
    }];
    
    [self.view addSubview:self.skinWhiteSlider];
    [self.skinWhiteSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.skinClearSlider.mas_bottom).offset(20);
        make.width.mas_equalTo(200);
    }];
    
    [self.view addSubview:self.skinWhiteTitle];
    [self.skinWhiteTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.skinWhiteSlider);
        make.trailing.equalTo(self.skinWhiteSlider.mas_leading).offset(-10);
    }];
    
    [self.view addSubview:self.skinWhiteValue];
    [self.skinWhiteValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.skinWhiteSlider);
        make.leading.equalTo(self.skinWhiteSlider.mas_trailing).offset(10);
    }];
    
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.skinWhiteSlider.mas_bottom).offset(20);
    }];
    
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.textField.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 44));
    }];
    
    [self.skinClearSlider fmt_addBlockForControlEvents:UIControlEventValueChanged
                                                 block:^(UISlider * _Nonnull sender) {
        self.skinClearValue.text = @(sender.value).stringValue;
    }];
    [self.skinWhiteSlider fmt_addBlockForControlEvents:UIControlEventValueChanged
                                                 block:^(UISlider * _Nonnull sender) {
        self.skinWhiteValue.text = @(sender.value).stringValue;
    }];

    dispatch_async(dispatch_get_main_queue(), ^{
        self.skinWhiteSlider.value = fmt_tryonService.skinWhiteningAmount;
        self.skinWhiteValue.text = @(fmt_tryonService.skinWhiteningAmount).stringValue;
        self.skinClearSlider.value = fmt_tryonService.skinClearingAmount;
        self.skinClearValue.text = @(fmt_tryonService.skinClearingAmount).stringValue;
    });
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"虚拟试装"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(showVirualTryon)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)showVirualTryon {
    fmt_tryonService.skinWhiteningAmount = self.skinWhiteSlider.value;
    fmt_tryonService.skinClearingAmount = self.skinClearSlider.value;
    [fmt_tryonService presentTryonViewControllerWithTitle:@"虚拟试装"
                                         onViewController:self
                                                 animated:YES
                                               completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.label.text = @"";
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [fmt_tryonService canBeUsedInTryonWithMaskSetForSkuCode:textField.text]
    .then(^(NSNumber *ret) {
        if ([ret boolValue]) {
            self.label.text = @"可以在虚拟试装 with mask 中展示";
        } else {
            self.label.text = @"不能在虚拟试装 with mask 中展示";
        }
    });
    
//    [fmt_tryonService canBeUsedInTryonForSkuCode:textField.text]
//    .then(^(NSNumber *ret) {
//        if ([ret boolValue]) {
//            self.label.text = @"可以在虚拟试装中展示";
//        } else {
//            self.label.text = @"不能在虚拟试装中展示";
//        }
//    });
}

@end
