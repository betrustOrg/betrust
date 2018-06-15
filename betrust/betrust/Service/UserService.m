#import "UserService.h"

#import <FaceVerifyIdPaaSLib/QCMediaPicker.h>
#import <FaceVerifyIdPaaSLib/QCLocalAuthorizationGenerator.h>
#import <FaceVerifyIdPaaSLib/QCHttpEngine.h>

@interface UserService ()

@end

@implementation UserService {
    NSURLSessionDataTask *_currentTask;
}

@synthesize userIdentity;
@synthesize userId;
@synthesize userCountry;


-(BOOL) checkUserLogin {
    if (userId != nil) {
        return YES;
    }
    return NO;
}

-(BOOL) checkUserIdentity {
    if (userIdentity != 0) {
        return YES;
    }
    return NO;
}


- (void)onSendBtnClick {
    //[self.view endEditing:YES];//收起键盘
    
    NSString *apiUrl = @"http://recognition.image.myqcloud.com/face/idcardlivedetectfour";
    NSString *sign = [QCLocalAuthorizationGenerator signWithAppId:APP_ID secretId:SECRET_ID secretKey:SECRET_KEY];
    NSString *validate_data = @"";//[_validateDataField text];
    NSString *videoFile = @"";//[_videoFileField text];
    NSString *idcard_name = @"";//[_nameField text];
    NSString *idcard_number = @"";//[_idNumberField text];
    NSString *seq = @"";//[_seqField text];
    
    //活体核身（通过视频和身份证信息）
    //参考文档 https://cloud.tencent.com/document/product/641/12430
    _currentTask = [QCHttpEngine postFormDataTo:apiUrl
                                        headers:@{@"Authorization": sign}
                                         params:@{@"appid": APP_ID,
                                                  @"validate_data": validate_data,
                                                  @"idcard_number": idcard_number,
                                                  @"idcard_name": idcard_name,
                                                  @"seq": seq}
                                          files:@{@"video": videoFile}
                                     onProgress:^(float percent) {
                                         NSString *msg = [NSString stringWithFormat:@"progress: %.2f%%", percent];
                                         NSLog(@"%@", msg);
                                         //[Logger log:msg andPrintTo:_logText];
                                     }
                                   onCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
                                       _currentTask = nil;
                                       if (error) {
                                           //错误处理
                                           //[Logger to:_logText format:@"onCompletion: error = %@", error];
                                       } else {
                                           //结果转换成 NSString
                                           NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                           NSLog(@"%@", string);
                                           //[Logger to:_logText format:@"%@", string];
                                           //结果转换成 NSDictionary
                                           NSError *e = nil;
                                           NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&e];
                                           if (!dic) {//转换 NSDictionary 失败
                                               //[Logger to:_logText format:@"%@ 转换 NSDictionary 失败, error = %@", string, e];
                                           } else {
                                               NSInteger code = [dic[@"code"] integerValue];
                                               if (code != 0) {//返回码不是0
                                                  // [Logger to:_logText format:@"错误码: %d, 错误信息: %@", code, dic[@"message"]];
                                               } else {//成功, 获取内容
                                                   NSInteger live_status = [dic[@"data"][@"live_status"] integerValue];
                                                   NSLog(@"%ld", live_status);
                                                   //[Logger to:_logText format:@"活体核身: %@", live_status == 0 ? @"通过" : @"不通过"];
                                               }
                                           }
                                       }
                                   }];
}

@end
