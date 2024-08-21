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
// app/assets/javascripts/application.js
//= require rails-ujs
//= require turbolinks
//= require news_stories
//= require_tree .

document.addEventListener('DOMContentLoaded', function() {
  console.log("loading application!!!")

  var tabElms = document.querySelectorAll('button[data-bs-toggle="tab"]')
  tabElms.forEach(function(tabElm) {
    new bootstrap.Tab(tabElm)
  })

  // pagination logic
  document.addEventListener('click', function(event) {
    if (event.target.closest('.pagination a')) {
      event.preventDefault()
      var link = event.target.closest('.pagination a')
      var url = link.href
      var tabPane = link.closest('.tab-pane')
      var tabId = tabPane.id

      fetch(url)
        .then(response => response.text())
        .then(html => {
          var parser = new DOMParser()
          var doc = parser.parseFromString(html, 'text/html')
          var newContent = doc.querySelector('#' + tabId)

          if (newContent) {
            tabPane.innerHTML = newContent.innerHTML
            history.pushState({}, '', url)
          }
        })
        .catch(error => console.error('Error:', error))
    }
  })
})