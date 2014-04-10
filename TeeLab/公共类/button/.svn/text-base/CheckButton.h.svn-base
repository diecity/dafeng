

#import <UIKit/UIKit.h>

struct MARGIN{int left;int right;int top; int bottom;};

typedef void(^SelectedBlock)(BOOL isSelected);
@interface CheckButton : UIButton

@property (nonatomic,copy) NSString *name;//显示的名字
@property (nonatomic,assign) float fontSize;//字体大小
@property (nonatomic, assign) struct MARGIN btn_margin;//选择框的  左右上下边距(相对于父控件)
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isUnClickable;
@property (nonatomic, copy) SelectedBlock selectedBlock;

-(id) initWithFrame:(CGRect)frame andName:(NSString*)name;
-(id) initWithFrame:(CGRect)frame andName:(NSString*)name andSelectedBlock:(void(^)(BOOL isSelected))block;
- (void)setIsSelected:(BOOL)isSelectedTemp;
-(void)registerClickAcitonListener:(void(^)(BOOL isSelected))block;
@end
