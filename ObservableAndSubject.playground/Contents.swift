import Foundation
import RxSwift

//MARK:- Observalble

let randomNumGenerator1 = Observable<Int>.create { observer in
    observer.onNext(Int.random(in: 0..<100))
    return Disposables.create()
}

// able . subscribe (observer)
randomNumGenerator1.subscribe(onNext: { element in
    print("observer 1 : \(element)")
})

randomNumGenerator1.subscribe(onNext: { element in
    print("observer 2 : \(element)")
})

/*
 RESULT :
 observer가 해당 observable에 대해 '독자적인 실행'을 갖기 때문에
 subscribe를 두번 하면서 생성된 "두개의 observer" 여도
 observable이 "각각" 실행되면서 서로 다른 값이 전달된다
*/


// MARK: - Subject (BehaviorSubject)

let randomNumGenerator2 = BehaviorSubject(value: 0)
randomNumGenerator2.onNext(Int.random(in: 0..<100))

randomNumGenerator2.subscribe(onNext: { element in
    print("observer subject 1 : \(element)")
})

randomNumGenerator2.subscribe(onNext: { element in
    print("observer subject 2 : \(element)")
})

/*
 DISCOVER :
 .subscribe 자체가 '옵저버를 생성한다'는 뜻이구나
 
 RESULT:
 observer subject 1 : 51
 observer subject 2 : 51
 
 구독해서 생성될 observer에게 observable의 동일한 실행이 간다.
 observable의 실행이 공유되면서 같은 값이 프린트된다
 
 결과적으로 Ob-able에서 subscribe 하면 이벤트로 전달되는 것은
 항상 새로운 것(create코드가 새롭게 실행된 결과)고
 Subject에서 subscribe하면 subscribe 전에 수행된 onNext 등 하나의 공통된 것
*/


// MARK: - Observer 이자 Observable 인 Subject란
/*
 Subject가 ObserverType protocol을 따르고 있다.
 ObserverType은 func on(_event: Event<E>)를 구현해야 한다는 뜻
 */

let subject = BehaviorSubject(value: "")
subject.onNext("hihihihi")

// on함수를 구현하고 있기 때문에 onNext가 호출 가능한 것.
// Observer.onNext로 쓰기 때문에 옵저버가 이벤트를 방출한다고 생각할 수 있으나
// 이벤트 방출은 Ob-able이 하고
// ObserverType의 on함수의 설명은 "Notify observer about sequence event"



// MARK: - Subject 의 subscribe() 이해하기

public func subscribe(onNext: ((E) -> Void)? = nil, onError: ((Swift.Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil)
        -> Disposable {
            let disposable: Disposable
            
            if let disposed = onDisposed {
                disposable = Disposables.create(with: disposed)
            }
            else {
                disposable = Disposables.create()
            }
        
    // 중략
    
            return Disposables.create(
                //2) 'observer'에 대한 subscription. 이렇게 해서 해당 옵저버블에 대해 옵저버가 관찰을 할 수 있다.
                self.asObservable().subscribe(observer),
                disposable
                // 여기를 통해 해당 subject의 모든 observers에 대한 subscription이 담기게 되고
                // .on이 실행될 때 모든 observer가 nextEvent를 받을 수 있는 환경을 마련.
            )
    }
