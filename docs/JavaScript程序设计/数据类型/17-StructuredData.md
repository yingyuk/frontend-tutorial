---
title: StructuredData
date: 2018-05-15 20:02:52
---

# StructuredData

### JS 操作二进制数据

二进制数据 可以提高图形图像的渲染性能; 可用于 虚拟现实, 3D 渲染;

JS 调用 WebGL 的 API; 与 GPU 进行数据交互, 最终渲染到浏览器;

GPU 是使用 二进制数据; 而 JS 是使用 32 位的文本类型格式的整数; 哪怕在渲染工程中需要一次数据格式的转换;
这个转换是非常耗时的; 那么我们便需要一种机制像 C 语言那样, 直接操作字节; 将 4 个字节的 32 位整数, 以二进制的形式原封不动的传给 显卡;
它允许开发者想 C 语言那样, 以数组下标的形式, 直接操作内存;大大增加了 JS 处理二进制数据的能力;

#### 二级制操作接口

1.  ArrayBuffer


    ArrayBuffer 对象用来表示通用的、固定长度的原始二进制数据缓冲区。
    ArrayBuffer 不能直接操作，而是要通过类型数组对象或 DataView 对象来操作

    * 语法

      new ArrayBuffer(length)

      length
      要创建的 ArrayBuffer 的大小，单位为字节。

      如果 length 大于 Number.MAX_SAFE_INTEGER（>= 2 \*\* 53）或为负数，则抛出一个 RangeError 异常。

    * 属性和方法

    - ArrayBuffer.isView(arg)

      如果参数是 ArrayBuffer 的视图实例则返回 true，例如 类型数组对象 或 DataView 对象；否则返回 false。


    ```js
    const buffer = new ArrayBuffer(8);
    ArrayBuffer.isView(buffer); // false 不是它的视图

    const view = new Int32Array(buffer); // TypedArray
    ArrayBuffer.isView(view); // true 是它的视图
    ```

    * ArrayBuffer.prototype.byteLength
      只读数组的字节大小。在数组创建时确定，并且不可变更。**只读**。

    - ArrayBuffer.prototype.slice()
      返回一个新的 ArrayBuffer ，它的内容是这个 ArrayBuffer 的字节副本，从 begin（包括），到 end（不包括）。如果 begin 或 end 是负数，则指的是从数组末尾开始的索引，而不是从头开始。

1.  DataView


    ArrayBuffer 有两种视图; DataView 是其中之一;

    DataView 视图是一个可以从 ArrayBuffer 对象中读写多种数值类型的底层接口，在读写时不用考虑平台字节序问题。

    * 语法

      new DataView(buffer [, byteOffset [, byteLength]])

      * buffer
        一个 ArrayBuffer 或 SharedArrayBuffer 对象，DataView 对象的数据源。

      * byteOffset 可选

      此 DataView 对象的第一个字节在 buffer 中的偏移。如果不指定则默认从第一个字节开始。

      * byteLength 可选此 DataView 对象的字节长度。如果不指定则默认与 buffer 的长度相同。

      ```js
      const buffer = new ArrayBuffer(24);
      const dv = new DataView(buffer);

      dv.constructor;  // DataView
      dv.buffer; // ArrayBuffer(24);
      dv.byteLength; // 24
      dv.byteOffset; // 0
      ```

    * 读 DataView

      * DataView.prototype.getInt8(byteOffset[, littleEndian])

          8-bit 数(一个字节)
          从 DataView 起始位置以 byte 为计数的指定偏移量(byteOffset)处获取一个 8-bit 数(一个字节).

          littleEndian: true 小端字节序读取; false 或者不传时从大端字节序读取;

      * DataView.prototype.getUint8()

        8-bit 数(无符号字节)

      * DataView.prototype.getInt16()

        16-bit 数(短整型)

      * DataView.prototype.getUint16()

        16-bit 数(无符号短整型).

      * DataView.prototype.getInt32()

        32-bit 数(长整型).

      * DataView.prototype.getUint32()

        32-bit 数(无符号长整型).

      * DataView.prototype.getFloat32()

        32-bit 数(浮点型).

      * DataView.prototype.getFloat64()

        64-bit 数(双精度浮点型).

    * 写 DataView

