# RxSwift





**Observable Stream** 

|        |     Iterable     |     Observable     |
| :----: | :--------------: | :----------------: |
| 데이터 받기 |     T next()     |     onNext(T)      |
| 에러 발견  | Throws Exception | onError(Exception) |
|   완료   |    !hasNext()    |     onComplete     |

`.distinctUntilChanged()` : 새로운 값이 이전의 값과 같은지 확인

`.subscribe` : *Disposable* 객체를 반환. Dispose 실행 시 stream이 끊김(onComplete). 받은 것을 반응만 한다

`.addDisposableTo(disposeBag)` : stream이 끝나는 지점을 지정하지 않아도 됌

`map(x => 10 * x)`

`filter(x => x > 10)`

`zip` : stream을 매치 시켜서 보내줌 



스마트폰은 *관찰이 가능(**observable**)* 합니다. 스마트폰은 페이스북 알림, 메세지, 스냅챗 알림 등과 같이 *신호(**signal**)를 방출* 합니다. 우리는 자연적으로 스마트폰을 *구독(**subscribe**)하고* 있고, 모든 알림을. 홈 스크린에서 확인할 수 있습니다. 이제 그 *신호(**signal**)* 로 무엇을 할 지 정할 수 있습니다. 우리는 *관찰자 (**observer**)* 입니다.



- **Subject** : *Observable*, *Observer* 를 통칭
  - **BehaviorSubject** : *Subject* 에 의해 반환한 가장 최근 값. + 구독 이후에 반환하는 값
    - **Variable** : `.onNext` 이벤트만 제출 가능. 해제 시, `.onCompleted()` 이벤트 호출
    - `.onError()` , `.onCompleted()` 전송에 직접 접근 가능
  - **PublishSubject** : 구독 이후에 반환하는 값
  - **ReplaySubject** : 구독 이전에 반환한 값(버퍼사이즈)