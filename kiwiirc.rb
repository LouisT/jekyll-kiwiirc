# Jekyll Kiwi IRC Embedder
#
# Easily embed Kiwi IRC within Jekyll pages or blog posts.
#
# Example _config.yml configuration:
#
# kiwiirc:
#    custom:
#       token: 3087b0899de5879c21147189d5cfd01b
#    widget:
#       channel: '#kiwiirc-default'
#       server:  irc.kiwiirc.com
#       port:    '+6697'
#       nick:    kiwi?
#
# Exmaple page or blog usage:
#
# {% kiwiirc_widget %}
# {% kiwiirc_widget server: irc.voltirc.net, channel: #chat, nick: volt? %}
#
# Author: Louis T.
# Site: https://lou.ist/
# Plugin Source: http://github.com/LouisT/jekyll-url-shortener
# Plugin License: MIT
module Jekyll
  class KiwiConfig
    def self.defaults
      {
        'channel' => '#kiwiirc-default',
        'nick'    => 'kiwi?',
        'server'  => 'irc.kiwiirc.com',
        'port'    => '6667',
        'kiwiirc' => 'https://kiwiirc.com/client/',
        'width'   => '100%',
        'height'  => '450px',
        'token'   => '3087b0899de5879c21147189d5cfd01b'
      }
    end

    def self.parse (conf)
      parsed = {}

      conf.split(/\,\s/).each do |arg|
        value = arg.split(':')

        parsed[value[0].strip] = value[1].strip if value.size == 2
      end

      parsed
    end
  end

  class KiwiIRC < Liquid::Tag
    def initialize (name, conf, tokens)
      super
      @conf = conf
    end

    def render (context)
      widget = context.registers[:site].config['kiwiirc']['widget']
      set = KiwiConfig.defaults

      set.merge!(widget) if widget
      set.merge!(KiwiConfig.parse(@conf))

      %(<iframe src="#{set["kiwiirc"]}#{set["server"]}:#{set["port"]}/?nick=#{set["nick"]}#{set["channel"]}" style="border:0; width: #{set["width"]}; height:#{set["height"]};"></iframe>)
    end
  end

  class KiwiIRC_Custom < Liquid::Tag
    def initialize(name, conf, tokens)
      super
      @conf = conf;
    end

    def render(context)
      custom = context.registers[:site].config['kiwiirc']['custom']
      set = KiwiConfig.defaults

      set.merge!(custom) if custom
      set.merge!(KiwiConfig.parse(@conf))

      %(<iframe src="#{set["kiwiirc"]}?settings=#{set["token"]}" style="border:0; width: #{set["width"]}; height:#{set["height"]};"></iframe>)
    end
  end
end

Liquid::Template.register_tag('kiwiirc_widget', Jekyll::KiwiIRC)
Liquid::Template.register_tag('kiwiirc_custom', Jekyll::KiwiIRC_Custom)
