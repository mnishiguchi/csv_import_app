window.App = window.App || {};

window.App.cityList = null;

window.App.initCityList = function() {
  document.addEventListener('turbolinks:load', function() {
    window.App.cityList = new List('city-list', { valueNames: ['city'] });

    // Since listjs does not provide a teardown function, we need to clear turbolinks cache.
    Turbolinks.clearCache();
  });
};
