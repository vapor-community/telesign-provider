// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
@testable import TelesignTests

extension MessagingTests {
static var allTests = [
  ("testGetMessageSatus", testGetMessageSatus),
  ("testMessageNotRejectedAFter10Seconds", testMessageNotRejectedAFter10Seconds),
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

extension VoiceTests {
static var allTests = [
  ("testGetMessageSatus", testGetMessageSatus),
  ("testCallSuccessfullyPlaced", testCallSuccessfullyPlaced),
]
}


XCTMain([
  testCase(MessagingTests.allTests),
  testCase(PhoneIdTests.allTests),
  testCase(ScoreTests.allTests),
  testCase(VoiceTests.allTests),
])
