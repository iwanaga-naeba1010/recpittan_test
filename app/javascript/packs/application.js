// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require('jquery');
require('cocoon-js');

import 'bootstrap';
import '../stylesheets/application.scss';
import './consult_recreation'; // recreationで料金相談するボタン
import './prefectures';
import '../../../reactSrc/index';
import '../events/index';

import "@fortawesome/fontawesome-free/js/all"
require.context('../images', true)