1.  TypedArray

### 字节序

* 大端字节序

存储 `0x12345678` 和 `ox11223344`

|      |      |      |      |     |      |      |      |      |
| ---- | ---- | ---- | ---- | --- | ---- | ---- | ---- | ---- |
| 0x12 | 0x34 | 0x56 | 0x78 |     | 0x11 | 0x22 | 0x33 | 0x44 |

----内存增长方向---->

* 小端字节序

|      |      |      |      |     |      |      |      |      |
| ---- | ---- | ---- | ---- | --- | ---- | ---- | ---- | ---- |
| 0x78 | 0x56 | 0x34 | 0x12 |     | 0x44 | 0x33 | 0x22 | 0x11 |

----内存增长方向---->

* 为什么会有 大端, 小端的区别呢?

这是因为不同的操作系统, 不同的 CPU; 在设计的时候比较任性, 有些是大端的; 有些是小端的;

TCP 是一个网络协议; 使用的是大端的协议;

* 判断字节序

```js
var littleEndian = (function() {
  var buffer = new ArrayBuffer(2);
  new DataView(buffer).setInt16(0, 256, true /* 设置值时使用小端字节序 */);
  // Int16Array 使用系统字节序，由此可以判断系统是否是小端字节序
  return new Int16Array(buffer)[0] === 256;
})();
console.log(littleEndian); // true or false
```

### ArrayBuffer 的使用, DataView 的使用

假设一个单元格表示一个字节;

```js
const buffer = new ArrayBuffer(16);
```

| 0x00 | 0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09 | 0x0a | 0x0b | 0x0c | 0x0d | 0x0e | 0x0f |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |      |

```js
const dv = new DataViwe(buffer, 4, 4);
// 偏移位置为 4;
// 长度为 4;
```

| 0x00 | 0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09 | 0x0a | 0x0b | 0x0c | 0x0d | 0x0e | 0x0f |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|      |      |      |      | dv   | dv   | dv   | dv   |      |      |      |      |      |      |      |      |

```js
dv.setInt16(1, '0x002a');
// setInt16 会写入两个字节
// 1 代表一个偏移量
```

| 0x00 | 0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09 | 0x0a | 0x0b | 0x0c | 0x0d | 0x0e | 0x0f |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
|      |      |      |      |      | 00   | 2a   |      |      |      |      |      |      |      |      |      |

| 数据类型               | 操作的字节数 (假设一个单元格表示一个字节) |
| ---------------------- | ----------------------------------------- |
| int8, Uint8            | 1 个字节                                  |
| int16, Uint16          | 2 个字节                                  |
| int32, Uint32, Float32 | 4 个字节                                  |
| Float64                | 8 个字节                                  |

```js
// 范围是 0x05;
dv.getInt8(1); // 0x00 => 0;
// 范围是 0x06;
dv.getInt8(12); // 0x2a => 42;

// 范围是 0x05 ~ 0x06;
dv.getInt16(1); // 0x002a => 42;
// 范围是 0x06 ~ 0x07;
dv.getInt16(2); // 0x2a00 => 10752;

// 范围是 0x04 ~ 0x07;
dv.getInt32(0); // 0x00002a00 => 10752;

// 使用小端字节序; 从右往左取; 范围是 0x07 ~ 0x04;
dv.getInt32(0, !0); // 0x002a0000 => 2752512;

/**
 * dv 这个视图的范围只有 4个字节; 范围是 0x04 ~ 0x07
 * getInt32 操作的也是 4个字节; 但有 1 个偏移量; 获取的范围是 0x05 ~ 0x08;
 * 显而易见的 越界了;
 * 将会报 RangeError
 */
dv.getInt32(1); // RangeError

/**
 * dv 这个视图的范围只有 4个字节; 范围是 0x04 ~ 0x07
 * getFloat64 操作的是 8个字节; 获取的范围是 0x04 ~ 0x0b;
 * 显而易见的 越界了;
 * 将会报 RangeError
 */
dv.getFloat64(0); // RangeError
```
