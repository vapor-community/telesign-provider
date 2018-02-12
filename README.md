# Vapor Telesign Provider

![Swift](http://img.shields.io/badge/swift-4-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-3.0-brightgreen.svg)
[![CircleCI](https://circleci.com/gh/vapor-community/telesign/tree/beta.svg?style=svg)](https://circleci.com/gh/vapor-community/telesign/tree/beta)


## What's Telesign?
[Telesign][telesign_home] is a Communication Platform as a Service. Allowing you to send SMS messages for your use case, text to voice communications, phone identification to reduce risk/fraud and many other things.

## Integrating with your Vapor project
Start by adding the repo to your `Package.swift`

For Swift 4
~~~~swift
.package(url: "https://github.com/vapor-community/telesign-provider", .branch("beta"))
~~~~

Register the config and the provider to your Application
~~~~swift
let config = TelesignConfig(apiKey: "myapikey", clientId: "myclientid")

services.register(config)

try services.register(TelesignProvider())

app = try Application(services: services)

telesignClient = try app.make(TelesignClient.self)
~~~~

And you are all set. Interacting with the API is quite easy and adopts the `Future` syntax used in Vapor 3.
Making calls to the api is straight forward.
~~~~swift
let futureMessageResult = try telesignClient.messaging.send(message: "Hello Vapor", to: "1234567", messageType: .ARN)

futureMessageResult({ (message) in
// do something with message object...
}).catch({ (error) in
print(error)
})

~~~~

## Supports the full API
* [x] Messaging
* [x] PhoneId
* [x] Score
* [x] Voice

[telesign_home]: http://telesign.com "Telesign"
