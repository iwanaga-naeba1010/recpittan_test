// Load Active Admin's styles into Webpacker,
// see `active_admin.scss` for customization.
import "../stylesheets/active_admin.scss";

import "@activeadmin/activeadmin";
import "activeadmin_addons"

import "@fortawesome/fontawesome-free/css/all.css";
import 'arctic_admin'
import '../events/admin/order';
import * as $ from 'jquery';

import React from "react";
import { createRoot } from "react-dom/client";
import AdminDatePicker from "../components/admin_datepicker.ts";

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".react-datepicker").forEach((element) => {
    const name = element.dataset.name;
    const value = element.dataset.value;
    const id = element.id;

    const root = createRoot(element);
    root.render(<AdminDatePicker name={name} id={id} value={value} />);
  });
});
