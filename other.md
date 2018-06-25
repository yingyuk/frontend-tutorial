### rem 和其他单位之间的区别吗？

rem 基于 根元素字体大小;\
px 像素点; 高清屏 多个物理像素点;\
em 当前字体大小尺寸;\
vw 1%的视窗宽度;\
% 相对父元素

### 文本溢出点点点

```css
/* 单行 */
.f-toe {
  overflow: hidden;
  text-overflow: ellipsis;
  word-break: normal;
  white-space: nowrap;
}
/* 多行 */
.f-toe {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  word-break: break-all;
  overflow: hidden;
}
```

### 左右布局

```html
<div class="parent">
  <div class="left">left</div>
  <div class="right">right</div>
</div>
```

1.  float + margin

```css
.left {
  float: left;
  width: 100px;
}
.right {
  margin-left: 100px;
}
```

1.  float + overflow

```css
.left {
  float: left;
  width: 100px;
}
.right {
  overflow: hidden;
}
```

1.  flex

```css
.parent {
  display: flex;
}
.left {
  width: 100px;
}
.right {
  flex: 1;
}
```

1.  grid

```css
.parent {
  display: grid;
  grid-template-columns: 100px 1fr;
}
```

1.  table

```css
.parent {
  display: table;
  /* table 默认是内容宽度, 这里重设宽度 */
  width: 100%;
  table-layout: fixed;
}
.left {
  width: 100px;
  display: table-cell;
}
.right {
  display: table-cell;
}
```

### 圣杯布局

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

### 双飞翼布局

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

### flex 布局

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

### `__proto__`, `prototype`

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

### 原型继承; 有一个 Parent，Son，让 Son 继承 Parent;？

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

### 拷贝对象

递归的 Object.assign();

真实情况比较复杂; RegExp, Function, Date, Error, DOM 对象, 环形的对象 等等;

node.cloneNode()

### Vue 双向绑定原理

订阅发布模式;
通过 Object.definedPropote 监听数据;
通知订阅者;
更新视图;

### vue-router

history.pushState;
window.onpopstate;

hashchange

### 性能优化

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

### 传输模型

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

### HTTP

    - 长连接
      `HTTP/1.0` 需要使用 `keep-alive` 参数来告知服务器建立长连接，而 `HTTP/1.1` 默认支持长连接，减少了 TCP 连接次数，节约开销。

    - 节约带宽

    `HTTP/1.1` 支持只发送 header 信息(不带任何 body 信息)，如果服务器认为客户端有权限请求服务器，则返回 100，否则返回 401。客户端只有接收到 100，才开始把请求 body 发到服务器。当服务器返回 401 的时候，客户端就可以不用发送请求 body 了，这样节约了带宽。

    - HOST 域

      `HTTP/1.1` 支持 host 域，服务端可以通过 host 域设置多个虚拟站点来共享一个 ip 和端口。

### HTTP2

    - 多路复用

    `HTTP/2.0` 使用多路复用技术，使用一个 TCP 连接并发处理多个请求，不但节约了开销而且可处理请求的数量也比`HTTP/1.1`大了很多。

    - 头部压缩

    HTTP 1.1 不支持 header 数据压缩，HTTP 2.0 使用 HPACK 算法对 header 的数据进行压缩，使得数据传输更快。

    - 服务器推送

    当我们对支持 HTTP 2.0 的服务器请求数据额时候，服务器会顺便把一些客户端需要的资源一起推送到服务器，这种方式适用于加载静态资源，节约带宽

### HTTPS

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

### TCP/IP 四层模型;

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

### 移动端 300 毫秒延迟

2015 年后的浏览器不再有 300ms 延迟;

```js
// 监听元素的触摸事件 touchEnd;
// 取触摸事件的第一个手指, 合成并触发一个点击事件
clickEvent = document.createEvent('MouseEvents');
```

### http 缓存

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

### 移动端点击穿透

产生的原因是, click 比 touchend 慢;
touchend 触发时,隐藏了被点击的按钮,等 click 触发时,下层的被触发了 click 事件;
最好是不要同时使用 touch 和 click;

