import UIKit


enum MethodName:String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class APIRequest:NSObject{
    
    fileprivate static let baseUrl = "https://silviyavelani.000webhostapp.com/Qrapi/"
    
    static func doRequestForJson(method:MethodName,queryString:String?,parameters:[String:Any]?,showLoading:Bool = true,hudText:String = "Loading...",returnError:Bool = false,completionHandler:@escaping (Any?,String?)->()){
        
        getDataFromServer(method: method, queryString: queryString, parameters: parameters, showLoading: showLoading, hudText: hudText,returnError: returnError) { (data, error) in
            if let errorFound = error{
                completionHandler(nil, errorFound)
            }else if let dataFound = data{
                
                let jsonView = NSString.init(data: dataFound, encoding: String.Encoding.utf8.rawValue)
                if let getjson = jsonView {
                    print(getjson)
                }
                
                do{
                    let json = try JSONSerialization.jsonObject(with: dataFound, options: .mutableContainers)
                    completionHandler(json, nil)
                }catch let err{
                    print(err.localizedDescription)
                    if returnError{
                        completionHandler(nil,"Something went wrong")
                    }else{
                        APIRequest.someThingWrong()
                    }
                }
            }
        }
    }
    
    static func doRequestForDecodable<T : Decodable>(decodablClass:T.Type,method:MethodName,queryString:String?,parameters:[String:Any]?,showLoading:Bool = true,hudText:String = "Loading...",returnError:Bool = false,completionHandler:@escaping (T?,String?)->()){
        
        getDataFromServer(method: method, queryString: queryString, parameters: parameters, showLoading: showLoading,hudText:hudText,  returnError: returnError) { (data, error) in
            if let errorFound = error{
                completionHandler(nil, errorFound)
            }else if let dataFound = data{
                do{
                    let decodable = try JSONDecoder().decode(decodablClass.self, from: dataFound)
                    completionHandler(decodable, nil)
                }catch let err{
                    print(err.localizedDescription)
                    if returnError{
                        completionHandler(nil,"Something went wrong")
                    }else{
                        APIRequest.someThingWrong()
                    }
                }
            }
        }
        
    }
    
    static func someThingWrong(msg:String = "Something went wrong"){
        print("Someting went wrong")
    }
    
    
    fileprivate static func getDataFromServer(method:MethodName,queryString:String?,parameters:[String:Any]?,showLoading:Bool = true,hudText:String = "Loading...",returnError:Bool = false,completionHandler:@escaping (Data?,String?)->()){
        
        var baseURLString = baseUrl
        if var query = queryString{
            query = query.replacingOccurrences(of: " ", with: "")
            if let first = query.first,first == "/"{
                query = String(query.dropFirst())
            }
            baseURLString += query
        }
        if let url = URL(string: baseURLString){
            
            var request = URLRequest(url: url,timeoutInterval: 60)
            request.httpMethod = method.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let params = parameters{
                do{
                    request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                }catch let err{
                    if returnError{
                        completionHandler(nil, err.localizedDescription)
                    }else{
                        APIRequest.someThingWrong()
                    }
                }
            }
            if showLoading {
                FVTHud.showHud(hudTexts: hudText)
            }
            
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                DispatchQueue.main.async(execute: {
                    if showLoading
                    {
                        FVTHud.hide()
                    }
                    if response == nil
                    {
                        AlertView.showNeworkError(title: "Network Error", message: "Plase check your internet/ wifi connections.")
                    }
                    
                    if let getResponse = response as? HTTPURLResponse
                    {
                        print(getResponse.statusCode)
                    }
                    
                    if let errorFound = error{
                        
                        if returnError{
                            completionHandler(nil, errorFound.localizedDescription)
                        }else{
                            APIRequest.someThingWrong(msg: errorFound.localizedDescription)
                        }
                        
                    }else if let dataFound = data{
                        completionHandler(dataFound, nil)
                    }else if returnError{
                        completionHandler(nil,"No data found")
                    }else{
                        completionHandler(nil,"No data found")
                    }
                })
            }).resume()
        }else{
            
            print("Invalid URL")
            if returnError{
                completionHandler(nil,"No data found")
            }else{
                APIRequest.someThingWrong()
            }
        }
    }
    
    
    
    
}

