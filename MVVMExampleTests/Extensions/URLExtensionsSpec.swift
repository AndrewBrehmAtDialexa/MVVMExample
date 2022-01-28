import Quick
import Nimble
@testable import MVVMExample

class URLExtensionsSpec: QuickSpec {
    override func spec() {
        describe("URL+Extensions") {
            var result: URL?
            
            describe("when .forOmdb(withSearchTerm:)") {
                beforeEach {
                    result = URL.forOmdb(withSearchTerm: "someText")
                }
                
                it("returns 'https://www.omdbapi.com/?s=someText&apikey=4afc8e2f'") {
                    expect(result?.absoluteString).to(equal("https://www.omdbapi.com/?s=someText&apikey=4afc8e2f"))
                }
            }
        }
    }
}
