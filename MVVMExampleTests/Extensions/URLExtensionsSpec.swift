import Quick
import Nimble
@testable import MVVMExample

class URLExtensionsSpec: QuickSpec {
    override func spec() {
        describe("URL+Extensions") {
            var result: URL?
            
            describe("when .forOmdb(withSearchTerm:)") {
                describe("when it has a valid search term") {
                    beforeEach {
                        result = URL.forOmdb(withSearchTerm: "someText")
                    }
                    
                    it("returns 'https://www.omdbapi.com/?s=someText&apikey=4afc8e2f'") {
                        expect(result?.absoluteString).to(equal("https://www.omdbapi.com/?s=someText&apikey=4afc8e2f"))
                    }
                }
                
                describe("when it does NOT have a valid search term") {
                    beforeEach {
                        result = URL.forOmdb(withSearchTerm: "|")
                    }
                    
                    it("returns nil") {
                        expect(result).to(beNil())
                    }
                }
            }
            
            describe("when .forPosterImage(withUrlString:)") {
                describe("when it has a valid url") {
                    beforeEach {
                        result = URL.forPosterImage(withUrlString: "someUrl")
                    }
                    
                    it("returns 'https://www.omdbapi.com/?s=someText&apikey=4afc8e2f'") {
                        expect(result?.absoluteString).to(equal("someUrl"))
                    }
                }
                
                describe("when it does NOT have") {
                    beforeEach {
                        result = URL.forPosterImage(withUrlString: "|")
                    }
                    
                    it("returns nil") {
                        expect(result).to(beNil())
                    }
                }
            }
        }
    }
}