上层元素 用动画隐藏; 或者下层元素 添加 C3 `pointer-events: none`, `pointer-events: auto`

### Promise async await; Generator

一个 promise 代表一次异步操作;
生成后立即执行;
pengding -> Fulfilled 成功;
pengding -> Rejected 失败;

GeneratorObj.next;
GeneratorObj.return;
GeneratorObj.throw;

GeneratorObj[Sybmol.iterator]

### cookie , session

    常用于会话管理;

    缺陷:

    - 4kb 大小限制, 因为会携带在请求头部, 有时候会导致头部过大;
    - 安全性
    - 流量代价

    替代品:

    - Web Storage
    - IndexDB

    cookie 格式:

    - value
      name=value
    - expires
      过期时间, UTC
    - domain
      当前域名, 或者子域
    - path
      请求资源必须包含指定路径时, 才发送 cookie
    - secure
      安全标记, 没有值; 使用 https 协议时才生效;

### 跨域

jsonp 和 CORS

### 微信扫一扫二维码网页上登陆前后端过程

### Vue 中 Compile 过程

数据代理, 模板解析, 数据劫持

### 箭头函数和普通函数

    1.  没有 this, super, arguments 和 `new.target`, 它们是里箭头函数最近的非箭头函数;

    1.  不能使用 new 来调用

    1.  没有原型对象

    1.  内部的 this 无法改变

    1.  形参名称不能重复;

### 判断基本的数据类型

typeof 可以判断基本类型;
判断对象类型的时候, 总是返回 'object';

instanceof 判断是否是给定类型的实例, 还可以识别自定义对象类型,但无法识别原始类型;

constructor 检测变量的构造函数,也可检测自定义类型; 原型继承时, 有些时候, 会失效;

Object.prototype.toString.call 无法识别自定义对象的具体类型

| 方法                      | 小结                                                                                     |
| ------------------------- | ---------------------------------------------------------------------------------------- |
| typeof                    | 无法识别具体的对象类型, 适合检测变量是否定义                                             |
| instanceof                | 无法检测原始类型, 跨 iframe 失效                                                         |
| constructor               | 不检查原型链, 无法检测 null 和 undefined, 跨 iframe 失效, 有浏览器兼容问题, 某些场景失效 |
| Object.prototype.toString | 可以检测 原生对象, 无法识别自定义对象的具体类型                                          |

### 判断数组

```js
Array.isArray([]); // true
Object.prototype.toString.call([]).slice(8, -1) === 'Array'; // true
```

### 合并 HTTP 请求

现在已经是 http2 了;

DNS 解析(T1) -> 建立 TCP 连接(T2) -> 发送请求(T3) -> 等待服务器返回首字节（TTFB）(T4) -> 接收数据(T5)。

浏览器会缓存 DNS 信息，因此不是每次请求都需要 DNS 解析。
HTTP 1.1 keep-alive 的特性，使 HTTP 请求可以复用已有 TCP 连接，所以并不是每个 HTTP 请求都需要建立新的 TCP 连接。
浏览器可以并行发送多个 HTTP 请求，同样可能影响到资源的下载时间，而上面的分析显然只是基于同一时刻只有 1 个 HTTP 请求的场景。

对于大文件: HTTP 的传输通道是基于 TCP 连接的，而 TCP 连接具有慢启动的特性，刚开始时并没有充分利用网络带宽，经过慢启动过程后，逐渐占满可利用的带宽。
大文件的合并加载时间差可以忽略不计;

对于小文件: 多个 HTTP 连接本身就存在额外的资源消耗,每个 HTTP 的 DNS 查询时间、TCP 连接的建立时间等也存在一定的随机性，这就导致并发请求资源时，出现某个 HTTP 耗时明显增加的可能性变大。

### Virtual DOM

通过 JS 来模拟创建 DOM 对象;
判断两个对象的差异;
渲染差异;

### Event Loop

1.  所有同步任务都在主线程上执行，形成一个执行栈;
1.  主线程之外，还存在一个任务队列。只要异步任务有了运行结果，就在任务队列之中放置一个事件。
1.  一旦执行栈中的所有同步任务执行完毕，系统就会读取任务队列,将队列中的事件放到执行栈中依次执行
1.  主线程从任务队列中读取事件，这个过程是循环不断的

