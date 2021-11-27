require 'json'
require 'pry'

namespace :store_json_data do
  task run: :environment do
    # user = {
    #   "_id": { "$oid": "61273b6bf959d852d633bccb" },
    #   "createdAt": { "$date": "2021-08-26T06:57:48.182Z" },
    #   "updatedAt": { "$date": "2021-09-28T09:49:15.289Z" },
    #   "profile": { "lastName": "", "firstName": "", "lastPhoneticName": "", "firstPhoneticName": "", "isCompany": false, "phone": "", "postalCode": "", "region": "", "locality": "", "street": "", "address": "", "bankName": "", "bankCode": "", "bankBranchName": "", "bankBranchNumber": "", "bankAccountType": "", "bankAccountName": "", "bankAccountNumber": "", "_id": { "$oid": "61273b6bf959d852d633bccc" } },
    #   "facilities": [{ "$oid": "61273b68f959d852d633bcc8" }],
    #   "isDeleted": false,
    #   "isEmailActive": false,
    #   "lastLoggedAt": { "$date": "2021-09-28T09:49:15.286Z" },
    #   "version": 3,
    #   "acceptInfo": { "date": { "$date": "2021-09-28T09:49:15.286Z" }, "ip": "114.180.183.16" },
    #   "email": "tani.koichi7@gmail.com",
    #   "No": 1,
    #   "userType": "customer",ok
    #   "userName": "谷　浩一",ok
    #   "userNamePhoneticName": "タニ　コウイチ",ok
    #   "password": "$2b$10$Zn2HSiSF5azhKTKQXH4wOOg./9Vbpcv3MrA44gV8HgyFN0SlUyE5K",
    #   "__v": 0,
    #   "forgotPassword": "08e51f10-45b7-4185-ae90-85baacbdee18" }

    # facility = {
    #   "_id": { "$oid": "61273b68f959d852d633bcc8" },
    #   "createdAt": { "$date": "2021-08-26T06:57:47.8Z" },
    #   "updatedAt": { "$date": "2021-09-21T20:50:59.743Z" },
    #   "No": 1,ok
    #   "companyName": "社会福祉法人　福友会",ok
    #   "types": [],
    #   "nextContractRenewal": { "$date": "2021-08-18T18:44:51.894Z" },
    #   "contractStatus": 0,
    #   "region": "未入力",ok
    #   "locality": "未入力",ok
    #   "street": "未入力",ok
    #   "phone": "未入力",ok
    #   "isDeleted": false,
    #   "version": 3,ok
    #   "name": "特別養護老人ホーム　うぐいすの里",ok
    #   "__v": 0,ok
    #   "address": "",ok
    #   "postalCode": "",ok
    #   "verified": false
    # }
    # recreation = {
    #   "_id":{"$oid":"614620b9631729d898e5bf94"},
    #   "createdAt":{"$date":"2021-09-18T17:24:09.784Z"},
    #   "updatedAt":{"$date":"2021-10-21T13:22:17.384Z"},
    #   "code":"E170001",
    #   "flyerColor":"blue",ok
    #   "prefectures":["23"],
    #   "regularPrice":33800,ok
    #   "regularMaterialPrice":0,ok
    #   "instructorMaterialAmount":0,ok
    #   "title":"寄席や演芸場に行った気分で大爆笑",ok
    #   "description":"落語や演芸は予め収録されたTV番組や動画などの映像よりもライブで観るのが数倍数十倍数百倍もよりたのしめます。オンラインでの生配信により同じ時間を共有する事によって寄席や演芸場に行った気分でお笑い頂きます。",ok
    #   "capacity":0,ok
    #   "targetPersons":["軽度認知症", "ほぼ自立", "介護度2以下が多い", "寝たきり"],
    #   "requiredTime":45,ok
    #   "flowOfDay":"寄席で演じてるように簡単な自己紹介から小噺を喋って落語を１席で３０分くらい。ご希望の時間に応じて長くも短くも時間調整は可能です。落語の演目によって短いのもあれば長いものもあるので、短い演目を２、３席とか長い演目をたっぷりとか。他に「南京玉すだれ」や「踊り」などの余興芸も披露できます。",ok
    #   "borrowItem":"-",ok
    #   "bringYourOwnItem":"-",ok
    #   "tags":["話題性あり", "行事", "男性にも人気", "プロ", "ほぼ自立", "軽度認知症", "介護度2以下", "スタッフ見守りのみ", "鑑賞型"],
    #   "instructorPosition":"-",
    #   "instructorName":"昔昔亭桃之助",
    #   "instructorProfile":"時間の調整はいくらでも。短い演目で数席、または長い演目でたっぷり、はたまた漫談や小噺、南京玉すだれ、踊り等々お時間の都合に合わせて演じます。また、謝礼額もご相談に応じます。",
    #   "extraInformation":"<p><br></p><p><br></p>",ok
    #   "reviewCount":0,
    #   "bookmarkCount":0,
    #   "isPublic":true,ok
    #   "isDeleted":false,
    #   "version":3,
    #   "name":"オンライン落語会　",ok
    #   "baseCode":"E17",
    #   "instructorId":{"$oid":"6146131cd50760d4fde589de"},
    #   "instructorAmount":25000,ok
    #   "media":[{"fileId":"", "_id":{"$oid":"61462303631729d898e5bfdc"}, "type":"video", "videoId":"S1YfmVN3oHc"}, {"fileId":"61462302d8ed50d8708b20e7", "_id":{"$oid":"61462303631729d898e5bfdd"}, "type":"picture", "videoId":""}],
    #   "instructorImage":{"$oid":"61462060631729d898e5bf57"}, "__v":7}

    file_folder = Rails.root.join('lib', 'tasks')
    users = JSON.parse(File.read(file_folder.join('users.json'))).map { |user| user if user['userType'] != 'customer' }.compact # TODO: 本番はここ外す
    facilities = JSON.parse(File.read(file_folder.join('facilities.json')))
    recreations = JSON.parse(File.read(file_folder.join('recreations.json')))
    # binding.pry
    data = nil
    ActiveRecord::Base.transaction do
      users.each do |user|
        instance = User.new(
          email: user['email'],
          username: user['userName'],
          username_kana: user['userNamePhoneticName'],
          role: user['userType'] == 'customer' ? :customer : :partner,
          password: [*'A'..'Z', *'a'..'z', *0..9].sample(16).join
        )
        instance.skip_confirmation_notification!

        if user['userType'] == 'customer'
          next if user['facilities'][0].blank?

          facility = facilities.map { |f| f if f['_id']['$oid'] ==  user['facilities'][0]['$oid'] }.compact.first
          # TODO: Plan tableも関係するので、その調整も必要
          instance.build_company(
            name: facility['companyName'],
            facility_name: facility['name'],
            # prefecture: JpPrefecture::Prefecture.find(13)
            zip: facility['postalCode'],
            street: facility['street'],
            address: facility['address'],
            region: facility['region'],
            locality: facility['locality'],
            person_in_charge_name: facility['userName'],
            person_in_charge_name_kana: facility['userNamePhoneticName'],
          )
        elsif user['userType'] == 'instructor'
          next if user['_id']['$oid'].blank?

          # NOTE: recreationsは複数ある場合あるので、複数で
          recs = recreations.map { |f| f if f['instructorId']['$oid'] ==  user['_id']['$oid'] }.compact

          next if recs.blank?

          # TODO: YoutubeIdを取得する
          recs.each do |rec|
            youtube_id = rec['media'].map { |media| media['videoId'] if media['videoId'].present? }.compact.first
            if youtube_id
              puts youtube_id
            end
            new_rec = instance.recreations.build(
              flyer_color: rec['flyerColor'],
              prefectures: rec['prefectures'],
              regular_price: rec['regularPrice'], # NOTE: ここが表示価格
              regular_material_price: rec['regularMaterialPrice'],
              instructor_material_amount: rec['instructorMaterialAmount'],
              title: rec['name'],
              second_title: rec['title'],
              description: rec['description'],
              capacity: rec['capacity'],
              minutes: rec['requiredTime'],
              flow_of_day: rec['flowOfDay'],
              borrow_item: rec['borrowItem'],
              bring_your_own_item: rec['bringYourOwnItem'],
              is_public: rec['isPublic'],
              extra_information: rec['extraInformation'],
              instructor_amount: rec['instructorAmount'],
              base_code: rec['baseCode'],
              instructor_name: rec['instructorName'],
              instructor_title: rec['instructorPosition'],
              instructor_description: rec['instructorProfile'],
              youtube_id: youtube_id.present? ? youtube_id : '',
            )

            # NOTE: targetのタグを作成 or 検索して追加
            rec['targetPersons'].each do |target|
              tag = Tag.find_or_create_by(name: target, kind: :target)
              new_rec.tags << tag
            end

            # NOTE: 通常のtagを作成 or 検索して追加
            rec['tags'].each do |t|
              tag = Tag.find_or_create_by(name: t, kind: :tag)
              new_rec.tags << tag
            end

            # NOTE: 色付きラベルのcategoryを作成 or 検索して追加
            category = code_to_tag(rec['baseCode'].split(rec['baseCode'].first)[1])
            if category.present?
              new_rec.tags << category
            end
            # NOTE: baseCodeがYで吉本なら吉本のタグを作成 or 検索して追加
            if rec['baseCode'].first == 'Y'
              new_rec.tags << Tag.find_or_create_by(name: '吉本', kind: :tag)
            end
            # NOTE: baseCodeが10以上でオンラインならオンラインのタグを作成 or 検索して追加
            if rec['baseCode'].split(rec['baseCode'].first)[1].to_i >= 10
              new_rec.is_online = true
              # new_rec.tags << Tag.find_or_create_by(name: 'オンライン', kind: :tag)
            end
          end
        end

        # data = instance
        instance.save!
      end
    end
  rescue StandardError => e
    puts e
  end

  def code_to_tag(code)
    # 01:音楽
    # 02:健康
    # 03:趣味
    # 04:創作
    # 05:旅行
    # 06:食べ物
    # 07:イベント
    # 08:その他
    # 09:使用不可
    # 10:なんでも
    # 11:音楽
    # 12:健康
    # 13:趣味
    # 14:創作
    # 15:旅行
    # 16:食べ物
    # 17:イベント
    # 18:その他
    # 19:使用不可
    case code
    when '01', '11'
      Tag.find_or_create_by(name: '音楽', kind: :category)
    when '02', '12'
      Tag.find_or_create_by(name: '健康', kind: :category)
    when '03', '13'
      Tag.find_or_create_by(name: '趣味', kind: :category)
    when '04', '14'
      Tag.find_or_create_by(name: '創作', kind: :category)
    when '05', '15'
      Tag.find_or_create_by(name: '旅行', kind: :category)
    when '06', '16'
      Tag.find_or_create_by(name: '食べ物', kind: :category)
    when '07', '17'
      Tag.find_or_create_by(name: 'イベント', kind: :category)
    when '08', '18'
      Tag.find_or_create_by(name: 'その他', kind: :category)
    end
  end
end
