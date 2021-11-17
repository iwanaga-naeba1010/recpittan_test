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
// require('popper.js');
import 'bootstrap';
import '../stylesheets/application.scss';
import '../stylesheets/partner.scss';
import './prefecture_for_edit_user_form';
import './zip_for_edit_user_form';
import './consult_recreation'; // recreationで料金相談するボタン
import './prefectures';
import '../events/order_form';

import "@fortawesome/fontawesome-free/js/all"
require.context('../images', true)
