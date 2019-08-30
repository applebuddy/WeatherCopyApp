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
    // ✓ Review: [Refactroing] 외부에서 접근할 수 없도록 private 로 설정하는 것이 캡슐화에 도움이 됩니다.
    private let urlSession = URLSession(configuration: .default)
    private var dataTask = URLSessionDataTask()
    private var baseURL = "https://api.darksky.net/forecast/"
    
    // Review: APIToken은 외부에 드러나지 않는게 좋을 것 같습니다. ( Review By Milkyo )
    private let APIToken = "447da2f0774b0e23418285c52c5ec67b/" // 자신의 날씨 API+'/'를 사용합니다.

    // 447da2f0774b0e23418285c52c5ec67b
    private let APISubURL = "?lang=ko&exclude=minutely,alerts,flags"
    private var errorMessage = ""

    // Review: [경고] weak 키워드를 붙이지 않으면 강한 상호 참조가 됩니다.
    weak var delegate: WeatherAPIDelegate?

    init() {
        // STEP 2) BaseURL에 API토큰을 추가한다.
        setBaseURL(token: APIToken)
    }

    // completion: @escaping weatherResult
    // Result<WeatherAPIData, Error> 로 정리하는 것이 어떨까요?
    // delegate 를 사용하면 다른 곳에서 사용하게 된다면 문제가 발생합니다.
    // Review: completion에 Result 타입을 사용해보면 어떨까요? ( Review By Milkyo )
    func requestAPI(latitude: Double, longitude: Double, completion: @escaping (WeatherAPIData?, Bool) -> Void) {
        delegate?.weatherAPIDidRequested(self)
        // ✓ Review: 이 부분은 URLCompent 를 알아보시면 더 좋은 코드가 될 것 같습니다. ( Review By Milkyo )
        let APIUrlString = "\(baseURL)\(latitude),\(longitude)\(APISubURL)"
        print("API URL : \(APIUrlString)")
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
                        print("timestamp : \(weatherAPIData.currently.time)")
                        completion(weatherAPIData, true)
                    } catch DecodingError.keyNotFound(_, _) {
                        self.delegate?.weatherAPIDidError(self)
                        completion(nil, false)
                    } catch DecodingError.typeMismatch(_, _) {
                        self.delegate?.weatherAPIDidError(self)
                        completion(nil, false)
                    } catch {
                        self.delegate?.weatherAPIDidError(self)
                        completion(nil, false)
                    }
                } else {
                    self.delegate?.weatherAPIDidError(self)
                    completion(nil, false)
                }
            } else {
                debugPrint("Could'nt find any responses")
                completion(nil, false)
            }

            // STEP 5) 데이터 처리 결과를 completion handler을 통해 반환한다.
        }

        // STEP 6) 정지된 상태에서 dataTask를 실행시킨다.
        dataTask.resume()
    }

    private func setBaseURL(token _: String) {
        baseURL.append(APIToken)
    }
}
