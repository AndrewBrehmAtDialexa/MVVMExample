import Quick
import Nimble
@testable import MVVMExample

class HTTPServiceSpec: QuickSpec {
    override func spec() {
        describe("HTTPService") {
            var uut: HTTPService?
            var mockSession: MockURLSession?
            var mockData: Data?
            var completion: ((Result<Data, NetworkError>) -> Void)?
            var successWasCalled = false
            var failureWasCalled = false
            var completionData: Data?
            var completionError: NetworkError?
            
            beforeEach {
                uut = HTTPService.shared
                mockSession = MockURLSession()
                let mockModel = MockModel(someString: "someStringValue")
                mockData = try? JSONEncoder().encode(mockModel)
                
                completion = { result in
                    switch result {
                    case.success(let data):
                        successWasCalled = true
                        completionData = data
                    case.failure(let error):
                        failureWasCalled = true
                        completionError = error
                    }
                }
            }
            
            describe("when .get(withUrl:completion:)") {
                
                describe("and the result is success 200") {
                    describe("and the call returns data") {
                        beforeEach {
                            uut?.session = mockSession!.createMock(data: mockData!, statusCode: 200)
                            uut?.get(withUrl: mockSession!.givenUrl!, completion: completion!)
                        }
                        
                        it("calls the completion handler's success case") {
                            expect(successWasCalled).toEventually(beTrue())
                        }
                        
                        describe("that success case") {
                            it("returns the expected data") {
                                let decodedData = try? JSONDecoder().decode(MockModel.self, from: completionData!)
                                
                                expect(decodedData?.someString).to(equal("someStringValue"))
                            }
                        }
                    }
                    
                    describe("and the call does not return data") {
                        beforeEach {
                            uut?.session = mockSession!.createMock(statusCode: 200)
                            uut?.get(withUrl: mockSession!.givenUrl!, completion: completion!)
                        }
                        
                        it("calls the completion handler's failure case") {
                            expect(failureWasCalled).toEventually(beTrue())
                        }
                        
                        describe("that failure case") {
                            it("returns NetworkError.noData") {
                                expect(completionError).to(equal(.noData))
                            }
                        }
                    }
                }
                
                describe("and the result is failure 500") {
                    beforeEach {
                        
                        uut?.session = mockSession!.createMock(data: mockData!, statusCode: 500)
                        uut?.get(withUrl: mockSession!.givenUrl!, completion: completion!)
                    }
                    
                    it("calls the completion handler's failure case") {
                        expect(failureWasCalled).toEventually(beTrue())
                    }
                    
                    describe("that failure case") {
                        it("returns NetworkError.noData") {
                            expect(completionError).to(equal(.noData))
                        }
                    }
                }
            }
        }
    }
}
