# TelesignProvider

![Swift](http://img.shields.io/badge/swift-5.1-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-4.0-brightgreen.svg)

### TelesignProvider is a Vapor wrapper around [TelesignKit](https://github.com/vapor-community/TelesignKit)

## Installation

In your `Package.swift` file, add the following

```swift
.package(url: "https://github.com/vapor-community/telesign-provider.git", from: "3.0.0-beta")
```

Register the provider to your Application in `Configure.swift`
~~~~swift
app.register(TelesignProvider(apiKey: "YOUR_API_KEY", customerId: "YOUR_CUSTOMER_ID"))
~~~~

Now we can interact with the API via the `TelesignClient` that's created on your behalf via the Provider we just registered. 
~~~~swift
import Telesign

let telesignClient = app.make(TelesignClient.self)

telesignClient.messaging.send(message: "Hello Vapor!", to: "1234567", messageType: .ARN)
~~~~
