const icon = document.getElementsByClassName('icon');

let droppable = false;
let rumbleTween;

const date = new Date();

const dateElement = document.getElementById('current_year');
console.log(dateElement);
dateElement.innerHTML = date.getFullYear();
Draggable.create(".js-drag", {
  type: "x,y", edgeResistance: 0.65, bounds: ".screen",
  onPress: function () {
    $(this.target).addClass('icon--highlight');
  },
  onRelease: function () {
    if (droppable) {
      killThisYearAlready();
    } else {
      $(this.target).removeClass('icon--highlight');
    }
  },
  onDrag: dropTest });


function dropTest(e) {
  console.log(e);
  console.log(this);
  if ($(e.target).hasClass('js-calendar')) {
    if (this.hitTest('.icon--trash', "50%")) {
      canDrop(true);
    } else {
      canDrop(false);
    }
  }
}

function canDrop(isOverTrash) {
  if (isOverTrash) {
    droppable = true;
    $('.icon--trash').addClass('icon--highlight');
  } else {
    droppable = false;
    $('.icon--trash').removeClass('icon--highlight');
  }
}

function killThisYearAlready() {
  $('.icon--calendar').css('display', 'none');
  $('.icon--trash').addClass('icon--trash--full');
  $('.icon--trash').removeClass('icon--highlight');
  $('.start__text').text('End');


  setTimeout(function () {
    let rumbleFactor = 3;
    rumbleTween = TweenMax.to('.screen', 0.1, {
      y: `+=${rumbleFactor}`,
      x: `+=${rumbleFactor}`,
      onUpdate: function () {
        rumbleFactor = 1 + Math.random() * 5;
      },
      ease: Expo.easeInOut,
      repeat: -1 });

  }, 500);

  setTimeout(function () {
    rumbleTween.pause();
    TweenMax.to('.screen', 0.4, {
      scaleY: 0.01,
      ease: Power4.easeIn });

    TweenMax.to('.screen', 0.1, {
      scaleX: 0.01,
      delay: 0.4,
      ease: Linear.easeNone });

    TweenMax.to('.screen__overlay', 0.4, {
      opacity: 1,
      delay: 0.1,
      ease: Power4.easeIn });

    TweenMax.to('.screen', 0.4, {
      opacity: 0,
      delay: 0.5,
      ease: Power4.easeIn });

    setTimeout(function () {
      self.location = "https://gamecu.be";
      console.log('done');
    }, 500);
  }, 1500);
}
