#### 接口
```
获取国家和地区码: /api/sms/country
- 参数
- 无

-返回值
{
    "error_code":0,
    "message":"",
    "data":[
        {
            "86":"中国"
        },
        {
            "1":"美国"
        },
        {
            "81":"日本"
        },
        {
            "61":"澳大利亚"
        },
        {
            "64":"新西兰"
        },
        {
            "1":"加拿大"
        },
        {
            "44":"英国"
        },
        {
            "33":"法国"
        },
        {
            "45":"丹麦"
        },
        {
            "31":"荷兰"
        },
        {
            "39":"意大利"
        },
        {
            "852":"中国香港"
        },
        {
            "886":"中国台湾"
        }
    ]
}
```

```
发送短信接口: /api/sms/send
- 参数
- phone_number:String | 手机号 | 必填
- token:String | 参数加密后的MD5 | 必填
- nonceStr:String | 随机数,6位中英文混合 | 必填
- country_code:String | 国家编号 | 必填

-返回值
 {
    "error_code":0,
    "message":"",
    "data":{
    "success":true
    }
 }
```

```
校验短信接口: /api/sms/verify
- 参数
- phone_number:String | 手机号 | 必填
- code:String | 收到的验证码 | 必填
- country_code:String | 国家编号 | 必填

- 返回值
{
    "error_code":0,
    "message":"",
    "data":{
        "verify_token":"B9IqBZ3K1Fmm8GnoDTmZcHmoGyNkVhHYanrM5RazSniwZvlvCuCGfy9KO2iQEGjN"
    }
 }
```

```
注册/登录: /api/user/login
- 参数
- phone_number:String | 手机号 | 必填
- verify_token:String | 校验短信返回的verify_token | 必填
- country_code:String | 国家编号 | 必填

- 返回值
{
    "error_code": 0,
    "message": "",
    "data": {
        "user": {
            "id": 1,
            "username": null,
            "phone_number": "11112345678",
            "phone_country": "86",
            "device_id": 1
        },
        "token": "WxP2Be4jW0LG7YGIA9tDfXpHj5U9hKTbIRvX12ze3HlDgvoAwMkbxSJhan8mdRlM"
    }
}
```
