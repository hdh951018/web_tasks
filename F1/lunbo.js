(function($){
  var defaults = {
    interval: 3000,
    title: "**** **** **** ****",
    comment: "04/28",
    onSwitchStart: function(){},
    onSwitchEnd: function(){}
  }

  var settings = {}
  var initStatus = false
  var currentIndex = 0
  var lastIndex = 0
  var imageCount = 0
  var isPaused = false
  var playerId // ID of setInterval

  var outAnimation = "fadeOut"
  var inAnimation = "fadeIn"
  var animationTime = 2000  // Duration of the animation


  var beginOption = {
    duration: animationTime,
    begin: function(){
      settings.onSwitchStart("something about event", currentIndex)
    }
  }

  var completeOption = {
    duration: animationTime,
    complete: function(){
      settings.onSwitchEnd("something about event", lastIndex)
    }
  }

  var imageOut = function(self){
    $(self.children()[currentIndex]).velocity(outAnimation, beginOption)
  }

  var imageIn = function(self){
    $(self.children()[currentIndex]).velocity(inAnimation, completeOption)
  }

  var methods = {
    init: function(options){
      initStatus = true  // initialize
      if($.type(options.interval) == "number"){
        // Assign if `interval` is a number
        settings.interval = options.interval + animationTime
      } else if ($.type(options.interval) == "undefined") {
        // Use default interval if `interval` is undefined
        settings.interval = defaults.interval + animationTime
      } else {
        $.error("TypeError: The value of interval can only be a number")
      }
      // Save callback function
      settings.onSwitchStart = options.onSwitchStart || defaults.onSwitchStart
      settings.onSwitchEnd = options.onSwitchEnd || defaults.onSwitchEnd
      imageCount = options.data.length
      lastIndex = imageCount - 1
      var self = this
      $(options.data).each(function(index,element){
        var img = $("<img>").attr({
          src: this.image,
          alt: index
        })
        img.css({
          position: 'absolute',
          left: 0,
          right: 0,
          margin: '0 auto',
          boxShadow: '3px 3px 7px rgba(69, 69, 69, 0.6)',
          display: 'none'
        })
        self.append(img)
      })
      // 显示第一张图
      self.children()[0].style.display = "block";
      if(playerId) clearInterval(playerId)
      playerId = setInterval(function(){self.lunbo("next")}, settings.interval)
      return this
    },
    current: function(){
      return currentIndex
    },
    next: function(){
      imageOut(this)
      lastIndex = currentIndex
      currentIndex = (currentIndex + 1) % imageCount
      imageIn(this)
      return this
    },
    prev: function(){
      imageOut(this)
      lastIndex = currentIndex
      currentIndex = (currentIndex - 1 + imageCount) % imageCount
      imageIn(this)
      return this
    },
    stop: function(){
      clearInterval(playerId)
      return this
    },
    resume: function(){
      var self = this
      playerId = setInterval(function(){self.lunbo("next")}, settings.interval)
      return this
    },
    jump: function(index){
      if(index > imageCount || index < 0){
        $.error("Cannot find image by index = \'" + index + "\'")
      } else if(currentIndex == index) {
        lastIndex = currentIndex
      } else {
        imageOut(this)
        lastIndex = currentIndex
        currentIndex = index
        imageIn(this)
      }
      var self = this
      clearInterval(playerId)
      playerId = setInterval(function(){self.lunbo("next")}, settings.interval)
      return this
    }
  }

  $.fn.lunbo = function(){
    var arg = arguments[0]
    if($.type(arg) == "object"){
      method = methods.init
    } else if(initStatus == false){
      $.error("Method " + arg + " cannot be called before initializing jQuery.lunbo")
    } else if($.type(arg) == "number") {
      method = methods.jump
    } else if(methods[arg]) {
      method = methods[arg]
    } else {
      $.error("Method " + arg + " doesn't exist on jQuery.lunbo")
      return this
    }
    return method.call(this, arg)
  }
})(jQuery);
