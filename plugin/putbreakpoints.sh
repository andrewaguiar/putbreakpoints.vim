#!/usr/bin/env bash
#
# Author: <Andrew S Aguiar>
#
# usage: putbreakpoint filename

RUBY_BYEBUG="byebug"
RUBY_PRY="(require 'pry'; binding.pry)"
RUBY_ERB_HTML_BYEBUG="<% byebug %>"
RUBY_ERB_HTML_PRY="<% (require 'pry'; binding.pry) %>"
JS="debugger"
ELIXIR="require IEx; IEx.pry"
ELIXIR_HTML_EEX="<% require IEx; IEx.pry %>"

function rb_using_pry() {
  if [ ! -f "Gemfile" ]; then
    PRY_GEMFILE_COUNT="0"
  else
    PRY_GEMFILE_COUNT="$(cat Gemfile|grep "pry-"|wc -l)"
  fi;
}

function ruby_bp() {
  rb_using_pry;

  if [ $PRY_GEMFILE_COUNT = "0" ]; then
    echo $RUBY_BYEBUG
  else
    echo $RUBY_PRY
  fi;
}

function ruby_html_erb_bp() {
  rb_using_pry;

  if [ $PRY_GEMFILE_COUNT = "0" ]; then
    echo $RUBY_ERB_HTML_BYEBUG
  else
    echo $RUBY_ERB_HTML_PRY
  fi;
}

case ${1,,} in
  *.html.erb)
    ruby_html_erb_bp;
  ;;
  *.rb|*.rake)
    ruby_bp;
  ;;
  *.html.eex)
    echo $ELIXIR_HTML_EEX;
  ;;
  *.ex|*.exs)
    echo $ELIXIR;
  ;;
  *.js|*.jsx)
    echo $JS;
  ;;
esac
