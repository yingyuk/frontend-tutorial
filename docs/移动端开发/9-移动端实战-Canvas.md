---
title: 移动端实战-Canvas
date: 2018-05-17 21:03:24
---

# 移动端实战-Canvas

1.  制定技术方案

1.  canvas 图片制作

1.  基本语法

```js
drawImage(image, x, y, width, height);
fillText(text, x, y, [, maxWidth]);
createLinearGradient(x0, y0, x1, y1);
canvas.toDataURL(type, encoderOptions); // reutrn Image Base64
```

```js
function loadImage() {
  var img = new Image();
  // 跨域激活, cdn 可能与当前页面不一致
  img.crossOrigin = 'true';
  img.src = (
    (/\?/.test(url) ? url + '&' : url + '?') + btoa(window.location.origin)
  ).replace('http:', '');
  return img;
}
```
