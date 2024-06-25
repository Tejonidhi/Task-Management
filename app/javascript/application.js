// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import "controllers"
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require_tree .

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import $ from 'jquery'

Rails.start()
Turbolinks.start()

$(document).on('turbolinks:load', function() {
  $(".alert").delay(3000).slideUp(200, function() {
    $(this).alert('close');
  });
});
