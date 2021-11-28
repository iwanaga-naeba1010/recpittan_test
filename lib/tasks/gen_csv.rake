# frozen_string_literal: true
require 'csv'

namespace :gen_csv do
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
    # task = {
    #   "_id":{"$oid":"61528f35e00e30bc81acd4fa"},
    #   "createdAt":{"$date":"2021-09-28T03:42:45.262Z"},
    #   "updatedAt":{"$date":"2021-09-25T02:00:35.588Z"},
    #   "orderNote":"リクエスト内容\n\nまずは相談したい\n\n希望日時\n1:2021/11/01 ー:ー~ー:ー\n\n希望人数\n10人\n\n住所\n青森県\n\n相談したい事\nテスト",
    #   "status":10,
    #   "numberOfPeople":10,
    #   "facilityPrice":17600,
    #   "facilityMaterialPrice":0,
    #   "facilityTransportPrice":0,
    #   "facilityExtraExpensePrice":0,
    #   "instructorCost":13000,
    #   "instructorMaterialCost":0,
    #   "instructorTransportCost":0,
    #   "instructorExtraExpenseCost":0,
    #   "instructorZoomIdPrice":0,
    #   "additionalCount":0,
    #   "projectNumber":"EVC2109-0001",
    #   "comment":"",
    #   "note":"",
    #   "postalCode":"",
    #   "region":"",
    #   "locality":"",
    #   "street":"",
    #   "address":"",
    #   "adjustmentCost":0,
    #   "zoomInfo":"",
    #   "facilityAdditionalPrice":2000,
    #   "instructorAdditionalPrice":1000,
    #   "showChat":true,
    #   "isInstructorPaid":false,
    #   "isDeleted":false,
    #   "version":3,
    #   "recreationId":{"$oid":"614a23082e8c63292b5efcd0"},
    #   "facilityId":{"$oid":"61273b68f959d852d633bcc8"},
    #   "createUserId":{"$oid":"61273b6bf959d852d633bccb"},
    #   "orderType":"consult",
    #   "instructorId":{"$oid":"61481dd457d22bf1372b5440"},
    #   "__v":0
    # },

    file_folder = Rails.root.join('lib', 'tasks')
    users = JSON.parse(File.read(file_folder.join('users.json')))
    facilities = JSON.parse(File.read(file_folder.join('facilities.json')))
    recreations = JSON.parse(File.read(file_folder.join('recreations.json')))
    tasks = JSON.parse(File.read(file_folder.join('tasks.json')))
    messages = JSON.parse(File.read(file_folder.join('messages.json')))

    parsed_data = []
    # binding.pry

    tasks.each do |task|
      facility = facilities.map { |f| f if f['_id']['$oid'] == task['facilityId']['$oid'] }.compact.first
      user = users.map { |f|
        next if f['facilities'].blank?

        f if f['facilities'][0]['$oid'] == task['facilityId']['$oid']
      }.compact.first
      recreation = recreations.map { |r| r if r['_id']['$oid'] == task['recreationId']['$oid'] }.compact.first

      parsed_data << [
        task['projectNumber'],
        facility['name'],
        user['userName'],
        recreation['name'],
        recreation['instructorName'],
        task['status'],
        '',
        task['numberOfPeople'],
        recreation['targetPersons'],
        "#{task['postalCode']}#{task['region']}#{task['locality']}#{task['street']}#{task['address']}",
        task['orderNote'],
        task['additionalCount'],
      ]
      # puts task['projectNumber']
      # puts task['projectNumber']
    end

    CSV.open('./gen.csv', 'w') do |csv|
      csv << [
        '案件 No',
        '施設名',
        '施設担当者',
        'レク名',
        'レクパートナー名',
        'ステータス',
        '希望日時',
        '希望人数',
        '介護度目安',
        '住所',
        '相談したいこと',
        '追加施設数',
      ]
      parsed_data.map { |data| csv << data }
    end

  end
end
