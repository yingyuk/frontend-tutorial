---
title: TypedArray
date: 2018-05-14 20:14:23
---

# TypedArray

[MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/TypedArray)

| 类型              | 大小(字节) | 描述                                  |
| ----------------- | ---------- | ------------------------------------- |
| Int8Array         | 1          | 8 位二进制带符号整数 -2^7~(2^7) - 1   |
| Uint8Array        | 1          | 8 位无符号整数 0~(2^8) - 1            |
| Uint8ClampedArray | 1          | 8 位无符号整数且值固定在 0 ~ 255 区间 |
| Int16Array        | 2          | 16 位二进制带符号整数 -2^15~(2^15)-1  |
| Uint16Array       | 2          | 16 位无符号整数 0~(2^16) - 1          |
| Int32Array        | 4          | 32 位二进制带符号整数 -2^31~(2^31)-1  |
| Uint32Array       | 4          | 32 位无符号整数 0~(2^32) - 1          |
| Float32Array      | 4          | 32 位 IEEE 浮点数                     |
| Float64Array      | 8          | 64 位 IEEE 浮点数                     |

1.  TypedArray 初始化

    * new TypedArray(buffer, 字节偏移量, 长度)

      ```js
      // 创建一个8字节的 ArrayBuffer
      const ab = new ArrayBuffer(8);

      // 创建一个纸箱 ab 的 Int32 视图, 开始于字节 0, 直到缓冲区的末尾
      const view1 = new Int32Array(ab);

      // 创建一个纸箱 ab 的 Uint8 视图, 开始于字节 2, 直到缓冲区的末尾
      const view2 = new Uint8Array(ab, 2);

      // 创建一个纸箱 ab 的 Int16 视图, 开始于字节 2, 长度 2
      const view3 = new Int16Array(ab, 2, 2);
      ```

    * new TypedArray(数组长度)

      传入数组长度时, 一个内部数组缓冲区被创建; 该缓冲区的大小是传入的数组长度乘数组的每个元素的字节数; 并且每个元素的值默认都为 0;

      ```js
      const f64a = new TypedArray(8);
      // 默认的 ArrayBuffer 将被创建, 默认都是 0

      f64a.forEach(x => console.log(x));
      // 0
      ```

      * new TypedArray(类型化数组)

      当传入类型化数组是,这个类型化数组将被复制到一个新的类型化数组

      ```js
      const x = new Int8Array([1, 1]);
      const y = new Int8Array(x); // 复制了一份

      x[0] = 2;
      y[0]; // 1

      // 这个时候将会是 同一段存储空间
      const z = new Int8Array(x.buffer);
      x[0] = 4;
      z[0]; // 4
      ```

1.  TypedArray 的方法

    * TypedArray.from(类数组)

      使用类数组或迭代对象创建一个新的类型化的数组

    * TypedArray.of(元素 0, 元素 1, ...元素 n)

      通过可变数量的参数创建新的类型化数组

1.  TypedArray 的原型

    * TypedArray.prototype.constructor

      返回创建实例原型的构造函数

    * TypedArray.prototype.buffer

      返回被格式化数组引用的 ArrayBuffer, 创建时已被固化; 只读;

    * TypedArray.prototype.byteLength

      返回 ArrayBuffer 读取的字节长度, 创建时已被固化; 只读;

    * TypedArray.prototype.byteOffset

      返回 ArrayBuffer 读取的字节偏移量, 创建时已被固化; 只读;

    * TypedArray.prototype.length

      返回类型化数组中的元素的数量, 创建时已被固化; 只读;

    1.  普通数组的原型方法, TypedArray 基本都有;

    1.  TypedArray 数组没有 concat 方法;

        需要手动写一个方法连接

    1.  TypedArray.prototype.set()

        将(普通数组 或 TypedArray) 中一段内容完全复制到另一段内存中;

    1.  TypedArray.prototype.subArray()

        对于 TypedArray 数组的一部分; 在建立一个新的视图

1.  TypedArray 和数组的区别

| TypedArray                   | 数组               |
| ---------------------------- | ------------------ |
| 数组成员均为同一类型         | 可以是任意类型     |
| 数组成员是连续的, 不会有空位 | 非连续             |
| 数组的成员的默认值均为 0     | 默认为空 undefined |
| 是一个视图, 不存储数据       | 存储数据           |

1.  实际使用

    * AJAX

      在 AJAX 中传输或取到 二进制数据

      ```js
      var xhr = new XMLHttpRequest();
      xhr.addEventListener('load', oEvent => {
        var arrayBuffer = xhr.response;
        if (arrayBuffer) {
          var byteArray = new Uint0Array(arrayBuffer);
          for (let i = 0; i < byteArray.byteLength; i++) {
            // 对数组中每个字节进行操作
          }
        }
      });
      xhr.open('GET', '/myfile.png', true);
      xhr.send(null);
      ```

    - Canvas

    ```js
    const canvas = document.getElementById('mycanvas');
    const ctx = canvas.getContext('2d');

    const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
    const uint8ClampedArray = imageData.data;
    ```

    uint8ClampedArray

    每个字节节点为无符号的 8 位整数, 即只能取值 0 ~ 255;

    运算时自动过滤高位溢出;

    好处:

    在 RGB 颜色通道中, 每个颜色的取值范围都是 0 ~ 255 中变化; Uint8ClampedArray 这种高位溢出为 图像图像提供了便利;
