---
title: Ajax
date: 2018-06-06 15:29:43
---

### XHR 对象

IE10+

```js
new XMLHttpRequest();
```

属性:

| 属性名             | 描述                                   |
| ------------------ | -------------------------------------- |
| readyState         | 状态                                   |
| onreadystatechange | 状态改变处理                           |
| response           | 响应实体                               |
| responseType       | 指定响应类型                           |
| status             | 请求状态码, 只读                       |
| statusText         | 请求的响应状态信息                     |
| upload             | 在 upload 上添加事件监听来跟踪上传过程 |

readyState:

| 值  | 状态             | 描述                 |
| --- | ---------------- | -------------------- |
| 0   | UNSENT           | 没有被发送           |
| 1   | OPENED           | 请求被打开, 没有发送 |
| 2   | HEADERS_RECEIVED | 已经发送             |
| 3   | LOADING          | 发送中               |
| 4   | DONE             | 发送完成             |

responseType:

| 值            | 状态        |
| ------------- | ----------- |
| ""            | 默认字符串  |
| "arrayBuffer" | arrayBuffer |
| "blob"        | 二进制数据  |
| "document"    | document    |
| "json"        | json        |
| "text"        | 字符串      |

1.  方法

- 初始化请求

  XMLHttpRequest.open(method, url, async, user, password)

- 设置请求头信息

  XMLHttpRequest.setRequestHeader(header, value)

- 发送请求

  XMLHttpRequest.send(body)

```js
var xhr = new XMLHttpRequest(),
  method = 'GET',
  url = 'https://developer.mozilla.org/';

xhr.open(method, url, true);
// xhr.onload = function() {
//   // Request finished. Do processing here.
// };
xhr.onreadystatechange = function(callback) {
  if (xhr.readyState === 4) {
    if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304) {
      callback(xhr.responseText);
    } else {
      console.error('failed', xhr.status);
    }
  }
};

xhr.send(null);
// xhr.send('string');
// xhr.send(new Blob());
// xhr.send(new Int8Array());
// xhr.send({ form: 'data' });
// xhr.send(document);
```

1.  ajax 跨域

- 同源策略

  - 浏览器限制来自不同源的文档或脚本,对当前文档读取或者设置某些属性;

  - 两个页面用相同的协议 (protocal) , 端口(port) 和 主机(host); 那么这两个页面属于同一个源( origin)

- 跨资源访问

  - CORS (Cross-Origin Resource Sharing)

    XHR level2 才支持;

    服务器设置接受跨域请求, 浏览器预请求检测; 响应再进行一次跨域检测;

  - iframe 代理

    利用 iframe 嵌入目标站点; 目标站点需要部署代理站点, 代理页面一般会设置白名单;

    - message
    - widnow.name 兼容低版本浏览器, 无法并发
    - document.domain

  - JSONP

    利用 script 标签可以跨域, 请求一段 js 代码;
    但只能用于 GET 请求;

#### ActiveXObject (IE 低版本)
