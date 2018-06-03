### 基于 APP 的移动端页面开发

#### APP 唤醒机制

每个 APP 通过沙盒机制进行隔离, 防止数据上的相互干扰

* URL Scheme

一个可以让 APP 相互之间可以跳转的协议;

```text
taobao://homepage
```

网页在 Safari 中通过地址栏跳转到 `taobao://homepage`, 从而跳转到淘宝首页;

```js
const utils = {
  openApp: (openUrl, callback) => {
    const ele = `<iframe src="${openUrl}" style="display: none" class="app_schemeIframe"></iframe>`;
    $('body').append(ele);
    const isopen = setTimeout(() => {
      $('.app_schemeIframe').remove();
      callback && callback(1);
    }, 800);
  },
  taobao_appGo: (app, href) => {
    this.openApp(app, opened => {
      if (opened) {
        // ... sucess
      } else {
        // 见 Tips 1 ; 当无法跳转时, 进入被选方案
        window.location.href = href;
      }
    });
  },
};
```

Tips:

    1.  在 iOS9 的 SDK 中, 若要通过 URL Scheme 访问其他 APP, 则需要事先将该 URL 加入程序的白名单中;

* UniversalLink

通过传统 HTTP 链接来启动 APP 的技术, 可以使用相同的网址打开网址的 APP;

#### Webview 详解

iOS : UIwebview, WKwebview

WKwebview 在 WWDC 2014 推出; 相比 UIwebview 拥有更快的加载速度和性能,更低的内存占用;

Android: webview

1.  Webpage 与 Native 双向协作

    * jsBridge

    * prompt

    * console.log

    * addJavascriptInterface

从以上 4 种方案中,选出一种既适合 iOS, 又适合 Android 的通讯协议;参考业界多数情况多数选择 jsBridge;

##### Webview - jsBridge

1.  Webpage 调用

1.  create iframe

1.  Native 截获 & 处理

1.  destroy iframe

正向通讯

```js
document.addEventListener(
  'WebViewJavascriptBridgeReady',
  () => {
    // ...
  },
  false
);
```

反向通讯, Native 调用 Webpage

<!-- 09:05 -->

```oc

```

##### Webview 的能力

1.  UA 重写

navigator.userAgent

```js
// "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36"
'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36 taobao/1.0.0';
```

1.  Cookies 写入 / 页面状态回调 / 更大存储容器

状态回调: onLoad, onShow, onHide

可以突破网页 5M 的限制

### webview 的坑?
