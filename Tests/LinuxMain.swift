import XCTest

import DataStreamTests

var tests = [XCTestCaseEntry]()
tests += DataStreamTests.allTests()
tests += OutputDataStreamTests.allTests()
tests += RoundtripTests.allTests()
XCTMain(tests)
