## Sensu-Plugins-Rocketchat

[![Gem Version](https://badge.fury.io/rb/sensu-plugins-rocketchat.svg)](http://badge.fury.io/rb/sensu-plugins-rocketchat)

## Functionality

Sends notifications to Rocket.Chat through REST API

## Files

  * bin/handler-rocketchat.rb

## Usage

Configure Rocket.Chat credentials, url and channel:

```
{
  "rocketchat": {
    "username": "username",
    "password": "password",
    "api_url": "https://chat.example.com",
    "channel": "sensu"
  }
}
```

Create a handler:

```
{
  "handlers": {
    "rocketchat": {
      "type": "pipe",
      "command": "/opt/sensu/embedded/bin/handler-rocketchat.rb"
    }
  }
}
```

## Installation

[Installation and Setup](http://sensu-plugins.io/docs/installation_instructions.html)
