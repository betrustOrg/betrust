#import "ValidationService.h"

@interface ValidationService ()

@end

@implementation ValidationService

// 登录是检查是否输入手机号
-(BOOL) checkInputPhone: (NSString *) phone {
    if (phone == nil) {
        return NO;
    }
    return YES;
}

// 登录是检查手机号是否合法
-(BOOL) checkLegalPhone: (NSString *) phone {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,1703,1705,1706,198,148,1440
     * 联通：130,131,132,155,156,185,186,176,175,145,171,1707,1708,1709,166,146
     * 电信：133,1349,153,180,189,181,177,173,149,1700,1701,1702,199,1410
     */
    NSString * MOBILE = @"^1(3[0-9]|4[0-9]|5[0-9]|6[0-9]|7[0-9]|8[0-9]|9[0-9])\\\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

    if (([regextestmobile evaluateWithObject:phone] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

// 登录时检查是否输入验证码
-(BOOL) checkInputVerifyCode: (NSString *) verifyCode {
    if (verifyCode == nil) {
        return NO;
    }
    return YES;
}

// 登录时检查验证码是否合法 6位纯数字
-(BOOL) checkLegalVerifyCode: (NSString *) verifyCode {

    if (verifyCode.length == 6) {
        NSScanner* scan = [NSScanner scannerWithString:verifyCode];

        int val;
        return [scan scanInt:&val] && [scan isAtEnd];
    }
    return NO;
}

// 检查验是否输入加密码
-(BOOL) checkInputCode: (NSString *) code {
    if (code == nil) {
        return NO;
    }
    return YES;
}

// 认证时检查验是否输入用户名
-(BOOL) checkInputName: (NSString *) name {
    if (name == nil) {
        return NO;
    }
    return YES;
}

// 认证时检查是否输入身份证号
-(BOOL) checkInputIDNo: (NSString *) idno {
    if (idno == nil) {
        return NO;
    }
    return YES;
}

// 认证时检查输入的身份证号是否合法
-(BOOL) checkLegalIDNo: (NSString *) idno {
    if (idno == nil) {
        return NO;
    }
    return YES;
}

// 认证时检查是否进行人脸识别
-(BOOL) checkDoneFaceConfirm: (NSString *) result {
    if (result == nil) {
        return NO;
    }
    return YES;
}

@end