- 宏任务

setTimeout, setInterval, setImmediate, I/O

- 微任务

process.nextTick,
原生 Promise(有些实现的 promise 将 then 方法放到了宏任务中),MutationObserver 不兼容的，MessageChannel(消息通道，类似 worker)

同步代码执行栈中>微任务>宏任务

### AMD, CMD, CommonJS

目的都是为了 JavaScript 的模块化开发。

AMD 是 RequireJS 在推广过程中对模块定义的规范化产出。
CMD 是 SeaJS 在推广过程中对模块定义的规范化产出。
NodeJS 是 CommonJS 规范的实现。
[JavaScript modules via script tag](https://caniuse.com/#search=script)

```js
// CommonJS
var module = {
  exports: {},
};

(function(module, exports) {
  exports.multiply = function(n) {
    return n * 1000;
  };
})(module, module.exports);

var f = module.exports.multiply;
f(5); // 5000
```

```js
// CommonJS 不适合浏览器, CommonJS 的 require 是同步的;
// 与服务端不同, 浏览器的模块放在服务器上, 等待时间取决于网速的快慢; 所以不能使用 '同步加载'
// AMD 默认推荐的是
define(['./a', './b'], function(a, b) {
  // 依赖必须一开始就写好
  a.doSomething();
  // 此处略去 100 行
  b.doSomething();
  // ...
});
require([module], callback);
require(['math'], function(math) {
  math.add(2, 3);
});
```

```js
// CMD
define(function(require, exports, module) {
  var a = require('./a');
  a.doSomething(); // 此处略去 100 行
  var b = require('./b'); // 依赖可以就近书写
  b.doSomething(); // ...
});
```

```html
<!-- ES6 type=module -->
<script type="module">
  import {addTextToBody} from './utils.js';

  addTextToBody('Modules are pretty cool.');
</script>


// utils.js
export function addTextToBody(text) {
  const div = document.createElement('div');
  div.textContent = text;
  document.body.appendChild(div);
}
```

### map 实现

```js
Array.prototype.fakeMap = function(func, context) {
  let arr = this;
  const result = [];
  for (let i = 0; i < arr.length; i++) {
    func.call(context, arr[i], i, arr);
    result.push(arr[i]);
  }
  return result;
};
```

### setState 为什么是异步的

在执行 this.setState()时，React 没有忙着立即更新 state，只是把新的 state 存到一个队列（batchUpdate）中。上面三次执行 setState 只是对传进去的对象进行了合并,然后再统一处理（批处理），触发重新渲染过程，因此只重新渲染一次，结果只增加了一次。这样做是非常明智的，因为在一个函数里调用多个 setState 是常见的，如果每一次调用 setState 都要引发重新渲

### react 原理

setState 数据变化;

### vue 原理

Object.defineProperty 数据变化;

### Proxy 代理

```js
var p = new Proxy(target, handler);

p.revocable(); // 撤销代理
```

```js
var handler = {
  get: function(obj, prop) {
    return prop in obj ? obj[prop] : 37;
  },
};

var p = new Proxy({}, handler);
p.a = 1;
p.b = undefined;

console.log(p.a, p.b); // 1, undefined
console.log('c' in p, p.c); // false, 37
```

handler 的方法

```js
handler.get();
handler.set();
handler.deleteProperty();
handler.getPrototypeOf();
handler.setPrototypeOf();
// 等等...
```

### 监听节点变化

[通过 IntersectionObserver](http://www.ruanyifeng.com/blog/2016/11/intersectionobserver_api.html)
[caniuse](https://caniuse.com/#search=IntersectionObserver)

intersection 交叉
Observer 观察者

```js
const callback = function(entries) {
  console.log(
    'entries',
    entries,
    'intersectionRatio',
    entries[0].intersectionRatio
  ); // 数组类型
  // entries[0]: IntersectionObserverEntry
  /* {
    // 可见性发生变化的时间，是一个高精度时间戳，单位为毫秒
    time: 3893.92,
    // 根元素的矩形区域的信息，getBoundingClientRect()方法的返回值，如果没有根元素（即直接相对于视口滚动），则返回null
    rootBounds: ClientRect {
      bottom: 920,
      height: 1024,
      left: 0,
      right: 1024,
      top: 0,
      width: 920
    },
    // 目标元素的矩形区域的信息
    boundingClientRect: ClientRect {
      // ...
    },
    // 目标元素与视口（或根元素）的交叉区域的信息
    intersectionRect: ClientRect {
      // ...
    },
    // 目标元素的可见比例，即intersectionRect占
    intersectionRatio: 0.54,
    // 被观察的目标元素，是一个 DOM 节点对象
    target: element,
  } */
};
const option = {};
const io = new IntersectionObserver(callback, option);

const ele = document.getElementById('example');

// 开始观察
io.observe(ele);
// io.observe(eleA); // 观察多个节点

// 停止观察
io.unobserve(element);

// 关闭观察器
io.disconnect();
```

[jsfiddle demo](https://jsfiddle.net/yingyu/hzjqe1k3/)

IntersectionObserver API 是异步的，不随着目标元素的滚动同步触发。

### 什么数据存储在 vuex

vuex 解决了几个问题：

1.  组件之间的数据通信
1.  使用单向数据流的方式进行数据的中心化管理

### vue-lazyload 实现

[监听事件](https://github.com/hilongjw/vue-lazyload/blob/v1.2.4/src/lazy.js#L22)
['scroll', 'wheel', 'mousewheel', 'resize', 'animationend', 'transitionend', 'touchmove']

[检测是否元素在视图中](https://github.com/hilongjw/vue-lazyload/blob/v1.2.4/src/listener.js#L95-L107)

element.getBoundingClientRect()

### script 标签

```html
<script src="js/require.js" defer async="true" ></script>
```

- async
  是否允许异步执行该脚本; 对内联脚本无效(没有 src 属性的脚本);
  脚本加载完就执行;

- defer
  通知浏览器 在文档完成解析后, 触发 DOMContentLoaded 事件前执行;
  如果有多个设置了 defer 的 script 标签存在，则会按照顺序执行所有的 script；
  ```js
  // log.js
  console.log('document.body.textContent', document.body.textContent);
  ```

```html
<body>
  <p>first</p>
  <script src="./log.js"></script>
  <p>second</p>
</body>
<!-- output:  -->
<!-- first -->
```

```html
<body>
  <p>first</p>
  <script defer src="./log.js"></script>
  <p>second</p>
</body>
<!-- output:  -->
<!-- first -->
<!-- second -->
```

- type
  text/javascript, text/ecmascript, application/javascript, 和 application/ecmascript, module

### null 和 undefined 有什么区别

null 是空对象;
undefined 是没有被定义;

```js
typeof null === 'object'; // true
typeof undefined === 'undefined'; // true
```

### rem 自适应布局

设计稿 750px;

设计稿 100px === 1rem;

iPhone 6:
document.documentElement.clientWidth === '375px';
initial-scale = 1.0;

7.5rem === 100vw;
7.5rem === 375px;
1rem === 50px;

字体不能设置比 12px 小的值, 7.5rem === 100vw; 而不是 750rem === 100vw;
那么对应设计稿的宽度就除以 100;

rootFontSize = 375 / 7.5; // 50px;

iPhone 6 Plus:
document.documentElement.clientWidth === '414px';
initial-scale = 1.0;

rootFontSize = 414 / 7.5; // 55.2px;

优：通过动态根 font-size 来做适配，基本无兼容性问题，适配较为精准，换算简便。

劣：无 viewport 缩放，且针对 iPhone 的 Retina 屏没有做适配，导致对一些手机的适配不是很到位。

- Flexible

设计稿 100px === 1.333333333rem; (100/75)

iPhone 6:
document.documentElement.clientWidth === '750px';
initial-scale = 0.5;

10rem === 100vw;
10rem === 750px;
1rem === 75px;

rootFontSize = 750 / 10; // 75px;

iPhone 6 Plus:
document.documentElement.clientWidth === '1242px';
initial-scale = 0.33333;

rootFontSize = 1242 / 10; // 124.2px;

优：通过动态根 font-size、viewpor、dpr 来做适配，无兼容性问题，适配精准。

劣：需要根据设计稿进行基准值换算，在不使用 sublime text 编辑器插件开发时，单位计算复杂。

### rem 和 em 有什么去区别

em 相对于父元素的字体大小;https://www.w3cplus.com/css/rem-vs-em.html

### img src srcset sizes

[MDN img](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/img)

- srcset

一个图像的 URL + [一个宽度描述符 或者 一个像素密度描述符]

像素密度描述符 是一个正浮点数, 以 'x' 为单位;

### 闭包作用与场景

- 可以阻止变量被垃圾回收

- 封装 (信息隐藏)

  阻止外部函数访问内部元素, 变量私有化;

```js
var count2 = 0;
var fiba = (function() {
  var arr = [0, 1, 1]; //第0位只是占位，从第一位开始算起
  return function(n) {
    count2++;
    var res = arr[n]; /*因为内部引用了arr，并返回，导致arr一直在内存中*/
    if (res) {
      return res;
    } else {
      arr[n] = fiba(n - 1) + fiba(n - 2);
      return arr[n];
    }
  };
})();
```

### 词法作用域

```js
var a = 1;

function f() {
  var b = 2;
  c = 3; // c 注册在全局, 赋值为 3;
  return function g() {
    // i++; 先赋值, 再自加
    console.log(a++); // ④ 1
    console.log(b++); // ⑤ 2
    console.log(c++); // ⑥ 3
  };
}

console.log(a); // ① 1
console.log(b); // ② undefined

var g = f();
var b = 2; // b 注册在全局, 却还未赋值
console.log(c); // ③ 3
g();
console.log(a); // ⑦ 2
console.log(b); // ⑧ 2
console.log(c); // ⑨ 4
```

### setTimeout 优化, 秒杀优化

before:

```js
setInterval(function() {
  var j = 0;
  while (j++ < 100000000);
  console.log('done');
}, 0);
function startTimer() {
  var times = 0;
  function step() {
    var node = document.querySelector('body'); // 重复进行节点查询, 应该缓存起来
    node.textContent = times++;
    setTimeout(step, 1000); // setTimeout 无法保证时间的精确性
  }

  step();
}
startTimer();
```

after:

```js
setInterval(function() {
  var j = 0;
  while (j++ < 100000000);
}, 0);
function startTimer() {
  var times = 0;
  var startTime = Date.now();
  var node = document.querySelector('body'); // 只获取一次节点

  function step(timestamp) {
    var newTimes = parseInt((Date.now() - startTime) / 1000); // 进行时间比较
    if (newTimes > times) {
      node.textContent = newTimes; // 避免频繁操作 DOM 节点
    }
    requestAnimationFrame(step);
  }

  requestAnimationFrame(step); // 不断的检测
}
startTimer();
```

### animation: Translate VS top/left

[Why Moving Elements With Translate() Is Better Than Pos:abs Top/left](https://www.paulirish.com/2012/why-moving-elements-with-translate-is-better-than-posabs-topleft/)

> The top/left has very large time to paint each frame, which results in a choppier transition. All the CSS including some big box shadows, are computed on the CPU and composited against that gradient backdrop every frame. The translate version, on the other hand, gets the laptop element elevated onto it’s own layer on the GPU (called a RenderLayer). Now that it sits on its own layer, any 2D transform, 3D transform, or opacity changes can happen purely on the GPU which will stay extremely fast and still get us quick frame rates.

top/left 需要花费很多时间来绘制每一帧; 一些边框,阴影都是通过 CPU 计算出来的;再与背景进行合成;

而 translate 是使用 GPU 将元素提升到自己的渲染层; 所有的 2D, 3D 变幻都是发生在 GPU 中; GPU 可以保证非常快的帧速率;

前端性能优化（CSS 动画篇）(https://segmentfault.com/a/1190000000490328)

### call

```js
var a = ['asdf ', ' sd '];

function cool(arr) {
  return arr.map(Function.prototype.call, String.prototype.trim);
  // return arr.map(function(item) {
  //   return String.prototype.trim.call(item);
  // });
}

var b = cool(a);
console.log(b);
console.log(String.prototype.trim.bind(' 234 ')());
```

### vue computed 实现

[mvvm computed](https://github.com/DMQ/mvvm/blob/master/js/mvvm.js#L39-L52)

```js
var computed = this.$options.computed;
if (typeof computed === 'object') {
  Object.keys(computed).forEach(function(key) {
    Object.defineProperty(me, key, {
      get:
        typeof computed[key] === 'function' ? computed[key] : computed[key].get,
      set: function() {},
    });
  });
}
```

具体的 computed 函数内部会使用 this.data 的数据; 当 this.data 上的值改变的时候, 是怎么通知到这个 computed 更新的呢;

在 initComputed 时, 会执行 computed 上的函数,这时会获取 this.data 上的值, 由于获取的时候会被 Object.defineProperty 拦截, 在这个时候添加的订阅;

### nextTick

[Vue nextTick 机制](https://juejin.im/post/5ae3f0956fb9a07ac90cf43e)

[Vue 中 DOM 的异步更新策略以及 nextTick 机制](https://funteas.com/topic/5a8dc7c8f7f37aa60a177bb7)

### Promise

```js
Promise.reject(1)
  .then(
    function() {
      throw new Error('err');
    },
    reason => {
      console.log('reason', reason); // Error!
      return 2;
    }
  )
  .then(
    function(data) {
      console.log('data1', data);
    },
    reason => {
      console.log('reason1', reason); // Error!
    }
  )
  .then(
    function(data) {
      console.log('data2', data);
    },
    reason => {
      console.log('reason2', reason); // Error!
    }
  )
  .catch(err => {
    console.log('catch err', err);
  });
```

error 会被下一个 then 的第二个参数捕获, 如果错误被中途捕获, 后续的 then 会继续执行, 最后的 catch 也不会触发;
在一个错误回调函数中，如果你没有重新抛出错误，这个 promise 将会认为你已经恢复了错误并转换到了 resolved 状态。

如果没有被捕获, 将不会执行后续逻辑, 直接跳到最后的 catch 函数;

```js
// 代码一
var p = Promise.resolve();

p.then(() => {
  // func1
  throw new Error('err');
});

p.then(() => {
  // func2
  console.log('hi');
});

// 代码二
var p = Promise.resolve();
p.then(() => {
  // func1
  throw new Error('err');
}).then(() => {
  // func2
  console.log('hi');
});
```

两者有区别;

每次我们调用 then()时都会返回一个分叉的 promise。因此，在第一段代码中，如果 func1()抛出一个异常，func2 依然会正常被调用。

在第二段代码中，如果 func1()抛出一个异常，func2()将不会被调用，因为第一次调用 then()返回了一个新的 promise，由于 func1()中的异常这个 promise 被 rejected。结果是 func2()被跳过不执行。

### 二叉树

```js
/*
二叉树
       a
     /  \
    b    e
  /  \     \
 c    d      f
            /
          g
*/

var a = { val: 'a', left: null, right: null };
var b = { val: 'b', left: null, right: null };
var c = { val: 'c', left: null, right: null };
var d = { val: 'd', left: null, right: null };
var e = { val: 'e', left: null, right: null };
var f = { val: 'f', left: null, right: null };
var g = { val: 'g', left: null, right: null };

a.left = b;
a.right = e;
b.left = c;
b.right = d;
e.right = f;
f.left = g;

console.log(JSON.stringify(a, null, 2));

// 翻转树
function invertTree(root) {
  if (!root) {
    return;
  }
  const { left, right } = root;
  root.left = invertTree(right);
  root.right = invertTree(left);
  return root;
}
console.log(JSON.stringify(invertTree(a), null, 2));
```

先序遍历: 根左右
a -> b -> c -> d -> e -> f -> g

```js
function first(tree) {
  if (!tree) return;
  console.log(tree.val);
  first(tree.left);
  first(tree.right);
}
first(a);
```

中序遍历: 左根右

c -> b -> d -> a -> e -> g -> f

```js
function center(tree) {
  if (!tree) return;
  return new Promise(async resolve => {
    await center(tree.left);
    console.log(tree.val);
    await center(tree.right);
    resolve();
  });
}

center(a);
```

后序遍历: 左右根

c -> d -> b -> g -> f -> e -> a

```js
function last(tree) {
  if (!tree) return;
  return new Promise(async resolve => {
    await last(tree.left);
    await last(tree.right);
    console.log(tree.val);
    resolve();
  });
}

last(a);
```

### 为什么 vue 组件 data 必须是一个函数

避免 组件类 实例化后, 数据共享;保证数据互相独立;

### 双向绑定的原理

1.  发布者-订阅者模式（backbone.js）

1.  脏值检查（angular1）

angular.js 是通过脏值检测的方式比对数据是否有变更，来决定是否更新视图，最简单的方式就是通过 `setInterval()` 定时轮询检测数据变动，当然 Google 不会这么 low，angular 只有在指定的事件触发时进入脏值检测，大致如下：

- DOM 事件，譬如用户输入文本，点击按钮等。( ng-click )
- XHR 响应事件 ( $http )
- 浏览器 Location 变更事件 ( $location )
- Timer 事件( $timeout , $interval )
- 执行 $digest() 或 $apply()

1.  数据劫持（vue.js）

### module.exports 和 exports

```js
// hello.js

// exports 其实指向的是 module.exports
exports.foo = 'foo';
exports.baz = 'baz';

// 将会 覆盖上面的定义
module.exports = {
  foo: 'other foo',
  bar: 'bar',
};
```

```js
const hello = require('hello.js');

hello.baz; // undefined
```

### 为什么 typeof null === 'object'

[参考英文文章](http://2ality.com/2013/10/typeof-null.html)

| 标志位                | 类型                  |
| --------------------- | --------------------- |
| `000`                 | 对象                  |
| `1`                   | 整型，31 位带符号整数 |
| `010`                 | 双精度类型            |
| `100`                 | 字符串                |
| `110`                 | 布尔类型              |
| -2^30, JSVAL_VOID     | undefined             |
| `0`, 机器代码的空指针 | null                  |

[源码 2018-06-25 可访问地址](https://dxr.mozilla.org/classic/source/js/src/jsapi.c#343-351)

```c
JS_PUBLIC_API(JSType)

JS_TypeOfValue(JSContext *cx, jsval v)
{
    JSType type = JSTYPE_VOID;
    JSObject *obj;
    JSObjectOps *ops;
    JSClass *clasp;

    CHECK_REQUEST(cx);
    if (JSVAL_IS_VOID(v)) {
        // 判断是否是 undefined
        type = JSTYPE_VOID;
    } else if (JSVAL_IS_OBJECT(v)) {  // 它检查了标志位的类型，标志位表明它是个对象
        // 判断值是否有对象的标志位
        obj = JSVAL_TO_OBJECT(v);
        if (obj &&
            (ops = obj->map->ops,
            ops == &js_ObjectOps
            ? (clasp = OBJ_GET_CLASS(cx, obj),
            clasp->call || clasp == &js_FunctionClass)
            : ops->call != 0)) {
            // 如果它是可调用的，或者说通过内部属性[[Class]]表示它是一个函数
            // 就是一个函数
            type = JSTYPE_FUNCTION;
        } else {
            // 否则就是一个对象
            type = JSTYPE_OBJECT;
        }
    } else if (JSVAL_IS_NUMBER(v)) {
        type = JSTYPE_NUMBER;
    } else if (JSVAL_IS_STRING(v)) {
        type = JSTYPE_STRING;
    } else if (JSVAL_IS_BOOLEAN(v)) {
        type = JSTYPE_BOOLEAN;
    }
    return type;
}
```

### jsBridge 原理

### 网络协议

### 兼容性问题

### 数据结构

### Linux 权限

### 排序

### 数组排序

### Express, Koa; next

### 事件委托

### 原型链和作用域链你的理解

### less, sass 区别

### Promise 实现

### 同行布局

### 装饰器
