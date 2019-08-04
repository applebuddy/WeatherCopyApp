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
    let urlSession = URLSession(configuration: .default)
    var dataTask = URLSessionDataTask()
    var baseURL = "https://api.darksky.net/forecast/"
    let APIToken = "447da2f0774b0e23418285c52c5ec67b/"
    let APISubURL = "?lang=ko&exclude=minutely,alerts,flags"
    var errorMessage = ""

    init() {
        // STEP 2) BaseURL에 API토큰을 추가한다.
        setBaseURL(token: APIToken)
    }

    // completion: @escaping weatherResult
    func requestAPI(latitude: Double, longitude: Double, completion: @escaping (WeatherAPIData) -> Void) {
        let APIUrlString = "\(baseURL)\(latitude),\(longitude)\(APISubURL)"
        print("APIUrlString: \(APIUrlString)")
        guard let APIUrl = URL(string: APIUrlString) else { return }

        // STEP 4-1) URLSessionDataTash 초기화
        dataTask = urlSession.dataTask(with: APIUrl) { data, response, error in
            // STEP 4-2) 데이터 요청 간 에러유무를 판별한다.
            if let error = error {
                self.errorMessage = "\(error.localizedDescription)"
            }

            // STEP 4-2) HTTP URL 요청 시 응답이 있는지 확인한다.
            if let response = response as? HTTPURLResponse {
                // 응답 결과에 따라 데이터 처리를 시도한다.
                if (200 ... 299).contains(response.statusCode) {
                    guard let data = data else { return }
                    do {
                        let weatherAPIData = try JSONDecoder().decode(WeatherAPIData.self, from: data)
                        completion(weatherAPIData)
                    } catch let DecodingError.keyNotFound(key, _) {
                        print("Missing key in JSON: \(key).")
                    } catch let DecodingError.typeMismatch(type, context) {
                        print("Wring type in JSON: \(type) \(context)")
                    } catch {
                        print("Unable to parse JSON: \(error.localizedDescription)")
                    }
                } else {
                    self.errorMessage = "응답코드 오류 : \(response.statusCode)"
                }
            }

            // STEP 5) 데이터 처리 결과를 completion handler을 통해 반환한다.
        }

        // STEP 6) 정지된 상태에서 dataTask를 실행시킨다.
        dataTask.resume()
    }

    func setBaseURL(token _: String) {
        baseURL.append(APIToken)
    }
}
