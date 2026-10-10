//
//  PubgLoad.m
//  pubg
//
//  Created by 李良林 on 2021/2/14.
//

#import "PubgLoad.h"
#import <UIKit/UIKit.h>

#import "JHPP.h"
#import "JHDragView.h"
#import "ImGuiLoad.h"
#import "ImGuiDrawView.h"
@interface PubgLoad()
@property (nonatomic, strong) ImGuiDrawView *vna;
@end

@implementation PubgLoad

static PubgLoad *extraInfo;

UIWindow *mainWindow;


+ (void)load
{
    [super load];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PubgLoad setupMenu];
    });
}

+ (void)setupMenu
{
    extraInfo = [PubgLoad new];
    [extraInfo initTapGes];
    [extraInfo initTapGes2];
    [extraInfo tapIconView];
}

- (UIView *)findTargetView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        if (windows.count > 0) {
            window = windows[0];
        }
    }
    if (window && window.rootViewController && window.rootViewController.view) {
        return window.rootViewController.view;
    }
    return window;
}

-(void)initTapGes
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 2;//点击次数
    tap.numberOfTouchesRequired = 3;//手指数
    UIViewController *currVC = [JHPP currentViewController];
    if (currVC && currVC.view) {
        [currVC.view addGestureRecognizer:tap];
    }
    [tap addTarget:self action:@selector(tapIconView)];
}

-(void)initTapGes2
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 2;//点击次数
    tap.numberOfTouchesRequired = 2;//手指数
    UIViewController *currVC = [JHPP currentViewController];
    if (currVC && currVC.view) {
        [currVC.view addGestureRecognizer:tap];
    }
    [tap addTarget:self action:@selector(tapIconView2)];
}

-(void)tapIconView2
{
    if (!_vna) {
        ImGuiDrawView *vc = [[ImGuiDrawView alloc] init];
        _vna = vc;
    }
    [ImGuiDrawView showChange:false];
    UIView *target = [self findTargetView];
    if (target && _vna.view && _vna.view.superview != target) {
        [target addSubview:_vna.view];
    }
}

-(void)tapIconView
{
    if (!_vna) {
        ImGuiDrawView *vc = [[ImGuiDrawView alloc] init];
        _vna = vc;
    }
    [ImGuiDrawView showChange:true];
    UIView *target = [self findTargetView];
    if (target && _vna.view && _vna.view.superview != target) {
        [target addSubview:_vna.view];
    }
}
@end
