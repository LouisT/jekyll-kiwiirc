# Jekyll Kiwi IRC Embedder
Easily embed Kiwi IRC within Jekyll pages or blog posts.

Installation
---
Place `kiwiirc.rb` in your `_plugins` directory. In your `_config.yml` file
make sure that `safe: false` is set to allow custom plugins.

_config.yml
---
```yaml
kiwiirc:
   custom:
      token: 3087b0899de5879c21147189d5cfd01b
   widget:
      channel: '#kiwiirc-default'
      server:  irc.kiwiirc.com
      port:    '+6697'
      nick:    kiwi?
```

Pages / Blog Posts
---
```
 # Embed a widget.
 {% kiwiirc_widget %}

 # Embed the custom client.
 {% kiwiirc_custom %}
```

Passing configuration in tags
---
```
 # Embed a widget.
 {% kiwiirc_widget server: irc.voltirc.net, channel: #chat, nick: lt? %}

 # Embed the custom client.
 {% kiwiirc_custom token: d7b61534ef45bb60e47579f69242927b %}
```

License
---
Copyright (c) 2016, Louis T. ([MIT License]).

[MIT License]: LICENSE
