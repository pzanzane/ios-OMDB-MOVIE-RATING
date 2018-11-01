//
//  Router.swift
//  TestDemo
//
//  Created by Apple on 01/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//
import Foundation
import Alamofire

public enum Method: String {
    case OPTIONS = "OPTIONS"
    case GET = "GET"
    case HEAD = "HEAD"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
    case TRACE = "TRACE"
    case CONNECT = "CONNECT"
}


enum Router : URLRequestConvertible {
    static var baseURLString = ""
    static let perPage = 30
    
    // authentications
    case getMoviewSearch(request: RequestMoview)
    case getMoviewDetails(request: RequestMoview)

    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let (method, path, requestJson, params): (Method, String, Data?, [String:Any]?) = getRouterInfo()
        
        let urlstring1 =  Router.baseURLString+path
        let urlString = urlstring1.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

        let URL = Foundation.URL(string: urlString!)!
        var request = URLRequest(url: URL)
        request.httpMethod = method.rawValue
        if let requestJson = requestJson {
            let jsonData = requestJson
            request.httpBody = jsonData
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return try Alamofire.URLEncoding.queryString.encode(request, with: params)
    }
    
    
    func getRouterInfo () -> (Method,String,Data?,[String:Any]?) {
        switch(self) {
        // SESSIONS
        case .getMoviewSearch(let request):
            return (Method.GET,"?apikey=thewdb&\(request.searchType!)=\(request.searchText!)",nil,nil)
            
        case .getMoviewDetails(let request):
            return (Method.GET,"?apikey=thewdb&\(request.searchType!)=\(request.searchText!)",nil,nil)
        }
    }
    func encode <T: BaseRequest>(_ requestObj: T) -> Data?{
        return try? JSONEncoder().encode(requestObj)
    }
}

