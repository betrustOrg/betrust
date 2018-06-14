#import "ValidationService.h"
#import <dlfcn.h>

#include <sys/stat.h>

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
    BOOL flag;
    if (idno.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate  predicateWithFormat:@"SELF MATCHES %@", regex2];
    return [identityCardPredicate evaluateWithObject:idno];
}

// 认证时检查是否进行人脸识别
-(BOOL) checkDoneFaceConfirm: (NSString *) result {
    if (result == nil) {
        return NO;
    }
    return YES;
}

// 判断越狱文件是否存在
-(BOOL) isJailBreakToolPath {
    NSArray *jailbreak_tool_paths = @[
                                      @"/Applications/Cydia.app",
                                      @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                                      @"/bin/bash",
                                      @"/usr/sbin/sshd",
                                      @"/etc/apt"
                                      ];
    

    for (int i = 0; i < jailbreak_tool_paths.count; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:jailbreak_tool_paths[i]]) {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

// 根据是否能打开cydia判断
-(BOOL) isJailBreakOpenCydia {
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]){
        return YES;
    }
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        NSLog(@"The device is jail broken!");
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

// 读取所有应用名称的权限的
-(BOOL) isJailBreakGetAppName {
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]) {
        NSLog(@"The device is jail broken!");
        NSArray *appList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/User/Applications/" error:nil];
        NSLog(@"appList = %@", appList);
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

//检测是否是系统动态库
-(BOOL) checkIsSystemInject {
    int ret;
    Dl_info dylib_info;
    int (*func_stat)(const char*, struct stat*) = stat;
    char *dylib_name = "/usr/lib/system/libsystem_kernel.dylib";
    if ((ret = dladdr(func_stat, &dylib_info)) && strncmp(dylib_info.dli_fname, dylib_name, strlen(dylib_name))) {
        // Device is jailbroken
        return NO;
    }
    return YES;

}
// 检测Cydia等工具
-(BOOL) checkIsExistCydia {
    struct stat stat_info;
    //原始判断if (!checkInject()) {
    if ([self checkIsSystemInject] == NO) {
        if (0 == stat("/Applications/Cydia.app", &stat_info)) {
            // Device is jailbroken
            return YES;
        }
    } else {
        return NO;
    }
    return NO;
}

char* printEnv(void) {
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    NSLog(@"%s", env);
    return env;
}
// 检测当前程序运行的环境变量 如果printEnv不为null 被越狱
-(BOOL) isJailBreakSystemParam {
    if (printEnv()) {
        NSLog(@"The device is jail broken!");
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

-(BOOL) isJailBreakCydiaStat {
    // 判断系统动态库和stat放在一起
    return [self checkIsExistCydia] == YES ? YES : NO;
}
// 返回越狱数据得字典 比较简单  复杂的思路可以参考http://www.cnblogs.com/lingzhao/p/3415154.html
-(NSDictionary *) checkSystemResult {
    NSDictionary *checkResult = [NSDictionary dictionaryWithObjectsAndKeys: @"1", @"toolPath", @"1", @"openCydia", @"1", @"getAppName", @"1", @"systemParam", @"1", @"cydiaStat", nil];
    if ([self isJailBreakToolPath] == NO) {
        [checkResult setValue:@"0" forKey:@"toolPath"];
    }
    
    if ([self isJailBreakOpenCydia] == NO) {
        [checkResult setValue:@"0" forKey:@"openCydia"];
    }
    
    if ([self isJailBreakGetAppName] == NO) {
        [checkResult setValue:@"0" forKey:@"getAppName"];
    }
    
    if ([self isJailBreakSystemParam] == NO) {
        [checkResult setValue:@"0" forKey:@"systemParam"];
    }
    
    if ([self isJailBreakCydiaStat] == NO) {
        [checkResult setValue:@"0" forKey:@"cydiaStat"];
    }
    return checkResult;
}

@end
