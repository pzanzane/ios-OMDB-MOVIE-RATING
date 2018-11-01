//
//  ModelRequest.swift
//  TestDemo
//
//  Created by Apple on 01/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
public protocol BaseRequest: Codable {
}
public class RequestMoview : BaseRequest{
    public var searchType:String!
    public var searchText:String!
    
}
