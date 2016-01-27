import Quick
import Nimble
@testable import brighton

class HTTPClientSpec: QuickSpec {
    override func spec() {
        var httpClient: HTTPClient!
        let urlSession = MockURLSession()
        let task = MockURLSessionDataTask()

        beforeEach() {
            urlSession.mockURLSessionDataTask = task
            httpClient = HTTPClient(urlSession: urlSession)
        }

        describe("performing request") {
            let request = NSURLRequest()
            var completionWasCalled: Bool = false
            var returnedData: NSData?
            var returnedResponse: NSHTTPURLResponse?
            var returnedError: NSError?

            beforeEach() {
                completionWasCalled = false
                httpClient.perform(request: request) {
                    (data, response, error) -> Void in
                    completionWasCalled = true
                    returnedData = data
                    returnedResponse = response
                    returnedError = error
                }
            }

            it("makes a fetch-accounts request") {
                expect(urlSession.request).to(equal(request))
            }

            it("calls resume on the returned task") {
                expect(task.resumeWasCalled).to(beTrue())
            }

            describe("when the request returns") {
                let data = NSData()
                let response = NSHTTPURLResponse(URL: NSURL(string: "http://example.com")!, statusCode: 200, HTTPVersion: nil, headerFields: nil)
                let error = NSError(domain: "Error", code: 0, userInfo: nil)

                beforeEach() {
                    urlSession.completion(data, response, error)
                }

                it("calls its completion") {
                    expect(completionWasCalled).to(beTrue())
                }

                it("passes the data to its completion") {
                    expect(returnedData).to(equal(data))
                }

                it("passes the response to the completion") {
                    expect(returnedResponse).to(equal(response))
                }

                it("passes the error to the completion") {
                    expect(returnedError).to(equal(error))
                }
            }
        }
    }
}
