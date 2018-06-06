---
title: HTTP协议
date: 2018-06-06 16:20:43
---

### 认识 HTTP

HyperText Transfer Protocol

- 应用层协议
- 基于 TCP/IP
- 规定了客户端与服务器的数据通讯格式
- 用于传输超媒体文档
- 无状态

1.  建立连接 三次握手
1.  发送请求,等待应答
1.  处理请求,返回应答

### HTTP 消息(报文)

1.  请求 (request)

- 起始行(头行)

  - HTTP 方法
  - 请求目标
  - HTTP 版本

- 请求头 (headers)
- 请求体 (body)

1.  应答 (response)

- 状态行
  - HTTP 版本
  - 状态码
  - 状态文本
- 响应头 (headers)
- 响应体 (body)

### 状态码

[w3 完整的状态码](https://www.w3.org/Protocols/rfc2616/rfc2616.txt)

| 状态码(常见) | 含义                                          |
| ------------ | --------------------------------------------- |
| 101          | Switching Protocols 协议转换                  |
| 200          | OK                                            |
| 301          | Moved Permanently 永久转移                    |
| 302          | Found 临时转移                                |
| 304          | Not Modified 没有变动                         |
| 400          | Bad Request 不符合定义,比如参数不对           |
| 403          | Forbidden 没有权限访问                        |
| 404          | Not Found 资源不存在                          |
| 405          | Method Not Allowed                            |
| 413          | Request Entity Too Large 请求体太大           |
| 415          | Unsupported Media Type 服务器不支持的媒体类型 |
| 500          | Internal Server Error 服务器内部错误          |
| 502          | Bad Gateway 网关错误,比如应用没启动           |
| 503          | Service Unavailable 服务不可用                |
| 504          | Gateway Time-out 网关超时                     |

### HTTP/2 (帧)

- 将 HTTP/1.x 消息分成 帧,并嵌入到流(steam)中
- 数据帧和报头帧是分离的, 允许报头压缩
- 多路复用

### HTTP 缓存

使用 HTTP 请求头的相关字段, 指示浏览器缓存策略;

- 请求头(Headers)

  - Pragma(HTTP/1.0)
    不常用; no-cache;
  - Cache-control(HTTP/1.1)

为什么要缓存?

- 减少网络带宽消耗
- 降低服务器压力
- 减少网络延迟,提升页面打开速度

### 浏览器缓存机制

- 缓存规则

  - 新鲜度: 缓存副本有效期, 过期策略
  - 校验值: 验证校验标识 Etag, 验证策略

- 使用方法

  - HTML meta 标签定义缓存规则
  - HTTP 报头

| 位置     | 状态码                  | 含义                       |
| -------- | ----------------------- | -------------------------- |
| 通用     | Pragma(HTTP/1.0)        | 控制缓存行为, no-cache     |
|          | Cache-control(HTTP/1.1) | 控制缓存行为, no-cache     |
| 请求头   | If-Match                | Etag 是否一致              |
|          | If-None-Match           | Etag 是否不一致            |
|          | If-Modified-Since       | 资源最后更新时间是否一致   |
|          | If-Unmodified-Since     | 资源最后更新时间是否不一致 |
| 响应头   | Etag                    | 用于缓存校验的值           |
| 实体首部 | Expires(HTTP/1.0)       | 资源过期时间               |
|          | Last-Modified           | 资源最后修改时间           |

Cache-control 优先级最大 > Expires

Cache-control:

| 位置                            | 指令                    | 含义                                                   |
| ------------------------------- | ----------------------- | ------------------------------------------------------ |
| cache-request-directive 请求头  | no-cache                | 不使用缓存                                             |
|                                 | no-store                | 不会保存到缓存中                                       |
|                                 | `max-age=<seconds>`     | 接收一个 age 不大于 xxx 秒的资源                       |
|                                 | `max-stale[=<seconds>]` | 告知服务器 可以接收一个超过 xxx 秒的资源, 可为空       |
|                                 | `min-fresh=<seconds>`   | 接收一个小于 xxx 秒内被更新的资源                      |
|                                 | no-transform            | 获取实体数据, 没被转换过的数据                         |
|                                 | only-if-cached          | 如果有缓存, 则获取缓存的内容                           |
|                                 | cache-extension         | 自定义拓展值                                           |
| cache-response-directive 响应头 | public                  | 任何情况都要缓存该资源                                 |
|                                 | private                 | 指定 filed 字段开放给指定用户(share-user) 做缓存使用   |
|                                 | no-cache                | 不使用缓存, 可指定 filed                               |
|                                 | no-store                | 不保存到缓存中                                         |
|                                 | no-transform            | 告知客户端, 缓存文件时不能对实体数据做转换             |
|                                 | must-revalidate         | 当前资源必须向原始服务器发送验证请求, 若失败则返回 504 |
|                                 | proxy-revalidate        | 同上, 但仅用于共享缓存                                 |
|                                 | `max-age=<seconds>`     | 告知客户端在 xxx 秒内是新鲜的                          |
|                                 | `s-maxage=<seconds>`    | 同上, 仅用于共享缓存                                   |
|                                 | cache-extension         | 自定义拓展值                                           |

### HTTP cookie

在浏览器存储的一小块数据;

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
