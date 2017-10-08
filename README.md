# Vapor Telesign Provider

![Swift](http://img.shields.io/badge/swift-3.1-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-2.0-brightgreen.svg)
[![CircleCI](https://circleci.com/gh/vapor-community/Telesign.svg?style=svg)](https://circleci.com/gh/vapor-community/Telesign)


## What's Telesign?
[Telesign][telesign_home] is a Communication Platform as a Service. Allowing you to send SMS messages for your use case, text to voice communications, phone identification to reduce risk/fraud and many other things.

## Integrating with your Vapor project
Start by adding the repo to your `Package.swift`
~~~~swift
.Package(url: "https://github.com/vapor-community/Telesign.git", majorVersion: 1)
~~~~

You'll need a config file as well. Place a `telesign.json` file in your `Config` folder
~~~~json
{
         "apiKey": "YOUR_API_KEY", 
         "clientId": "CLIENT_ID"
}
~~~~

Add the provider to your droplet
~~~~swift
import Telesign
...
try drop.addProvider(Telesign.Provider.self)
~~~~


Making calls with the api couldn't be easier
~~~~swift
let apiResult = try droplet.telesign?.messaging.send(message: "Hello Vapor", to: "12345678", messageType: .ARN)
~~~~

And you can also check the status of a message.
From our previous api call:

~~~~swift
let status = try droplet.telesign?.messaging.getResultFor(reference: apiResult?.referenceId ?? "").description ?? ""
print(status)
// Prints "Message in progress"
~~~~

## Implementation Progress
* [x] Messaging
* [x] PhoneId
* [x] Score
* [x] Voice


## Testing for those who want to fork a new branch

To avoid having to remember to add tests to `LinuxMain.swift` you can use [Sourcery][sourcery] to add your tets cases there for you. Just install the sourcery binary with Homebrew `brew install sourcery`, navigate to your project folder, and from the command line run the following:
~~~~bash
sourcery --sources Tests/ --templates Sourcery/LinuxMain.stencil --args testimports='@testable import TelesignTests'
~~~~
It will generate the following with your tests added:

~~~~swift
import XCTest
@testable import TelesignTests
extension Messagestests {
static var allTests = [
  ("testSending", testSending),
  ...
]
}
.
.
XCTMain([
  testCase(MessagesTests.allTests),
  ...
])
~~~~


[telesign_home]: http://telesign.com "Telesign"
[sourcery]: https://github.com/krzysztofzablocki/Sourcery "Sourcery"
