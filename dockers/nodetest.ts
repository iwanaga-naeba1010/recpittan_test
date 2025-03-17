console.log("test reactSrc")
import axios, { AxiosResponse } from 'axios';


import { xapikeyenv } from '@/utils/dotenv';
console.log(xapikeyenv);

import { findAllPrefectures } from '@/utils/address';
import { findAddressByZip } from '@/utils/address';


// console.log(findAllPrefectures);

console.log("list prefs");

findAllPrefectures().then((data) => {
    console.log(data)
  })


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



