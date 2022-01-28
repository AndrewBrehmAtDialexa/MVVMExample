import Quick
import Nimble
@testable import MVVMExample

class StringExtensionsSpec: QuickSpec {
    override func spec() {
        describe("String+Extensions") {
            var result: String?
            
            describe("when .encoded") {
                beforeEach {
                    result = "Some Text Here".encoded
                }
                
                it("returns ''") {
                    expect(result).to(equal("Some%20Text%20Here"))
                }
            }
        }
    }
}
