require "json"

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
    #   "userType": "customer",
    #   "userName": "谷　浩一",
    #   "userNamePhoneticName": "タニ　コウイチ",
    #   "password": "$2b$10$Zn2HSiSF5azhKTKQXH4wOOg./9Vbpcv3MrA44gV8HgyFN0SlUyE5K",
    #   "__v": 0,
    #   "forgotPassword": "08e51f10-45b7-4185-ae90-85baacbdee18" }

    # facility = {
    #   "_id": { "$oid": "61273b68f959d852d633bcc8" },
    #   "createdAt": { "$date": "2021-08-26T06:57:47.8Z" },
    #   "updatedAt": { "$date": "2021-09-21T20:50:59.743Z" },
    #   "No": 1,
    #   "companyName": "社会福祉法人　福友会",
    #   "types": [],
    #   "nextContractRenewal": { "$date": "2021-08-18T18:44:51.894Z" },
    #   "contractStatus": 0,
    #   "region": "未入力",
    #   "locality": "未入力",
    #   "street": "未入力",
    #   "phone": "未入力",
    #   "isDeleted": false,
    #   "version": 3,
    #   "name": "特別養護老人ホーム　うぐいすの里",
    #   "__v": 0,
    #   "address": "",
    #   "postalCode": "",
    #   "verified": false
    # }

    puts 'sentinel1'

    file_folder = Rails.root.join('lib', 'tasks')
    users = JSON.parse(File.read(file_folder.join('users.json')))
    facilities = JSON.parse(File.read(file_folder.join('facilities.json')))

    users.each do |user|
      instance = User.new(
        email: user['email']
      )

      facility = {} # TODO: facilityを検索

      instance.company.build(
        name: facility['companyName'],

      # Table name: companies
      #
      #  id                         :bigint           not null, primary key
      #  building                   :string
      #  city                       :string
      #  facility_name              :string
      #  name                       :string
      #  person_in_charge_name      :string
      #  person_in_charge_name_kana :string
      #  prefecture                 :string
      #  street                     :string
      #  tel                        :string
      #  zip                        :string
      #  created_at                 :datetime         not null
      #  updated_at                 :datetime         not null
      #



      )
    end

    puts users
  end
end
