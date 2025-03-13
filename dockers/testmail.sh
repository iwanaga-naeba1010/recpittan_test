#!/bin/bash


bin/rails c <<EOF

ActionMailer::Base.mail(
  from: "info@everyplys.jp",
  to: "iwanaga@everyplus.jp",
  subject: "Test to mailhog",
  body: "Test from rails console"
).deliver_now

EOF
