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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .

/*global $*/

// 各種イベント処理
$(document).on('turbolinks:load', function(){

  // ハンバーガーメニューアイコンをクリックした場合の処理
  $('.menu-trigger').on('click', function(event) {
    // ハンバーガーメニューアイコンの変形
    $(this).toggleClass('active');
    // メニューのフェードイン、フェードアウト
    $('#sp-menu').fadeToggle();
    // 黒背景のフェードイン、フェードアウト
    $('#blackBg').fadeToggle();
    // イベントの終了
    event.preventDefault();
  });

  // メニュー表示時に黒背景部分をクリックした場合の処理
  $('#blackBg').on('click', function() {
    // ハンバーガーメニューアイコンの変形
    $('.menu-trigger').toggleClass('active');
    // メニューのフェードアウト
    $('#sp-menu').fadeToggle();
    // 黒背景のフェードアウト
    $(this).fadeToggle();
    // イベントの終了
    event.preventDefault();
  });

  // タブメニューの初期状態
  $('#tab-contents .tab[id != "tab1"]').hide();
  // タブメニュークリック時の動作
  $('#tab-menu a').on('click', function(event) {
    console.log("tab")
    $("#tab-contents .tab").hide();
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });

  // 注文入力画面の住所フォームの表示切り替え
  $('.address-type').change( function() {
    if($('[id=new-address]').prop('checked')){
      $('#new-address-box').show();
    } else {
      $('#new-address-box').hide();
    }
  });

});