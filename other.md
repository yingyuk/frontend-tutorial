1.  rem 和其他单位之间的区别吗？

rem 基于 根元素字体大小;\
px 像素点; 高清屏 多个物理像素点;\
em 当前字体大小尺寸;\
vw 1%的视窗宽度;\
% 相对父元素

1.  圣杯布局

[圣杯布局 jsfiddle](https://jsfiddle.net/0nfvsj40/)

`float` + `position: reletive` + `[right, left]` + `[padding-left, padding-right]`

HTML 结构清晰语义化; main 优先渲染; CSS 相对复杂;
当要修改两侧宽度时, 需要关联修改的变量相对会多一些;

```html
<div id="content">
  <div class="main">main</div>
  <div class="left">left 100px</div>
  <div class="right">right 200px</div>
</div>
```

```css
#content {
  padding: 0 100px 0 200px;
}
.main {
  float: left;
  width: 100%;
  background: #39c;
  height: 300px;
}
.left {
  float: left;
  width: 100px;
  margin-left: -100%;
  background: #f60;
  height: 300px;
  position: relative;
  left: -100px;
}

.right {
  float: left;
  width: 200px;
  margin-left: -200px;
  background: #666;
  height: 300px;
  position: relative;
  right: -200px;
}
```

1.  双飞翼布局

[双飞翼布局 jsfiddle](https://jsfiddle.net/m0ndoow5/)

`float` + `[margin-left, margin-right]` + `一个子元素`

CSS 简单一些, 更加清晰; 不用相对布局, 但多了一个子元素, 但去掉了一个父元素, 元素层级变深;
main 优先渲染;

给最外层设置高度; 子元素 `height: 100%` 就可以等高了;

```html
<div class="wrap">
  <div class="main">main</div>
</div>
<div class="left">left 100px</div>
<div class="right">right 200px</div>
```

```css
.wrap {
  float: left;
  width: 100%;
}
.main {
  height: 300px;
  background: #39c;
  margin-left: 100px;
  margin-right: 200px;
}
.left {
  float: left;
  width: 100px;
  margin-left: -100%;
  background: #f60;
  height: 300px;
}

.right {
  float: left;
  width: 200px;
  margin-left: -200px;
  background: #666;
  height: 300px;
}
```

1.  flex 布局

[flex 布局 jsfiddle](https://jsfiddle.net/v8p3r3kk/)

拓展性更高; 只需修改一个变量;

```html
<div id="content">
  <div class="main">main</div>
  <div class="left">left 100px</div>
  <div class="right">right 200px</div>
</div>
```

```css
#content {
  display: flex;
  height: 300px;
}
.main {
  flex: 1;
  background: #39c;
}
.left {
  width: 100px;
  /* 让 main 优先渲染 */
  order: -1;
  background: #f60;
}
.right {
  width: 200px;
  background: #666;
}
```

1.  `__proto__`, `prototype`

```js
function Person(name, age) {
  this.name = name;
  this.age = age;
}

const pony = new Person('pony', 18);
```

`__proto__`:原型属性;
也就是[[Prototype]];
对象的原型属性; 指向该对象的构造函数的原型对象

```js
// Person.__proto__
Function.prototype;
```

`prototype`:普通属性;
指向该方法的原型对象;

```js
// Person.prototype
{
  constructor: f,
  __proto__: {}
}
// Person.prototype.__proto__
// 等于 Function.prototype.__proto__
// 等于 Object.prototype
```

| pony 人实例                                                | Person 人类                                                                                | Function 构造函数                                                                             | Object 对象                                                     |
| ---------------------------------------------------------- | ------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| `__proto__` === Person.prototype; 指向构造函数的 prototype | `__proto__` === Function.prototype; 指向构造函数的 prototype                               | `__proto__` === Function.prototype; 指向自身的 prototype                                      | `__proto__` === Function.prototype; 指向 Function 的 prototype  |
|                                                            | prototype : { constructor: Person, name, age, `__proto__`: Object.Prototype 一切皆是对象 } | prototype: { constructor: Function, call, apply, `__proto__`: Object.Prototype 一切皆是对象 } | prototype: { constructor: Object, toString, `__proto__`: null } |

先有的 Object.prototype， Object.prototype 构造出 Function.prototype，然后 Function.prototype 构造出 Object 和 Function。Object.prototype 是鸡，Object 和 Function 都是蛋。

```js
// new Class();
// Object.create();
Object.getPrototypeOf(someObj);
```

设置原型属性:

```js
Object.setPrototypeOf(obj, foo);
prototypeObj.isPrototypeOf(object);
```

1.  原型继承; 有一个 Parent，Son，让 Son 继承 Parent;？

四个点:

    * Son 的 `__proto__` 指向 Parent;
    * Son 的 `prototype.__proto__` 指向 Parent.prototype;
    * Son 的 `prototype.constructor` 指向 Son;
    * Son 内部; `Parent.call(this)`;

```js
function Parent(name) {
  this.name = name;
}
function Son(type) {
  this.type = type;
}
```

```js
Son.prototype = Object.create(Parent.prototype);

// 用原型链; B 继承 A 的属性

Son.__proto__ = Parent;
Son.prototype.__proto__ = Parent.prototype;

function setPrototypeOf(obj, proto) {
  obj.__proto__ = proto;
  return obj;
}
Object.setPrototypeOf(Son.prototype, Parent.prototype);
```

```js
function Animal() {
  this.species = '动物';
}
Animal.prototype.say = function() {
  console.log('say');
};

function Cat(name) {
  Animal.call(this);
  this.name = name;
}

function inherits(subClass, superClass) {
  // subClass.prototype.__proto__ = superClass.prototype
  subClass.prototype = Object.create(superClass.prototype, {
    constructor: {
      value: subClass,
      enumerable: false,
      writable: true,
      configurable: true,
    },
  });
  Object.setPrototypeOf
    ? Object.setPrototypeOf(subClass, superClass)
    : (subClass.__proto__ = superClass);
}

inherits(Cat, Animal);

const tom = new Cat('Tom');

console.log(tom.name);
console.log(tom.say);
console.log(tom.species);
```

1.  拷贝对象

递归的 Object.assign();

真实情况比较复杂; RegExp, Function, Date, Error, DOM 对象, 环形的对象 等等;

1.  Vue 双向绑定原理

订阅发布模式;
通过 Object.definedPropote 监听数据;
通知订阅者;
更新视图;

1.  vue-router

history.pushState;
window.onpopstate;

hashchange

1.  性能优化

- 降低请求量

  减少传输内容(压缩,首屏内容, webp);
  减少网络请求(合并资源, lazyLoad )

- 加快请求速度

  DNS 预解析, 并行加载; CDN, HTTP2, , 减少网络请求, 缓存,

- 缓存

  HTTP 协议缓存请求 etag, Expires; 离线缓存 manifest, service Workd，离线数据缓存 localStorage。

- 渲染

JS/CSS 优化,重绘回流; 浏览器绘制 Render Tree, GPU;
加载顺序;
webWorker 多线程;
服务端渲染，pipeline;

webview 内:
预先初始化 webview; 预加载数据;
使用离线包; 公共资源;

1.  传输模型

- DNS 查找;
- 建立连接

三次握手的好处: 发送方可以确认接收方仍然在线，不会因为白发送而浪费资源;
原因是 TCP/IP 是全双工;每个方向都必须单独进行开启关闭

- 发送 http 请求;

http 是无连接,无状态的; 每次传输完成后就会断开;
http/1.1 开始支持 持久连接;

- 服务器发送响应四次挥手;

客户端与服务端通过 http 协议通讯;

- 客户端收到文档, 渲染页面;

HTML 解析 -> DOM Tree
STYLE 解析 -> Style Rules
-> Render Tree + Layout
-> painting 绘制 -> display 显示

1.  HTTP

    - 长连接
      `HTTP/1.0` 需要使用 `keep-alive` 参数来告知服务器建立长连接，而 `HTTP/1.1` 默认支持长连接，减少了 TCP 连接次数，节约开销。

    - 节约带宽

    `HTTP/1.1` 支持只发送 header 信息(不带任何 body 信息)，如果服务器认为客户端有权限请求服务器，则返回 100，否则返回 401。客户端只有接收到 100，才开始把请求 body 发到服务器。当服务器返回 401 的时候，客户端就可以不用发送请求 body 了，这样节约了带宽。

    - HOST 域

      `HTTP/1.1` 支持 host 域，服务端可以通过 host 域设置多个虚拟站点来共享一个 ip 和端口。

1.  HTTP2

    - 多路复用

    `HTTP/2.0` 使用多路复用技术，使用一个 TCP 连接并发处理多个请求，不但节约了开销而且可处理请求的数量也比`HTTP/1.1`大了很多。

    - 头部压缩

    HTTP 1.1 不支持 header 数据压缩，HTTP 2.0 使用 HPACK 算法对 header 的数据进行压缩，使得数据传输更快。

    - 服务器推送

    当我们对支持 HTTP 2.0 的服务器请求数据额时候，服务器会顺便把一些客户端需要的资源一起推送到服务器，这种方式适用于加载静态资源，节约带宽

1.  HTTPS

    - HTTP 的缺点

    使用明文通信，内容可能会被窃听不验证通信双方身份，有可能遭遇伪装无法证明报文的完整性，内容可能遭到篡改

    - HTTPS = HTTP + TLS/SSL 加密 + 认证 + 完整性保护

    HTTPS 过程:

    TLS/SSL 内容加密;
    数字证书验明身份;
    MD5、SHA-1 等散列值方法防止篡改;

          * 客户端告诉服务器 协议号, 支持哪些加密方式, 随机数
          * 服务器端返回 加密方式, 数字证书[公钥,数字签名], 随机数;
          * 客户端用自带的第三方权威机构的公钥,对数组签名进行解密;再根据签名生成规则对网站信息进行本地签名生成;签名对比判断来自服务器的公钥是正确的;并使用数字证书的公钥加密这个随机数;
          * 客户端生成随机对称密钥;使用服务端的公钥加密 '对称密钥';发送加密后的 '对称密钥' 给服务器
          * 通过对称密钥加密的密文通讯

    数字签名是为了防止 中间人修改网站信息;

1.  TCP/IP 四层模型;

应用层,传输层,网络层

| 层         | xx                   |
| ---------- | -------------------- |
| 应用层     | HTTP,Telnet,FTP,TFTP |
| 传输层     | TCP/UDP              |
| 网络层     | IP                   |
| 数据链路层 | Ethernet,802.3,PPP   |
| 物理层     | 接口和线缆           |

应用层: 决定了向用户提供应用服务时通信的活动。

数据加密、解密、压缩、解压缩；定义数据表示的标准

1.  移动端 300 毫秒延迟

2015 年后的浏览器不再有 300ms 延迟;

```js
// 监听元素的触摸事件 touchEnd;
// 取触摸事件的第一个手指, 合成并触发一个点击事件
clickEvent = document.createEvent('MouseEvents');
```

1.  http 缓存

    - 强缓存
      200 from cache

    Expires, Cache-Control, 缓存时间, Etag, Last-Modified;

    Expires: HTTP1.0 规范; GMT 时间;如果发送时间在 Expires 之前,本地缓存始终有效;

    Cache-Control: max-age=number, HTTP1.1; 资源第一次请求时间 + max-age 对比 当前请求时间; 如果请求时间在过期时间之前，就能命中缓存

    no-cache: 不使用本地缓存, 使用缓存协商;
    no-store: 禁止浏览器缓存资源;
    public: 可以被所有用户缓存资源,包括终端用户和 cdn, 中间代理服务器;
    private: 只能被终端用户浏览器缓存;不允许 cdn 等缓存;

    优先级: Cache-Control > Expires

    - 协商缓存

      304 not modified

      Last-modified/if-modified-since;
      第一次请求资源,服务器返回 最后修改时间;
      之后再请求资源,浏览器携带 if-modified-since(来自上次的 Last-modified); 服务器根据传来的时间判断资源是否变化;
      如果没有变,只返回 304,并不返回资源内容,也没有 Last-modified(因为资源没有变动);
      如果变化了,发送新版的资源,并更新 Last-modified

      Etag/If-None-Match;
      这两个值是由服务器生成的每个资源的唯一标识字符串，只要资源有变化就这个值就会改变；
      判断过程类似于 Last-modified; 区别在于 304 时,也会返回 Etag

      Etag 和 Last-modified 的区别
      Etag 解决了 Last-modified 的一些问题; 1.文件内容没有修改,文件保存时间修改了,这个时候不希望客户端认为文件修改了;
      2.Last-modified 的细粒度是秒级别的,无法保证获取到的是最新的文件;
      所以优先级 Etag > Last-modified

1)  移动端点击穿透

产生的原因是, click 比 touchend 慢;
touchend 触发时,隐藏了被点击的按钮,等 click 触发时,下层的被触发了 click 事件;
最好是不要同时使用 touch 和 click;

上层元素 用动画隐藏; 或者下层元素 添加 C3 `pointer-events: none`, `pointer-events: auto`

1.  Promise async await; Generator

一个 promise 代表一次异步操作;
生成后立即执行;
pengding -> Fulfilled 成功;
pengding -> Rejected 失败;

1.  cookie , session

1.  跨域

jsonp 和 CORS

1.  微信扫一扫二维码网页上登陆前后端过程

1.  Vue 中 Compile 过程

1.  箭头函数和普通函数

1.  双向绑定的原理

1.  兼容性问题

1.  rem 和 em 有什么去区别

1.  事件委托

1.  null 和 undefined 有什么区别

1.  判断基本的数据类型

1.  判断数组

1.  原型链和作用域链你的理解

1.  合并 HTTP 请求

现在已经是 http2 了;

DNS 解析(T1) -> 建立 TCP 连接(T2) -> 发送请求(T3) -> 等待服务器返回首字节（TTFB）(T4) -> 接收数据(T5)。

浏览器会缓存 DNS 信息，因此不是每次请求都需要 DNS 解析。
HTTP 1.1 keep-alive 的特性，使 HTTP 请求可以复用已有 TCP 连接，所以并不是每个 HTTP 请求都需要建立新的 TCP 连接。
浏览器可以并行发送多个 HTTP 请求，同样可能影响到资源的下载时间，而上面的分析显然只是基于同一时刻只有 1 个 HTTP 请求的场景。

对于大文件: HTTP 的传输通道是基于 TCP 连接的，而 TCP 连接具有慢启动的特性，刚开始时并没有充分利用网络带宽，经过慢启动过程后，逐渐占满可利用的带宽。
大文件的合并加载时间差可以忽略不计;

对于小文件: 多个 HTTP 连接本身就存在额外的资源消耗,每个 HTTP 的 DNS 查询时间、TCP 连接的建立时间等也存在一定的随机性，这就导致并发请求资源时，出现某个 HTTP 耗时明显增加的可能性变大。
