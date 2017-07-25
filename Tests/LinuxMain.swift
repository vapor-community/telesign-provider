// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import TelesignTests

extension MessagingTests {
static var allTests = [
  ("testGetMessageSatus", testGetMessageSatus),
  ("testMessageSuccessfullyDeliveredAFter10Seconds", testMessageSuccessfullyDeliveredAFter10Seconds),
]
}

extension PhoneIdTests {
static var allTests = [
  ("testPhoneIdIsAccurate", testPhoneIdIsAccurate),
]
}

extension ScoreTests {
static var allTests = [
  ("testPhoneIdIsAccurate", testPhoneIdIsAccurate),
]
}


XCTMain([
  testCase(MessagingTests.allTests),
  testCase(PhoneIdTests.allTests),
  testCase(ScoreTests.allTests),
])
