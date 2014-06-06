클론 후 최초 설치 방법
=================

## Facebook 앱 개설
nitrous.io 와 같은 클라우드 개발환경을 쓰고 있다면 페북 로그인을 테스트하기 위해 별도의 facebook 앱을 https://developers.facebook.com/apps 에서 개설해야합니다.
## facebook.yml 설정
1. `./config/facebook.yml.sample`파일의 복사본 생성.
2. `./config/facebook.yml`로 복사본의 이름을 변경.
3. development와 test 항목의 `:app_id`와 `:app_secret`을 개설한 앱의 `app_id` 와 `app_secret` 으로 변경.

localhost:3000 을 개발 서버 주소로 사용 가능하다면 3번 과정과 Facebook 앱 개설 과정은 생략 가능합니다.
## email.yml 설정
1. `./config/email.yml.sample`파일의 복사본 생성.
2. `./config/email.yml`로 복사본의 이름을 변경.
3. development와 test 항목의 `:user_name`과 `:password`에 본인의 이메일 주소와 비밀번호를 입력.

## 번들링
`bundle`
## 개발 데이터베이스 세팅
`rake db:migrate`
## 어드민 계정 생성
`rake db:seed`

[유저별 권한 설정방법(the_role)](https://github.com/the-teacher/the_role)

| id                        | password |
|---------------------------|----------|
| admin@farmfarmmentor.org  | 12341234 |

## 서버 실행
`rails s`

rails에서의 view 작업 시 유의사항
============================

## 링크 삽입
### 외부링크
`<a href="http://google.com">구글</a>`

`<%= link_to "구글", "http://google.com" >`
### 내부 링크
`<a href="/">첫화면으로</a>`

`<%= link_to "첫화면으로", "root_path" >`
이 때 `root_path`와 같은 각 페이지의 별칭은 터미널에서 `rake routes`로 확인 할 수 있습니다. ^^
## 이미지 삽입
### html
`<img src="images/logo.png">`

`<%= image_tag "logo.png">`

`image_tag`를 쓰지 않으면 rails가 이미지 이름 뒤에 임의로 생성해 붙인 hash코드를 읽을 수 없어요 ㅠㅠ

#### class나 id 같은 속성 삽입이 필요하면?
`<%= image_tag "logo.png", class: "logo", id: "farmfarm-logo", alt: "팜팜멘토 로고">`
### css
`background:url('../images/bg.png');`

`background:asset-url('bg.png');`

`url`대신 `asset-url`을 쓰지 않으면 rails가 이미지 이름 뒤에 임의로 생성해 붙인 hash코드를 읽을 수 없어요 ㅠㅠ
### js
`origsrc.attr('src', 'images/droppointer-up.png');`

`origsrc.attr('src', '<%= asset_path("droppointer-up.png") %>');`

위와 같이 `asset_path` 로 이미지를 걸어주세요. 또한 해당 js파일은 확장자를 *.js.erb로 변경해주세요.
## html에 이미지 링크 걸 때는?
`<a href="/"><img src="image/logog.png"></a>`

`<%= link_to image_tag("main_logo.png"), root_path %>`

javascript 파일 다루기
===================
Rails는 웹페이지 로딩 속도 향상을 위해 Asset Pipeline 이란 기능을 도입했습니다.
프로젝트에 삽입되는 모든 style sheet 파일과 javascript 파일을 최소화하고 압축해 각각을 하나의 파일로 만들어 로딩 속도를 최적화합니다. 문제는 **하나의** 파일에 모든 js 파일이 합쳐지다보니 namespace 문제가 생길 수 있다는 것입니다.
예를들어 `home/index`와 `faq/index` 양쪽에서 js를 로딩하기 위해 `$(document).ready`를 사용하는 경우 각각의 파일이 하나의 파일로 합쳐져 overloading 되어버립니다. `home/index`에서는 슬라이더가 휙휙 도는데, `faq/index`에서는 펼침 박스가 열리지 않는 문제가 발생합니다. 이를 방지하기 위해 본 프로젝트에서는 `paloma gem`을 사용하여 js파일을 관리합니다.

1. js 파일의 이름은 `index`, `show`, `edit`, `new`와 같은 액션의 이름으로 지정합니다.
2. 생성한 js파일은 `app/assets/javascripts/paloma/{controller}` 안으로 넣어둡니다.
3. `home/index` 에서 쓰이는 `index.js` 파일의 경로는 `app/assets/javascripts/paloma/home/index.js` 입니다.
4. 해당 컨트롤러 폴더가 아직 만들어지지 않았다면 터미널에서 `rails g paloma:add home index new edit`와 같이 만들 수 있습니다.
5. `jcarousellite_1.0.1.min` 나 `jquery.bxslider.min` 과 같은 외부에서 다운받은 js 라이브러리는 `/vendor/assets/javascripts` 안에 넣어둡니다.
6. 외부 js 라이브러리를 활성화하기 위해서는 `app/assets/javascripts/application.js` 파일을 열어 `//= require jcarousellite_1.0.1.min` 과 같은 식으로 추가해줍니다.

모델간 관계
========
## user, job 모델 설명

user는 job을 만들 수 있습니다.

이 때의 job은 work이라고 부릅니다.(앨리어싱)

이 때 job의 입장에서 본 user는 mentor입니다.

`````````````````````````````````````````````````````
shlee = User.where(name: "이수형")
apple_picking = shlee.works.create(title: "사과 수확")

puts apple_picking.mentor.name
이수형
=> nil

puts shlee.works.first.title
사과수확
=> nil
`````````````````````````````````````````````````````

job과 work은 같은 테이블을 쓰지만 역할이 각기 다릅니다.
멘토 shlee는 현재 work은 가지고 있지만, job은 가지고 있지 않습니다.

`````````````````````````````````````````````````````````
puts shlee.jobs.first.title
NoMethodError: undefined method `title' for nil:NilClass

`````````````````````````````````````````````````````````

user는 만들어진 job에 참여할 수 있습니다.

이 때 job의 입장에서 본 user는 mentee입니다.

```````````````````````````````````````````
apple_picking = Job.where(title: "사과 수확")
onesup = User.find_by_name("이원섭").first
apple_picking.mentees << onesup

puts apple_picking.mentees.last.name
이원섭
=> nil

puts onesup.jobs.first.title
사과수확
=> nil

```````````````````````````````````````````
멘티 onesup은 job은 가지고 있지만 work은 가지고 있지 않습니다.
```````````````````````````````````````````````````````````
puts onesup.works.first.title
NoMethodError: undefined method `title' for nil:NilClass
```````````````````````````````````````````````````````````


job을 **만든** 사람을 보기 위해서는
````````````````
job = Job.first
job.mentor
````````````````

job에 **참여한** 사람들을 보기 위해서는

`job.mentees`

user가 **만든** job을 보기 위해서는
``````````````````
user = User.first
user.wokrs
``````````````````

user가 **참여한** job을 보기 위해서는

`user.jobs`

user, job 모델간의 관계는 이렇게 정리됩니다.
