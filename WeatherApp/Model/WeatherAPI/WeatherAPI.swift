//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 04/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class WeatherAPI {
    static let shared = WeatherAPI()

    // STEP 1) JSON데이터를 받기 위해 사용할 변수와 API토큰을 준비한다.
    public let urlSession = URLSession(configuration: .default)
    public var dataTask = URLSessionDataTask()
    public var baseURL = "https://api.darksky.net/forecast/"
    public let APIToken = "8073e832590a6b75a9bbf52af77efcd3/"
    public let APISubURL = "?lang=ko&exclude=minutely,alerts,flags"
    public var errorMessage = ""
    internal var delegate: WeatherAPIDelegate?

    init() {
        // STEP 2) BaseURL에 API토큰을 추가한다.
        setBaseURL(token: APIToken)
    }

    // completion: @escaping weatherResult
    public func requestAPI(latitude: Double, longitude: Double, completion: @escaping (WeatherAPIData) -> Void) {
        delegate?.weatherAPIDidRequested(self)
        let APIUrlString = "\(baseURL)\(latitude),\(longitude)\(APISubURL)"
        guard let APIUrl = URL(string: APIUrlString) else { return }

        // STEP 4-1) URLSessionDataTash 초기화
        dataTask = urlSession.dataTask(with: APIUrl) { data, response, error in
            // STEP 4-2) 데이터 요청 간 에러유무를 판별한다.
            if let error = error {
                self.errorMessage = "\(error.localizedDescription)"
                self.delegate?.weatherAPIDidError(self)
            }

            // STEP 4-2) HTTP URL 요청 시 응답이 있는지 확인한다.
            if let response = response as? HTTPURLResponse {
                // 응답 결과에 따라 데이터 처리를 시도한다.
                if (200 ... 299).contains(response.statusCode) {
                    guard let data = data else { return }
                    do {
                        let weatherAPIData = try JSONDecoder().decode(WeatherAPIData.self, from: data)
                        self.delegate?.weatherAPIDidFinished(self)
                        completion(weatherAPIData)
                    } catch let DecodingError.keyNotFound(key, _) {
                        self.delegate?.weatherAPIDidError(self)
                    } catch let DecodingError.typeMismatch(type, context) {
                        self.delegate?.weatherAPIDidError(self)
                    } catch {
                        self.delegate?.weatherAPIDidError(self)
                    }
                } else {
                    self.delegate?.weatherAPIDidError(self)
                }
            }

            // STEP 5) 데이터 처리 결과를 completion handler을 통해 반환한다.
        }

        // STEP 6) 정지된 상태에서 dataTask를 실행시킨다.
        dataTask.resume()
    }

    public func setBaseURL(token _: String) {
        baseURL.append(APIToken)
    }
}
