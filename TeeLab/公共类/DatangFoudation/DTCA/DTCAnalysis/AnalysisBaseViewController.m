/******************************************************
 * 模块名称:   AnalysisBaseViewController.c
 * 模块功能:   用户的页面只需要继承此模块，便会自动进行页面统计
 * 创建日期:   2012-10-8
 * 创建作者:   付大志
 *
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/


#import "Analysis.h"
#import "AnalysisBaseViewController.h"


@interface AnalysisBaseViewController ()

@end

@implementation AnalysisBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];	
    //得到类名
    Class class = self.class;
    char *str =  class_getName(class);
     NSString *viewName = [NSString stringWithCString: str];
    [Analysis enterViewController:viewName];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [Analysis exitViewController];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
