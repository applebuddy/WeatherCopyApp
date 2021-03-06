//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by MinKyeongTae on 04/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

final class WeatherAPI {
    static let shared = WeatherAPI()

    // STEP 1) JSON데이터를 받기 위해 사용할 변수와 API토큰을 준비한다.
    // ✓ REVIEW: [Refactroing] 외부에서 접근할 수 없도록 private 로 설정하는 것이 캡슐화에 도움이 됩니다.
    private let urlSession = URLSession(configuration: .default)
    private var dataTask = URLSessionDataTask()
    private var baseURL = "https://api.darksky.net/forecast/"
    private let APIToken = "447da2f0774b0e23418285c52c5ec67b/" // 자신의 날씨 API+'/'를 사용합니다.

    // 447da2f0774b0e23418285c52c5ec67b
    private let APISubURL = "?lang=ko&exclude=minutely,alerts,flags"
    private var errorMessage = ""

    var requestSet = Set<Int>()
    // REVIEW: [경고] weak 키워드를 붙이지 않으면 강한 상호 참조가 됩니다.
    weak var delegate: WeatherAPIDelegate?

    init() {
        // STEP 2) BaseURL에 API토큰을 추가한다.
        setBaseURL(token: APIToken)
    }

    /// REVIEW: Result<WeatherAPIData, Error> 로 정리하는 것이 어떨까요?
    // delegate 를 사용하면 다른 곳에서 사용하게 된다면 문제가 발생합니다.
    func requestAPI(latitude: Double, longitude: Double, row index: Int, completion: @escaping (WeatherAPIData?, Bool) -> Void) {
        delegate?.weatherAPIDidRequested(self, row: index)
        let APIUrlString = "\(baseURL)\(latitude),\(longitude)\(APISubURL)"
        guard let APIUrl = URL(string: APIUrlString) else { return }

        dataTask = urlSession.dataTask(with: APIUrl) { data, response, error in

            if let error = error {
                self.errorMessage = "\(error.localizedDescription)"
                self.delegate?.weatherAPIDidError(self, row: index)
            }

            // HTTP URL 요청 시 응답이 있는지 확인한다.
            if let response = response as? HTTPURLResponse {
                // 응답 결과에 따라 데이터 처리를 시도한다.
                if (200 ... 299).contains(response.statusCode) {
                    guard let data = data else { return }
                    do {
                        let weatherAPIData = try JSONDecoder().decode(WeatherAPIData.self, from: data)
                        self.delegate?.weatherAPIDidFinished(self, row: index)
                        completion(weatherAPIData, true)
                    } catch DecodingError.keyNotFound(_, _) {
                        self.delegate?.weatherAPIDidError(self, row: index)
                        completion(nil, false)
                    } catch DecodingError.typeMismatch(_, _) {
                        self.delegate?.weatherAPIDidError(self, row: index)
                        completion(nil, false)
                    } catch {
                        self.delegate?.weatherAPIDidError(self, row: index)
                        completion(nil, false)
                    }
                } else {
                    self.delegate?.weatherAPIDidError(self, row: index)
                    completion(nil, false)
                }
            } else {
                debugPrint("Could'nt find any responses")
                completion(nil, false)
            }

            // 데이터 처리 결과를 completion handler을 통해 반환한다.
        }

        // 정지된 상태에서 dataTask를 실행시킨다.
        dataTask.resume()
    }

    private func setBaseURL(token _: String) {
        baseURL.append(APIToken)
    }
}
