//
//  Created by 张文晏
//  Copyright © 2016年 张文晏. All rights reserved.
//
#import "ViewController.h"
#import "DrawView.h"
#import "PhotoView.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet DrawView *drawView;

@property (nonatomic, weak) PhotoView *photoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark
#pragma mark - 返回
- (IBAction)back:(id)sender {
    
    [_drawView back];
}


#pragma mark
#pragma mark - 清屏
- (IBAction)clear:(id)sender {
    
    [_drawView clear];
}

#pragma mark
#pragma mark - 橡皮
- (IBAction)rubber:(id)sender {
    
    [_drawView rubber];
}

#pragma mark
#pragma mark - 照片
- (IBAction)photo:(id)sender {
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    
    // 资源类型
    // UIImagePickerControllerSourceTypeSavedPhotosAlbum 时刻
    // UIImagePickerControllerSourceTypeCamera 相机
    // UIImagePickerControllerSourceTypePhotoLibrary 图片汇总
    pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // 设置代理
    pickerController.delegate = self;
    
    
    [self presentViewController:pickerController animated:YES completion:nil];
    
}


#pragma mark
#pragma mark - imagePicker的 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 取出被选择的照片
    UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
    
    
    // 创建一个view, 用来展示 用户选择的图片
    PhotoView *photoView = [[PhotoView alloc] initWithFrame:_drawView.frame];
    
    self.photoView = photoView;
    
    // 为 photoView 的 image 赋值
    photoView.image = selectImage;
    
    
    __weak ViewController *weakSelf = self;
    
    // 为tempBlock 赋值
    photoView.tempBlock = ^(UIImage *image){
        
        // 把image 传递给 drawView
        weakSelf.drawView.image = image;
        
        // 把photoView 给移除掉
        [weakSelf.photoView removeFromSuperview];
        
    };
    
    
    [self.view addSubview:photoView];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark
#pragma mark - 保存
- (IBAction)save:(id)sender {
    // 1. 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(_drawView.frame.size, NO, 0);
    
    // 2. 获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 3. 把 drawView 的 layer 渲染到当前上下文中
    [_drawView.layer renderInContext:context];
    
    // 4. 从当前的图片上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    // 5. 关闭上下文
    UIGraphicsEndImageContext();
    
    // 6. 保存到相册
    UIImageWriteToSavedPhotosAlbum(image, nil , nil, nil);
    
    //  第一个参数, image , 第二个参数: 压缩比例
    //    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    
}

#pragma mark
#pragma mark - slider
- (IBAction)sliderValueChaged:(UISlider *)sender {
    
    _drawView.lineWidth = sender.value;
}

#pragma mark
#pragma mark - 颜色 按钮
- (IBAction)colorButton:(UIButton *)sender {
    
    _drawView.lineColor = sender.backgroundColor;
    
}


@end
