# Slideshow Plugin

## TODO
- 添加下标选择（jump）
- 添加左右切换按钮
- 添加回调功能
- 添加图片尺寸处理机制
- 更改切换样式

## Usage
```bash
npm install
```

```javascript
// ====== 初始化 =======
// container是一个类div的标准容器，比如div, section等
$('container').lunbo({
  data: [
    {
      image: 'path/to/image',
      title: '**** **** **** 1111',
      comment: '01/22'
    },
    {
      image: 'path/to/image2',
      title: '**** **** **** 2222',
      comment: '01/22'
    }
  ],
  // 播放间隔，设置为0时不播放
  interval: 5000,
  // 在轮播图切换的时候会触发onSwitch回调，动画开始前为start，开始后为end
  onSwitchStart: function (event, index) {

  },
  onSwitchEnd: function (event, index) {

  }
})

// ====== 初始化后的功能 ======
// 查看当前所在的index
$('container').lunbo('current');
// 跳转到某个index
$('container').lunbo(3);
// 下一张图片
$('container').lunbo('next');
// 上一张图片
$('container').lunbo('prev');
// 暂停播放
$('container').lunbo('stop');
// 恢复播放
$('container').lunbo('resume');
```
