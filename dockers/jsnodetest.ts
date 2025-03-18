console.log("test reactSrc")

import { xapikeyenv } from '/app/app/javascript/utils/getdotenv';


// import { xapikeyenv } from '/app/node_modules/dotenv';
console.log("key");
console.log(xapikeyenv);

import { findAllPrefectures } from '/app/app/javascript/packs/prefectures';
// import { findCityByPrefectureCode } from '/app/app/javascript/packs/prefectures';
   
console.log(findAllPrefectures);

console.log("list prefs");

findAllPrefectures().then((data) => {
     console.log(data)
})


// const getaddress = async (): Primise<void> => {
//  const prefs =  await findAllPrefectures();
//   return prefs;
// })

// var ret = getaddress();
var ret = "";
console.log("");
console.log("");
console.log("");
console.log(ret);



// const ret  = axios.get<PrefectureResponse>(
//     'https://opendata.resas-portal.go.jp/api/v1/prefectures',
//     {
//       headers: { 'X-API-KEY': xapikeyenv },
//     }
//   ).then((data) => {
//     console.log(data);
//   });    

// console.log("get aios");
// console.log(ret);
//ret.then((data) = {
//  console.log(data);
//  });

// findAllPrefectures.then((data) => {
//   console.log(data);
//  });
// const { data }  = await findAllPrefectures();

// console.log(data);



