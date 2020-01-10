
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
+ (instancetype)shareInstance
{
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

//详情
%hook HWShopDetailsViewController

@interface HWShopDetailsBottomView : UIView

@property(retain, nonatomic) UIButton *buyButton; 

- (void)clickEvent:(id)arg;

@end

@interface HWShopDetailsViewController : UIViewController

@property(retain, nonatomic) HWShopDetailsBottomView *bottomView; 

@end

%new
- (void)singleTap:(NSTimer *)timer{

    if (self.bottomView.buyButton && [DMManager shareInstance].isOpen) {
        [timer invalidate];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(960 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            [self.bottomView clickEvent:self.bottomView.buyButton];
        });
    }
}
- (void)viewDidLoad{
    %orig;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(singleTap:) userInfo:nil repeats:NO];
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    double hourSecond = 60 * 30;
    double hours = ceil(time/hourSecond);
    //提前一秒触发计时器
    NSDate *fireDate = [NSDate dateWithTimeIntervalSince1970:hours * hourSecond - 1];
    [timer setFireDate:fireDate];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
%end


//提交订单
%hook HWGoodsDiyPackageEntranceController

@interface HWGoodsDiyPackageCheckBottomView : UIView

@property (nonatomic, strong) UIButton *checkOutButton;

-(void)checkOutEvent;

@end

@interface HWGoodsDiyPackageEntranceController : UIViewController


@property(retain, nonatomic) HWGoodsDiyPackageCheckBottomView *checkOutBottomView;

@end

%new
- (void)displayLink:(CADisplayLink *)link{
    if (self.checkOutBottomView.checkOutButton && [DMManager shareInstance].isSubmit) {
         [link invalidate];
        [self.checkOutBottomView checkOutEvent];
    }
}

- (void)viewDidLoad{
	%orig;
	if([DMManager shareInstance].isSubmit){
		CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLink:)];
    	[link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];	
	}
}
%end



%hook MineViewController

@interface MineViewController : UIViewController

@end

%new
- (void)isOpenClick:(UISwitch *)isOpen{
    [DMManager shareInstance].isOpen = isOpen.on;
}
%new
- (void)isSubmitClick:(UISwitch *)isOpen{
    [DMManager shareInstance].isSubmit = isOpen.on;
}

- (void)viewDidLoad{
    %orig;

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

%end 

