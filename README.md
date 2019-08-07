# 애플 날씨앱 따라만들기

애플 기본날씨앱 따라하기 프로젝트

## 개요

사전과제인 애플날씨앱 프로젝트입니다. 스토리보드 없이 코드로만 진행하여 클래스 별 간단한 사용목적을 정리했습니다.

### Model

** WeatherAPI **
* WeatherAPI : 날씨 API는 DarkSky를 활용했습니다. API를 처리하고 결과에 따른 결과값을 반환하는 싱글턴 클래스
* WeatherAPIData : 날씨 API Codable 데이터 포맷

* CommonData : 전반적인 앱 실행 간 활용 될 수 있는 공용 싱글턴 클래스입니다.
* WeatherData : 날씨관련 수치를 표현하는 구조체 모음
  - SubWeatherData, SubLocationData는 UserDefault를 통한 데이터 저장 시 사용하는 포맷

** Constant **
* 변하지 않는 데이터 값 그룹

** Extension **
* 범용으로 사용되는 Extension 그룹

** Protocol **
* UIViewSettingProtocol : 서브뷰 추가, 제약값 설정 등 중복되는 메서드를 정리한 프로토콜
* CellSettingProtocol : 셀 셋팅 관련 중복 메서드를 정리한 프로토콜 

### Controller

* MainNavigationController : 메인으로 사용하는 네비게이션 뷰 컨트롤러
* WeatherMainViewController : 설정한 도시 별 날씨 정보를 보여주는 뷰 컨트롤러
* WeatherInfoViewController : 도시 별 상세 날씨정보를 보여주는 뷰 컨트롤러
  - (미구현)페이지뷰 기능을 관리
* (미구현)WeatherContentViewController : 페이지뷰 컨텐츠 뷰컨트롤러
* WeatherCitySearchViewController : 도시 검색 및 날씨정보 추가를 하는 뷰 컨트롤러

### View
