# 📈 AllLaRight

### 디지털 자산의 정보를 한눈에 모아보고 추세를 확인하세요!

<img width="200" alt="Market" src="https://github.com/user-attachments/assets/33db47ba-1f06-42e2-bcea-3eb268544eea">  <img width="200" alt="Trending" src="https://github.com/user-attachments/assets/ca2223ed-f0da-4f92-8c8b-90b395d62dc9">  <img width="200" alt="Detail" src="https://github.com/user-attachments/assets/b9e1cfbd-e31b-4cf1-8643-ee96c62acf27">  <img width="200" alt="favorite" src="https://github.com/user-attachments/assets/052f8f5a-45c5-4706-b00c-e00cb299efe7">


## 📈 앱 소개

### AllLaRight은 어떤 앱인가요?

내가 가진 디지털 자산아 올라랏!

5초마다 업데이트 되는 디지털 자산의 추세를 확인하고, 마음에 드는 디지털 자산을 즐겨찾기하고, 종목의 상세 정보도 쉽게 검색해보세요!

## ⭐️ 주요 기능

### 디지털 자산 실시간 추세 한눈에 보기

거래소 화면에서 5초마다 실시간 추세를 확인하세요!

현재가와 전일대비 수치, 거래대금이 5초마다 업데이트 됩니다.

각 범주에 따라 정렬을 바꿀수도 있습니다.

<img width="250" alt="Main" src="https://github.com/user-attachments/assets/dd6bc7b8-7f32-4480-8b5b-68f31a4e3a2f">

### 디지털 자산 검색 및 상세보기

오늘의 인기 디지털 자산과 NFT 정보를 한 눈에 확인하세요!

원하는 코인을 쉽게 검색도 할 수 있으며, 인기 검색어에서도 상세 정보를 바로 확인할 수 있습니다.

<img width="250" alt="Main" src="https://github.com/user-attachments/assets/99c5cc0d-d672-4d5f-8762-7307295b05ed">

### 즐겨찾기 및 포트폴리오

포트폴리오 화면에서 즐겨찾기 한 디지털 자산을 확인하세요!

원하는 디지털자산을 즐겨찾기 할 수 있숩니다.

즐겨찾기 한 디지털 자산의 현재가와 등략률을 확인할 수 있습니다.

<img width="250" alt="Main" src="https://github.com/user-attachments/assets/f393be65-fc7d-475b-856a-b4db8661fdd9">

# ⚙️ Project

## 🧑‍💻 개발 인원 및 기간

### 개발 인원

- 1인 개발
    - https://github.com/WooFeather

### 개발 기간

- 6일(1차 MVP 기준):
    - 25/03/06 ~ 25/03/11

## 💻 기술 스택

### 사용한 기술

- Framework
    - UIKit
- Architecture
    - MVVM / Input-Output
- Library
    - RxSwift
        - RxDataSource
        - RxGesture
    - Realm
    - Alamofire
    - Kingfisher
    - Snapkit
    - Toast
    - DGChart
 
### 기술 설명
- **Alamofier와 Single객체를 이용한 네트워크 통신**
    - RxSwift의 Single로 Alamofier 요청을 래핑하여, 비동기 호출 결과를 단일 이벤트로 명확하게 처리했습니다.
    - 제네릭 구조를 통해 서로 다른 모델 타입에 재사용 하도록 설계했으며, HTTP 상태코드별로 CustomError를 enum 타입으로 분류해 에러 핸들링을 했습니다.
- **timer Observable을 통한 실시간 네트워크 통신**
    - Observable.timer를 이용해 API로부터 일정 주기마다 요청을 처리했습니다.
    - timer의 구독을 별도의 disposeBag으로 관리하여, 정렬기준을 변경했을때도 timer가 중첩으로 구독되는 문제를 방지했습니다.
- **RxDataSource와 Comopsitional Layout을 통한 CollectionView 구성**
    - Compositional Layout을 이용해 하나의 CollectionView에서 그룹 형태, 횡스크롤 형태 등 다양한 레이아웃을 구성했습니다.
    - RxCocoa에서 제공하지 않는 섹션 기능을 사용하기 위해 RxDataSource를 통해 CollectionView를 구성하고, UICollectionReusableView를 통해 각 섹션의 헤더를 구현했습니다.
- **Realm을 통한 DB 관리**
    - Realm DB를 통해 즐겨찾기 데이터들을 관리했습니다.
    - Repository 패턴을 도입해 효율적으로 Realm에 접근해 DB를 관리했습니다.
