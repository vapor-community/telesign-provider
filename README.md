# Vapor Telesign Provider

![Swift](http://img.shields.io/badge/swift-4.1-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-3.0-brightgreen.svg)
[![CircleCI](https://circleci.com/gh/vapor-community/telesign-provider/tree/beta.svg?style=svg)](https://circleci.com/gh/vapor-community/telesign-provider/tree/beta)


## What's Telesign?
[Telesign][telesign_home] is a Communication Platform as a Service. Allowing you to send SMS messages for your use case, text to voice communications, phone identification to reduce risk/fraud and many other things.

## Integrating with your Vapor project
Start by adding the repo to your `Package.swift`

~~~~swift
.package(url: "https://github.com/vapor-community/telesign-provider.git", from: "2.0.0")
~~~~

Register the config and the provider to your Application
~~~~swift
let config = TelesignConfig(apiKey: "myapikey", customerId: "mycustomerId")

services.register(config)

try services.register(TelesignProvider())

app = try Application(services: services)

telesignClient = try app.make(TelesignClient.self)
~~~~

And you are all set. Interacting with the API is quite easy and adopts the `Future` syntax used in Vapor 3.
Making calls to the api is straight forward.
~~~~swift
try telesignClient.messaging.send(message: "Hello Vapor", to: "1234567", messageType: .ARN)
~~~~

## Supports the full API
* [x] Messaging
* [x] PhoneId
* [x] Score
* [x] Voice

[telesign_home]: https://www.telesign.com "Telesign"
