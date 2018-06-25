### 为什么要用 this

```js
function identify() {
  return this.name.toUpperCase();
}

function speak() {
  var greeting = "Hello, I'm " + identify.call(this);
  console.log(greeting);
}

var me = { name: 'Kyle' };

var you = { name: 'Reader' };

identify.call(me); // KYLE
identify.call(you); // READER

speak.call(me); // Hello, 我是 KYLE
speak.call(you); // Hello, 我是 READER
```

如果不使用 this ，那就需要给 identify() 和 speak() 显式传入一个上下文对象。

```js
function identify(context) {
  return context.name.toUpperCase();
}

function speak(context) {
  var greeting = "Hello, I'm " + identify(context);
  console.log(greeting);
}

identify(you); // READER
speak(me); // hello, 我是 KYLE
```

随着你的使用模式越来越复杂，显式传递上下文对象会让代码变得越来越混乱，使用 this 则不会这样。

### 误解

1.  指向自身

    人们很容易把 this 理解成指向函数自身;
    其实 this 并不像我们所想的那样指向函数本身;

    那么为什么需要从函数内部引用函数自身呢？常见的原因是递归（从函数内部调用这个函数）或者可以写一个在第一次被调用后自己解除绑定的事件处理器。

    ```js
    function foo(num) {
      console.log('foo: ' + num);

      // 记录 foo 被调用的次数
      this.count++;
    }

    foo.count = 0;

    var i;
    for (i = 0; i < 10; i++) {
      if (i > 5) {
        foo(i); // 调用时, this 指向了 window
      }
    }
    // foo: 6
    // foo: 7
    // foo: 8
    // foo: 9

    // foo 被调用了多少次？
    console.log(foo.count); // 0 -- WTF?
    window.count; // NaN
    ```

    ```js
    function foo(num) {
      console.log('foo: ' + num);

      // 记录 foo 被调用的次数
      this.count++;
    }

    foo.count = 0;

    var i;
    for (i = 0; i < 10; i++) {
      if (i > 5) {
        // 使用 call(..) 可以确保 this 指向函数对象 foo 本身
        foo.call(foo, i);
      }
    }
    // foo: 6
    // foo: 7
    // foo: 8
    // foo: 9

    // foo 被调用了多少次？
    console.log(foo.count); // 4
    ```

1.  它的作用域

    第二种常见的误解是， this 指向函数的作用域; 这个问题有点复杂，因为在某种情况下它 是正确的，但是在其他情况下它却是错误的。

```js
function foo() {
  var a = 2;
  // 试图使用 this 联通 foo() 和 bar() 的词法作用域
  // 从而让 bar() 可以访问 foo() 作用域里的变量 a
  // 这是不可能实现的
  this.bar();
}

function bar() {
  console.log(this.a);
}

foo(); // ReferenceError: a is not defined
```

每当你想要把 this 和词法作用域的查找混合使用时，一定要提醒自己，这是无法实现的。

### this 到底是什么

this 是在运行时进行绑定的，并不是在编写时绑定，它的上下文取决于函数调 用时的各种条件。 this 的绑定和函数声明的位置没有任何关系，只取决于函数的调用方式。

当一个函数被调用时，会创建一个活动记录（有时候也称为执行上下文）。这个记录会包 含函数在哪里被调用（调用栈）、函数的调用 方法 、传入的参数等信息。 this 就是记录的 其中一个属性，会在函数执行的过程中用到。
