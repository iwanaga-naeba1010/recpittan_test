require "json"
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

    file_folder = Rails.root.join('lib', 'tasks')
    users = JSON.parse(File.read(file_folder.join('users.json')))
    facilities = JSON.parse(File.read(file_folder.join('facilities.json')))
    # binding.pry

    # facilities.map { |f| f if f['_id']['$oid'] == '61273b68f959d852d633bcc8' }.compact.first

    ActiveRecord::Base.transaction do
      users.each do |user|
        instance = User.new(
          email: user['email'],
          role: user['userType'] == 'customer' ? :customer : :partner,
          password: [*'A'..'Z', *'a'..'z', *0..9].sample(16).join
        )
        instance.skip_confirmation_notification!

        if user['userType'] == 'customer'
          next if user['facilities'][0].blank?

          facility = facilities.map { |f| f if f['_id']['$oid'] ==  user['facilities'][0]['$oid'] }.compact.first
          # Plan tableも関係するので、その調整も必要
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
        end
        instance.save
      end
    end
  rescue StandardError => e
    puts e
  end
end
