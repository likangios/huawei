#line 1 "Tweak.x"

 @interface DMManager : NSObject
+ (instancetype)shareInstance;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isSubmit;
@property (nonatomic, assign) NSInteger dateIndex;

@end

@implementation DMManager
static DMManager *_instance;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc]init];
    });
    return _instance;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        _index = 0;
        _count = 1;
        _dateIndex = 0;
        _isOpen = YES;
        _isSubmit = YES;
    }
    return self;
}
@end



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class HWGoodsDiyPackageEntranceController; @class MineViewController; @class HWShopDetailsViewController; 
static void _logos_method$_ungrouped$HWShopDetailsViewController$singleTap$(_LOGOS_SELF_TYPE_NORMAL HWShopDetailsViewController* _LOGOS_SELF_CONST, SEL, NSTimer *); static void (*_logos_orig$_ungrouped$HWShopDetailsViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL HWShopDetailsViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$HWShopDetailsViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL HWShopDetailsViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$HWGoodsDiyPackageEntranceController$displayLink$(_LOGOS_SELF_TYPE_NORMAL HWGoodsDiyPackageEntranceController* _LOGOS_SELF_CONST, SEL, CADisplayLink *); static void (*_logos_orig$_ungrouped$HWGoodsDiyPackageEntranceController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL HWGoodsDiyPackageEntranceController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$HWGoodsDiyPackageEntranceController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL HWGoodsDiyPackageEntranceController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$MineViewController$isOpenClick$(_LOGOS_SELF_TYPE_NORMAL MineViewController* _LOGOS_SELF_CONST, SEL, UISwitch *); static void _logos_method$_ungrouped$MineViewController$isSubmitClick$(_LOGOS_SELF_TYPE_NORMAL MineViewController* _LOGOS_SELF_CONST, SEL, UISwitch *); static void (*_logos_orig$_ungrouped$MineViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL MineViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$MineViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL MineViewController* _LOGOS_SELF_CONST, SEL); 

#line 36 "Tweak.x"


@interface HWShopDetailsBottomView : UIView

@property(retain, nonatomic) UIButton *buyButton; 

- (void)clickEvent:(id)arg;

@end

@interface HWShopDetailsViewController : UIViewController

@property(retain, nonatomic) HWShopDetailsBottomView *bottomView; 

@end


static void _logos_method$_ungrouped$HWShopDetailsViewController$singleTap$(_LOGOS_SELF_TYPE_NORMAL HWShopDetailsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSTimer * timer){

    if (self.bottomView.buyButton && [DMManager shareInstance].isOpen) {
        [timer invalidate];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(960 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            [self.bottomView clickEvent:self.bottomView.buyButton];
        });
    }
}
static void _logos_method$_ungrouped$HWShopDetailsViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL HWShopDetailsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    _logos_orig$_ungrouped$HWShopDetailsViewController$viewDidLoad(self, _cmd);
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(singleTap:) userInfo:nil repeats:NO];
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    double hourSecond = 60 * 30;
    double hours = ceil(time/hourSecond);
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSince1970:hours * hourSecond - 1];
    [timer setFireDate:fireDate];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}






@interface HWGoodsDiyPackageCheckBottomView : UIView

@property (nonatomic, strong) UIButton *checkOutButton;

-(void)checkOutEvent;

@end

@interface HWGoodsDiyPackageEntranceController : UIViewController


@property(retain, nonatomic) HWGoodsDiyPackageCheckBottomView *checkOutBottomView;

@end


static void _logos_method$_ungrouped$HWGoodsDiyPackageEntranceController$displayLink$(_LOGOS_SELF_TYPE_NORMAL HWGoodsDiyPackageEntranceController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CADisplayLink * link){
    if (self.checkOutBottomView.checkOutButton && [DMManager shareInstance].isSubmit) {
         [link invalidate];
        [self.checkOutBottomView checkOutEvent];
    }
}

static void _logos_method$_ungrouped$HWGoodsDiyPackageEntranceController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL HWGoodsDiyPackageEntranceController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	_logos_orig$_ungrouped$HWGoodsDiyPackageEntranceController$viewDidLoad(self, _cmd);
	if([DMManager shareInstance].isSubmit){
		CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLink:)];
    	[link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];	
	}
}






@interface MineViewController : UIViewController

@end


static void _logos_method$_ungrouped$MineViewController$isOpenClick$(_LOGOS_SELF_TYPE_NORMAL MineViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UISwitch * isOpen){
    [DMManager shareInstance].isOpen = isOpen.on;
}

static void _logos_method$_ungrouped$MineViewController$isSubmitClick$(_LOGOS_SELF_TYPE_NORMAL MineViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UISwitch * isOpen){
    [DMManager shareInstance].isSubmit = isOpen.on;
}

static void _logos_method$_ungrouped$MineViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL MineViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    _logos_orig$_ungrouped$MineViewController$viewDidLoad(self, _cmd);

    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(20, 300, 50, 30)];
    label.text = @"结算";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label];

    UISwitch  *isOpen = [[UISwitch alloc]initWithFrame:CGRectMake(80, 300, 50, 30)];
    [isOpen addTarget:self action:@selector(isOpenClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:isOpen];
    isOpen.on = [DMManager shareInstance].isOpen;


    UILabel *label2 =[[UILabel alloc]initWithFrame:CGRectMake(20, 360, 50, 30)];
    label2.text = @"提交";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = [UIColor blackColor];
    label2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label2];

        UISwitch  *isSubmit = [[UISwitch alloc]initWithFrame:CGRectMake(80, 360, 50, 30)];
    [isSubmit addTarget:self action:@selector(isSubmitClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:isSubmit];
    isSubmit.on = [DMManager shareInstance].isSubmit;

}

 

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$HWShopDetailsViewController = objc_getClass("HWShopDetailsViewController"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSTimer *), strlen(@encode(NSTimer *))); i += strlen(@encode(NSTimer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HWShopDetailsViewController, @selector(singleTap:), (IMP)&_logos_method$_ungrouped$HWShopDetailsViewController$singleTap$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$HWShopDetailsViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$HWShopDetailsViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$HWShopDetailsViewController$viewDidLoad);Class _logos_class$_ungrouped$HWGoodsDiyPackageEntranceController = objc_getClass("HWGoodsDiyPackageEntranceController"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(CADisplayLink *), strlen(@encode(CADisplayLink *))); i += strlen(@encode(CADisplayLink *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$HWGoodsDiyPackageEntranceController, @selector(displayLink:), (IMP)&_logos_method$_ungrouped$HWGoodsDiyPackageEntranceController$displayLink$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$HWGoodsDiyPackageEntranceController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$HWGoodsDiyPackageEntranceController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$HWGoodsDiyPackageEntranceController$viewDidLoad);Class _logos_class$_ungrouped$MineViewController = objc_getClass("MineViewController"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UISwitch *), strlen(@encode(UISwitch *))); i += strlen(@encode(UISwitch *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$MineViewController, @selector(isOpenClick:), (IMP)&_logos_method$_ungrouped$MineViewController$isOpenClick$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UISwitch *), strlen(@encode(UISwitch *))); i += strlen(@encode(UISwitch *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$MineViewController, @selector(isSubmitClick:), (IMP)&_logos_method$_ungrouped$MineViewController$isSubmitClick$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$MineViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$MineViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$MineViewController$viewDidLoad);} }
#line 162 "Tweak.x"
