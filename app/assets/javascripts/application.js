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
//= require listjs
//= require rails-ujs
//= require turbolinks
//= require cityList
//= require_tree .

// NOTE: ES6+ is not supported here. - Masa 2017-10-05

document.addEventListener('turbolinks:click', console.log('turbolinks:click'));
document.addEventListener(
  'turbolinks:before-visit',
  console.log('turbolinks:before-visit')
);
document.addEventListener('turbolinks:visit', console.log('turbolinks:visit'));
document.addEventListener(
  'turbolinks:request-start',
  console.log('turbolinks:request-start')
);
document.addEventListener(
  'turbolinks:request-end',
  console.log('turbolinks:click')
);
document.addEventListener(
  'turbolinks:before-cache',
  console.log('turbolinks:before-cache')
);
document.addEventListener(
  'turbolinks:before-render',
  console.log('turbolinks:before-render')
);
document.addEventListener('turbolinks:load', console.log('turbolinks:load'));
