# ExpandableLayout

|Execution|
|:--:|
![Simulator Screen Recording - iPhone 14 Pro - 2023-01-03 at 17 47 04](https://user-images.githubusercontent.com/61109660/210324780-652ed7ca-750c-48e8-b610-c3b5f257e8cd.gif)

### Summary
일단 나중에 작성하면 쓸 말을 잊어버릴까봐 대충 적는다. (말이 이상할 수도 있고, 문법이 안 맞을수도 있다.)  
아우.. 일단 그동안 여러 방법을 써서 구현은 했었는데 약간 레이아웃이 깨지는 이슈나 이런저런 찝찝함이 있어서 마음이 불편했는데 좋은 레퍼런스를 찾아서 나름 깔끔하게 해결했다.

1. Contents Size에 따라 결정되는 CollectionView Height
- 생각보다 개발하면서 필요한 순간이 많았다.
- 이제는 필요한 순간에 UICollectionView의 extension으로 만들거나 Custom class를 만들어서 사용하면 될 거 같다.
- intrinsic content size, layout cycle(ex. layoutSubviews) 등에 대한 이해가 필요하다.

2. DiffableDataSource, RxDataSource 2가지를 모두 사용해 봄
- RxDataSource에서 애니메이션효과를 적용하려고하면 RxCollectionViewSectionedAnimatedDataSource도 사용해야하고, 모델에 Hashable, Identifiable 프로토콜을 채택하는 것이 꽤나 번거로운데 이 때 DiffableDataSource이 확실히 좋다고 느꼈다. (역시 우리 것이 좋은 그런 것인가..?)
- 연습삼아 2가지 모두 사용해봤는데 한 번 더 정리할 필요가 있어보인다.

3. SnapKit의 Constraint 타입에 대해서 알게 됨
- 레이아웃을 잡다보면 NSLayoutConstraints 타입을 사용하는 경우가 있는데, SnapKit에서는 Constraint 타입을 사용할 수 있더라. (이건 처음 봄)
- isActive 속성을 토글해서 레이아웃을 적절히 잘 조정할 수 있다.
- Expandable 효과를 구현하기 위해 Constraint 타입의 프로퍼티 2가지(open, closed)를 만들어서 토글시켜준다.

4. Nested CollectionView Structure에 대한 고민점
- 글을 보다보면 중첩 구조가 좋지 않다는 글이 많이 보인다. (스크롤 중첩으로 인해 여러가지 이슈가 발생할 수 있다는 부분에서 동의는 한다.)
- 예제 프로젝트의 경우 CollectionView를 중첩해서 구조를 만들고 있는데 셀 안의 레이아웃을 CollectionView로 구성했을 때의 장점이 너무 뚜렷하게 보였기 때문이다. 내부의 컨텐츠를 각각의 UIComponents로 만들었을때 시간 공수가 많이 들어가고, 이후 수정이 쉽지 않다는 단점이 존재한다. CollectionView + Compositional Layout으로 만들었을때는 정말 쉽게 코드를 작성할 수 있고, 섹션의 추가/삭제에 따른 코드 수정도 편리하다고 생각했다.
- 그리고 셀 안에 들어가는 CollectionView의 경우 1번 내용과 같이 ContentSize에 따라 CollectionView 자체의 높이가 이미 결정되기때문에 스크롤 중첩 이슈도 어느정도 해결할 수 있다.
