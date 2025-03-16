#!/bin/bash


in/rails c <<EOF

s = SlackNotifier.new(channel: '#welbing-development').send('start rails')

EOF



