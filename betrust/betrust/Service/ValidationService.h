#import <Foundation/Foundation.h>

@interface ValidationService : NSObject


-(BOOL) checkInputPhone: (NSString *) phone; // 登录是检查是否输入手机号

-(BOOL) checkLegalPhone: (NSString *) phone; // 登录是检查手机号是否合法

-(BOOL) checkInputVerifyCode: (NSString *) verifyCode; // 登录时检查是否输入验证码

-(BOOL) checkLegalVerifyCode: (NSString *) verifyCode; // 登录时检查验证码是否合法

-(BOOL) checkInputCode: (NSString *) code; // 检查验是否输入加密码

-(BOOL) checkInputName: (NSString *) name; // 认证时检查验是否输入用户名

-(BOOL) checkInputIDNo: (NSString *) idno; // 认证时检查是否输入身份证号

-(BOOL) checkLegalIDNo: (NSString *) idno; // 认证时检查输入的身份证号是否合法

-(BOOL) checkDoneFaceConfirm: (NSString *) result; // 认证时检查是否进行人脸识别

@end

