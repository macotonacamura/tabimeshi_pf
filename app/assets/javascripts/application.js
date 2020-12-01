// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require jquery-ui/core
//= require activestorage
//= require turbolinks
//= require popper
//= require bootstrap-sprockets
//= require lightbox
//= require jquery-ui
//= require_tree .

$(function(){
  setTimeout("$('.time-limit').fadeOut('slow')", 3000)
})





$(document).on('turbolinks:load', function() {
  $("#theTarget").skippr({
    // スライドショーの変化 ("fade" or "slide")
    transition : 'slide',
    // 変化に係る時間(ミリ秒)
    speed : 1000,
    // easingの種類
    easing : 'easeOutQuart',
    // ナビゲーションの形("block" or "bubble")
    navType : 'block',
    // 子要素の種類("div" or "img")
    childrenElementType : 'div',
    // ナビゲーション矢印の表示(trueで表示)
    arrows : true,
    // スライドショーの自動再生(falseで自動再生なし)
    autoPlay : true,
    // 自動再生時のスライド切替間隔(ミリ秒)
    autoPlayDuration : 3000,
    // キーボードの矢印キーによるスライド送りの設定(trueで有効)
    keyboardOnAlways : true,
    // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
    hidePrevious : false
  });
});



// インクリメンタルサーチ、ライトボックスが効かなくなる。画面遷移時の効果 ⬇︎

$(window).on('load', function(){
   $('body').removeClass('fadeout');
 });


 $(function() {
   // ハッシュリンク(#)と別ウィンドウでページを開く場合はスルー
   $('a:not([href^="#"]):not([target]):not(a[rel*="lightbox[sample-group]"]):not([data-method]):not([class="lb-close"]):not([class="btn-delete"])').on('click', function(e){
     e.preventDefault(); // ナビゲートをキャンセル
     url = $(this).attr('href'); // 遷移先のURLを取得
     console.log('test tool')
     console.log(url)
     if (url !== '') {
       $('body').addClass('fadeout');  // bodyに class="fadeout"を挿入
       setTimeout(function(){
          window.location = url;  // 0.3秒後に取得したURLに遷移
       }, 300);
     }
     return false;
   });
 });



// スクロールした際の効果

$(function(){
    $(window).scroll(function (){
      $('.fadein').each(function(){
        var elemPos = $(this).offset().top;
        var scroll = $(window).scrollTop();
        var windowHeight = $(window).height();
        if (scroll > elemPos - windowHeight + 300){
            $(this).addClass('scrollin');
                }
        });
    });
});


$(function(){
  $('.multiple-items').slick({
    infinite: true,
    slidesToShow: 4,
    slidesToScroll: 3
  });
});
