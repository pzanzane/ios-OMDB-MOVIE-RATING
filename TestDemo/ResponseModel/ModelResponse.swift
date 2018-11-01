//
//  ModelResponse.swift
//  TestDemo
//
//  Created by Apple on 01/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
public protocol BaseResponseModel:Decodable{
}
open class PlatformError : BaseResponseModel {
    public var message:String?
    public var errorCode:String?
}
public class ResponseMovieSearch : BaseResponseModel{
    public var totalResults:String?
    public var Response:String?
    public var Error:String?
    public var Search:[ResponseSearch]?
}

public class ResponseSearch : BaseResponseModel{
    public var Title:String?
    public var Year:String?
    public var imdbID:String?
    public var `Type`:String?
    public var Poster:String?
}

public class ResponseMoviewDetails : BaseResponseModel{
    public var Title:String?
    public var Year:String?
    public var Rated:String?
    public var Released:String?
   
    public var Runtime:String?
    public var Genre:String?
    public var Director:String?
    public var Writer:String?
    
    public var Actors:String?
    public var Plot:String?
    public var Language:String?
    public var Country:String?
    
    public var Awards:String?
    public var Poster:String?
    public var Metascore:String?
    public var imdbRating:String?
    
    public var imdbVotes:String?
    public var imdbID:String?
    public var `Type`:String?
    public var totalSeasons:String?
    
    public var Ratings:[MoviewRatings]?
}

public class MoviewRatings : BaseResponseModel{
    public var Source:String?
    public var Value:String?
}
