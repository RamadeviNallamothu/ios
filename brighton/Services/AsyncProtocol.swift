import Foundation

protocol AsyncProtocol {
    func performOnMainQueue(closure: () ->Void)
}