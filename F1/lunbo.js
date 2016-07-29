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
  var imageHeight = 210
  var isPaused = false
  var playerId // ID of setInterval

  var outAnimation = "fadeOut"
  var inAnimation = "fadeIn"
  var animationTime = 1500  // Duration of the animation

  var activeColor = 'rgba(201, 201, 201, 0.6)'
  var inactiveColor = 'rgba(128, 128, 128, 0.6)'

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
    $(self.find("img")[currentIndex]).velocity(outAnimation, beginOption)
    $(self.find("ul>li")[currentIndex]).css({backgroundColor: activeColor})
  }

  var imageIn = function(self){
    $(self.find("img")[currentIndex]).velocity(inAnimation, completeOption)
    $(self.find("ul>li")[currentIndex]).css({backgroundColor: inactiveColor})
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
      var circleList = $("<ul>").css({
        position: 'relative',
        textAlign: 'center',
        left: 0,
        right: 0,
        padding: 0,
        margin: '0 auto',
        top: imageHeight - 20 + 'px', // HACK Should depend on the height of thehighest image
        listStyle: 'none'
      })
      self.append(circleList)

      for(let i = 0; i < imageCount; i++){
        var circle = $("<li>").html(i+1).css({
          cursor: 'pointer',
          textAlign: 'center',
          fontSize: '12px',
          color: 'rgba(46, 46, 46, 0.8)',
          width: '14px',
          height: '14px',
          borderRadius: '10px',
          backgroundColor: activeColor,
          display: 'inline-block',
          margin: '2px'
        }).click(function(){
          self.lunbo(i)
        })
        circleList.append(circle)
      }
      // Display the first image and dot
      $(self.find("img")[0]).css({display: 'block'})
      $(self.find("ul>li")[0]).css({backgroundColor: inactiveColor})
      // Avoid being initialized once again
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
        // Out of size
        $.error("Cannot find image by index = \'" + index + "\'")
      } else if(currentIndex == index) {
        // Jump to current image without animation
        lastIndex = currentIndex
      } else {
        imageOut(this)
        lastIndex = currentIndex
        currentIndex = index
        imageIn(this)
      }
      var self = this
      // Set an interval from beginning
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
      // If arg is not an object and this is not initialized, there will be a fault
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
